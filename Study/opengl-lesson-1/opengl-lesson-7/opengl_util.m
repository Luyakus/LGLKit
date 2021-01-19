//
//  opengl_util.m
//  opengl-lesson-util
//
//  Created by Sam on 2020/2/4.
//  Copyright © 2020 Sam. All rights reserved.
//
#import "opengl_util.h"
#include "stb_image.h"


void glfwInitialize() {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
}
void gladLoadGlfw() {
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        NSLog(@"glad 初始化失败");
        exit(-1);
    }
}
GLFWwindow *createWindow(int width, int height, NSString *title, GLFWframebuffersizefun callback) {
    GLFWwindow *w = glfwCreateWindow(width, height, title.UTF8String, NULL, NULL);
    glfwMakeContextCurrent(w);
    glfwSetFramebufferSizeCallback(w, callback);
    return w;
}
GLuint createShader(NSString *path, GLenum type) {
    GLuint shader = glCreateShader(type);
    const char *src = (const char *)[[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil] UTF8String];
    glShaderSource(shader, 1, &src, NULL);
    glCompileShader(shader);
    int success;
    char infoLog[512];
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
        glGetShaderInfoLog(shader, 512, NULL, infoLog);
        NSLog(@"%s 编译失败 %s", src, infoLog);
        exit(-1);
    }
    return shader;
}
GLuint createProgramWithShader(GLuint vertextShader, GLuint fragmentShader) {
    GLuint program = glCreateProgram();
    glAttachShader(program, vertextShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    int success;
    char infoLog[512];
    glGetProgramiv(program, GL_LINK_STATUS, &success);
    if (!success) {
        glGetProgramInfoLog(program, 512, NULL, infoLog);
        NSLog(@"program link 失败 %s", infoLog);
        exit(-1);
    }
    return program;
}

GLuint createTexture(NSString *path) {
    GLuint texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    
    int width, height, nrchannel;
    stbi_set_flip_vertically_on_load(GL_TRUE);
    unsigned char *data = stbi_load((const char *)path.UTF8String, &width, &height, &nrchannel, 0);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);
    stbi_image_free(data);
    return texture;
}
