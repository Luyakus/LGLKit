//
//  main.m
//  opengl-lesson-5
//
//  Created by Sam on 2020/2/2.
//  Copyright © 2020 Sam. All rights reserved.
//
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include "stb_image.h"

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


void glfwInitialize() {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
}

GLFWwindow *createWindow(int width, int height, GLFWframebuffersizefun callback) {
    GLFWwindow *w = glfwCreateWindow(width, height, "opengl-lesson-5", NULL, NULL);
    glfwMakeContextCurrent(w);
    glfwSetFramebufferSizeCallback(w, callback);
    return w;
}

void gladLoadglfw() {
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        NSLog(@"glad 初始化失败");
        exit(-1);
    }
}

GLuint createShader(NSString *shaderPath, GLuint shaderType) {
    const char *src = (const char *)[[NSString stringWithContentsOfFile:shaderPath encoding:NSUTF8StringEncoding error:nil] UTF8String];
    GLuint shader = glCreateShader(shaderType);
    glShaderSource(shader, 1, &src, NULL);
    glCompileShader(shader);
    int success;
    char infoLog[512];
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
        glGetShaderInfoLog(shader, 512, NULL, infoLog);
        NSLog(@"shader 编译失败 %s", infoLog);
        exit(-1);
    }
    return shader;
}

GLuint createProgramWithShader(int vertexShader, int fragmentShader) {
    GLuint program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    int success;
    char infoLog[512];
    glGetProgramiv(program, GL_LINK_STATUS, &success);
    if (!success) {
        glGetProgramInfoLog(program, 512, NULL, infoLog);
        NSLog(@"program 链接失败 %s", infoLog);
        exit(-1);
    }
    return program;
}

float vertexs[] = {
    -0.5, -0.5, 0, 0, 0,
     0.5, -0.5, 0, 1, 0,
     0.5,  0.5, 0, 1, 1,
    -0.5,  0.5, 0, 0, 1,
};

GLuint indecies[] = {
    0, 1, 2,
    2, 3, 0
};

GLuint bindOpenglObject() {
    GLuint vao, vbo, ebo;
    glGenVertexArrays(1, &vao);
    glGenBuffers(1, &vbo);
    glGenBuffers(1, &ebo);
    
    glBindVertexArray(vao);
    
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexs), vertexs, GL_STATIC_DRAW);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indecies), indecies, GL_STATIC_DRAW);
    
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);
    
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void *)(3 * sizeof(float)));
    glEnableVertexAttribArray(1);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
    
    return vao;
}

GLuint createTexture(NSString *path) {
    GLuint texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    
    stbi_set_flip_vertically_on_load(true);
    int width, height, nrchannel;
    unsigned char *data = stbi_load((const char *)path.UTF8String, &width, &height, &nrchannel, 0);
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);
    return texture;
}

void windowSizeChangeCallback(GLFWwindow *w, int width, int height) {
    glViewport(0, 0, width, height);
}

glm::mat4 createTransform() {
    glm::mat4 trans;
    trans = glm::translate(trans, glm::vec3(0.7, 0.7, 0));
    trans = glm::rotate(trans, (float)glfwGetTime(), glm::vec3(0.0, 0.0, 1.0));
    return trans;
}

int main(int argc, const char * argv[]) {
    glfwInitialize();
    GLFWwindow *w = createWindow(800, 600, windowSizeChangeCallback);
    gladLoadglfw();
    
    NSString *vertexShaderPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-5/vert.glsl";
    GLuint vertexShader = createShader(vertexShaderPath, GL_VERTEX_SHADER);
    NSString *fragmentShaderPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-5/frag.glsl";
    GLuint fragmentShader = createShader(fragmentShaderPath, GL_FRAGMENT_SHADER);
    GLuint program = createProgramWithShader(vertexShader, fragmentShader);
    
    GLuint vao = bindOpenglObject();

    NSString *pic1 = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-5/abc.png";
    GLuint texture1 = createTexture(pic1);

    NSString *pic2 = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-5/123.png";
    GLuint texture2 = createTexture(pic2);

    glUseProgram(program);
    glUniform1i(glGetUniformLocation(program, "texture1"), 0);
    glUniform1i(glGetUniformLocation(program, "texture2"), 1);
    
    while (!glfwWindowShouldClose(w)) {
        if (glfwGetKey(w, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
            glfwSetWindowShouldClose(w, true);
        }
        
        glClearColor(0.1, 0.2, 0.3, 1);
        glClear(GL_COLOR_BUFFER_BIT);
        
        glUseProgram(program);

        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, texture1);

        glActiveTexture(GL_TEXTURE1);
        glBindTexture(GL_TEXTURE_2D, texture2);
        
        
        glUniformMatrix4fv(glGetUniformLocation(program, "trans"), 1, GL_FALSE, glm::value_ptr(createTransform()));

        
        glBindVertexArray(vao);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
        
        glfwSwapBuffers(w);
        glfwPollEvents();
    }
    
    glfwTerminate();
    return 0;
}
