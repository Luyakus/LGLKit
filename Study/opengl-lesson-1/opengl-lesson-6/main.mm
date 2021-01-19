//
//  main.m
//  opengl-lesson-6
//
//  Created by Sam on 2020/2/3.
//  Copyright © 2020 Sam. All rights reserved.
//
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include "stb_image.h"
#include "const.h"

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#import <Foundation/Foundation.h>

void glfwInitialize() {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
}

void windowSizeChangeCallback(GLFWwindow *w, int width, int height) {
    glViewport(0, 0, width, height);
}

GLFWwindow *createWindow(int width, int height, GLFWframebuffersizefun callback) {
    GLFWwindow *w = glfwCreateWindow(width, height, "opengl-lesson-6", NULL, NULL);
    if (!w) {
        NSLog(@"window 创建失败");
        exit(-1);
    }
    glfwMakeContextCurrent(w);
    glfwSetFramebufferSizeCallback(w, callback);
    return w;
}

void gladLoadGlfw() {
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        NSLog(@"glad 初始化失败");
        exit(-1);
    }
}

GLuint createShader(NSString *path, GLenum shaderType) {
    GLuint shader = glCreateShader(shaderType);
    const char *src = (const char *)[[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding
                                                                  error:nil] UTF8String];
    glShaderSource(shader, 1, &src, NULL);
    glCompileShader(shader);
    
    int success;
    char infoLog[512];
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
        glGetShaderInfoLog(shader, 512, NULL, infoLog);
        NSLog(@"编译 shader 失败 %s", infoLog);
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
        NSLog(@"link 失败 %s", infoLog);
        exit(-1);
    }
    return program;
}

GLuint createTextrure(NSString *path) {
    GLuint texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);

    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    int width, height, nrchannerl;
    stbi_set_flip_vertically_on_load(true);
    unsigned char *data = stbi_load(path.UTF8String, &width, &height, &nrchannerl, 0);
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
    glGenerateMipmap(GL_TEXTURE_2D);

    stbi_image_free(data);
    return texture;
}

GLuint bindOpenglObject() {
    GLuint vao, vbo;
    glGenVertexArrays(1, &vao);
    glGenBuffers(1, &vbo);
    
    glBindVertexArray(vao);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);
    
    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void *)(3 * sizeof(float)));
    glEnableVertexAttribArray(1);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
    
    return vao;
}

int main(int argc, const char * argv[]) {
    glfwInitialize();
    GLFWwindow *w = createWindow(800, 600, windowSizeChangeCallback);
    gladLoadGlfw();
    
    NSString *vertexShaderPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-6/vert.glsl";
    GLuint vertexShader = createShader(vertexShaderPath, GL_VERTEX_SHADER);
    NSString *fragmentShaderPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-6/frag.glsl";
    GLuint fragmentShader = createShader(fragmentShaderPath, GL_FRAGMENT_SHADER);
    GLuint program = createProgramWithShader(vertexShader, fragmentShader);
    
    GLuint vao = bindOpenglObject();
    
    NSString *texturePath1 = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-6/abc.png";
    GLuint texture1 = createTextrure(texturePath1);
    
    NSString *texturePath2 = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-6/123.png";
    GLuint texture2 = createTextrure(texturePath2);
    
    glUseProgram(program);

    glUniform1i(glGetUniformLocation(program, "texture1"), 0);
    glUniform1i(glGetUniformLocation(program, "texture2"), 1);
    
    glm::mat4 view; glm::mat4 projection;
    view  = glm::translate(view, glm::vec3(0, 0, -5.0f));
    projection = glm::perspective(glm::radians(45.0f), (float)800 / (float)600, 0.1f, 100.0f);
    
    glUniformMatrix4fv(glGetUniformLocation(program, "view"), 1, GL_FALSE, glm::value_ptr(view));
    glUniformMatrix4fv(glGetUniformLocation(program, "projection"), 1, GL_FALSE, glm::value_ptr(projection));

    
    while (!glfwWindowShouldClose(w)) {
        if (glfwGetKey(w, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
            glfwSetWindowShouldClose(w, false);
        }
        glEnable(GL_DEPTH_TEST);
        glClearColor(0.1, 0.2, 0.3, 1);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        
        glUseProgram(program);
        
        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, texture1);
        
        glActiveTexture(GL_TEXTURE1);
        glBindTexture(GL_TEXTURE_2D, texture2);
        
      
        glBindVertexArray(vao);
        
        for (int i = 0; i < 10; i ++) {
            glm::mat4 model;
            model = glm::translate(model, cubePositions[i]);
            model = glm::rotate(model, (float)(glfwGetTime() * (i + 1)), glm::vec3(1.0f, 0.3f, 0.5f));
            glUniformMatrix4fv(glGetUniformLocation(program, "model"), 1, GL_FALSE, glm::value_ptr(model));

            glDrawArrays(GL_TRIANGLES, 0, 36);
        }
        
        
        glfwSwapBuffers(w);
        glfwPollEvents();
    }
    
    glfwTerminate();
    return 0;
}
