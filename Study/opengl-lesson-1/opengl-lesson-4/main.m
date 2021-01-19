//
//  main.m
//  opengl-lesson-4
//
//  Created by Sam on 2020/1/30.
//  Copyright © 2020 Sam. All rights reserved.
//
#include <GLFW/glfw3.h>
#include "stb_image.h"
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
//
//void glfwInitialize() {
//    glfwInit();
//    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
//    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
//    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
//    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
//}
//
//GLFWwindow *createWindow(int width, int height, NSString *title, GLFWframebuffersizefun callback) {
//    GLFWwindow *w = glfwCreateWindow(width, height, title.UTF8String, NULL, NULL);
//    glfwMakeContextCurrent(w);
//    glfwSetFramebufferSizeCallback(w, callback);
//    return w;
//}
//
//void gladLoadGlfw() {
//    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
//        NSLog(@"初始化glad 失败");
//        exit(-1);
//    }
//}
//
//NSString *shaderSource(NSString *path) {
//    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding
//                                        error:nil];
//}
//
//GLuint compileShader(NSString *source, GLenum shaderType) {
//    GLuint shader = glCreateShader(shaderType);
//    const char *src = (const char *)source.UTF8String;
//    glShaderSource(shader, 1, &src, NULL);
//    glCompileShader(shader);
//    int success;
//    char infoLog[512];
//    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
//    if (!success) {
//        glGetShaderInfoLog(shader, 512, NULL, infoLog);
//        NSLog(@"%@ 编译失败 %s", source, infoLog);
//        exit(-1);
//    }
//    return shader;
//}
//
//GLuint createProgram(int vertextShader, int fragmengtShader) {
//    GLuint program = glCreateProgram();
//    glAttachShader(program, vertextShader);
//    glAttachShader(program, fragmengtShader);
//    glLinkProgram(program);
//    int success;
//    char infoLog[512];
//    glGetProgramiv(program, GL_LINK_STATUS, &success);
//    if (!success) {
//        glGetProgramInfoLog(program, 512, NULL, infoLog);
//        NSLog(@"shader link 失败: %s", infoLog);
//        exit(-1);
//    }
//    return program;
//}
//
//
//
//float vertices[] = {
//    -0.5, -0.5, 1, 0, 0,
//     0.5, -0.5, 1, 1, 0,
//     0.5,  0.5, 1, 1, 1,
//    -0.5,  0.5, 1, 0, 1,
//};
//
//GLuint indecies[] = {
//    0, 1, 2,
//    2, 3, 0,
//};
//
//GLuint bindOpenglObject() {
//    GLuint vao, vbo, ebo;
//    glGenVertexArrays(1, &vao);
//    glGenBuffers(1, &vbo);
//    glGenBuffers(1, &ebo);
//
//    glBindVertexArray(vao);
//    glBindBuffer(GL_ARRAY_BUFFER, vbo);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
//
//    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
//    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indecies), indecies, GL_STATIC_DRAW);
//
//    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void *)0);
//    glEnableVertexAttribArray(0);
//
//    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void *)(3 * sizeof(float)));
//    glEnableVertexAttribArray(1);
//
//    glBindBuffer(GL_ARRAY_BUFFER, 0);
//    glBindVertexArray(0);
//
//    return vao;
//}
//
//
//GLuint createTexture(NSString *path) {
//    GLuint texture;
//    glGenTextures(1, &texture);
//    glBindTexture(GL_TEXTURE_2D, texture);
//
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
//
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
//    int width, height, nrchannel;
//    stbi_set_flip_vertically_on_load(true);
//    unsigned char *data = stbi_load(path.UTF8String, &width, &height, &nrchannel, 0);
//    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
//    glGenerateMipmap(GL_TEXTURE_2D);
//
//    stbi_image_free(data);
//    return texture;
//}
//
//
////GLuint createTexture(NSString *path) {
////    GLuint texture;
////    glGenTextures(1, &texture);
////    glBindTexture(GL_TEXTURE_2D, texture);
////    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
////    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
////
////    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
////    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
////    stbi_set_flip_vertically_on_load(true);
////    int width, height, nrchannel;
////    unsigned char *data = stbi_load(path.UTF8String, &width, &height, &nrchannel, 0);
////    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, data);
////    glGenerateMipmap(GL_TEXTURE_2D);
////    stbi_image_free(data);
////    return texture;
////}
//
//
//void windowSizeChangeCallback(GLFWwindow *w, int width, int height) {
//    glViewport(0, 0, width, height);
//}
//
//int main(int argc, char *argv[]) {
//    glfwInitialize();
//    GLFWwindow *w = createWindow(800, 600, @"opengl-lesson-4", windowSizeChangeCallback);
//    gladLoadGlfw();
//
//    NSString *vertexPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-4/vert.glsl";
//    NSString *fragmentPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-4/frag.glsl";
//    GLuint vertexShader = compileShader(shaderSource(vertexPath), GL_VERTEX_SHADER);
//    GLuint fragmentShader = compileShader(shaderSource(fragmentPath), GL_FRAGMENT_SHADER);
//    GLuint program = createProgram(vertexShader, fragmentShader);
//
//    GLuint vao = bindOpenglObject();
//
//    GLuint texture1 = createTexture(@"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-4/123.png");
//    GLuint texture2 = createTexture(@"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-4/abc.png");
//
//    glUseProgram(program);
//    glUniform1i(glGetUniformLocation(program, "texture1"), 0);
//    glUniform1i(glGetUniformLocation(program, "texture2"), 1);
//
//    while (!glfwWindowShouldClose(w)) {
//        if (glfwGetKey(w, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
//            glfwSetWindowShouldClose(w, true);
//        }
//        glClearColor(0.1, 0.2, 0.3, 1);
//        glClear(GL_COLOR_BUFFER_BIT);
//
//        glActiveTexture(GL_TEXTURE0);
//        glBindTexture(GL_TEXTURE_2D, texture1);
//
//        glActiveTexture(GL_TEXTURE1);
//        glBindTexture(GL_TEXTURE_2D, texture2);
//
//        glUseProgram(program);
//        glBindVertexArray(vao);
//        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
//
//        glfwSwapBuffers(w);
//        glfwPollEvents();
//    }
//    glfwTerminate();
//    return 0;
//}


void glfwInitilize() {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
}

GLFWwindow *createWindow(int width, int height, GLFWframebuffersizefun callback) {
    GLFWwindow *w = glfwCreateWindow(width, height, "opengl-lesson-4", NULL, NULL);
    glfwMakeContextCurrent(w);
    glfwSetFramebufferSizeCallback(w, callback);
    return w;
}

NSString *shaderSource(NSString *path) {
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

GLuint compileShader(NSString *source, GLenum shaderType) {
    GLuint shader = glCreateShader(shaderType);
    const char *src = (const char *)source.UTF8String;
    glShaderSource(shader, 1, &src, NULL);
    glCompileShader(shader);
    int success;
    char infoLog[512];
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
        glGetShaderInfoLog(shader, 512, NULL, infoLog);
        NSLog(@"%@ 编译失败 %s", source, infoLog);
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
        NSLog(@"shader链接失败 %s", infoLog);
        exit(-1);
    }
    return program;
}

float vertexs[] = {
    -0.5, -0.5, 0,
     0.5, -0.5, 0,
     0.5,  0.5, 0,
    -0.5,  0.5, 0,
};

float textureVertexs[] = {
    0, 0,
    1, 0,
    0, 1,
    1, 1
};

float colors[] = {
    1, 0, 0,
    0, 1, 0,
    0, 1, 1,
    0.1, 0, 1
};

GLuint indecies[] = {
    0, 1, 2,
    2, 3, 0
};

GLuint binOpenglObject() {
    GLuint vao, vbo0, vbo1, vbo2, ebo;
    glGenVertexArraysAPPLE(1, &vao);
    glGenBuffers(1, &vbo0);
    glGenBuffers(1, &vbo1);
    glGenBuffers(1, &vbo2);
    glGenBuffers(1, &ebo);
    
    glBindVertexArrayAPPLE(vao);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indecies), indecies, GL_STATIC_DRAW);

    
    glBindBuffer(GL_ARRAY_BUFFER, vbo0);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexs), vertexs, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);
    
//    glBindBuffer(GL_ARRAY_BUFFER, vbo1);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(textureVertexs), textureVertexs, GL_STATIC_DRAW);
//
//    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void *)0);
//    glEnableVertexAttribArray(1);
//
//    glBindBuffer(GL_ARRAY_BUFFER, vbo2);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(colors), colors, GL_STATIC_DRAW);
//
//    glVertexAttribPointer(2, 2, GL_FLOAT, GL_FALSE, 2 * sizeof(float), (void *)0);
//    glEnableVertexAttribArray(2);
    
//    glBindBuffer(GL_ARRAY_BUFFER, 0);
//    glBindVertexArrayAPPLE(0);
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
    glBindTexture(GL_TEXTURE_2D, 0);
    stbi_image_free(data);
    return texture;
}


void windowSizeChangeCallback(GLFWwindow *w, int width, int height) {
    glViewport(0, 0, width, height);
}

int main(int argc, char *argv[]) {
    glfwInitilize();
    GLFWwindow *w = createWindow(800, 600, windowSizeChangeCallback);
    
    NSString *vpath = @"/Users/dz0400817/Desktop/iOS/LGLKit/Study/opengl-lesson-1/opengl-lesson-4/vert.glsl";
    GLuint vertexShader = compileShader(shaderSource(vpath), GL_VERTEX_SHADER);
    NSString *fpath = @"/Users/dz0400817/Desktop/iOS/LGLKit/Study/opengl-lesson-1/opengl-lesson-4/frag.glsl";
    GLuint fragmentShader = compileShader(shaderSource(fpath), GL_FRAGMENT_SHADER);
    GLuint program = createProgramWithShader(vertexShader, fragmentShader);
    
    GLuint vao = binOpenglObject();
    
    NSString *texturePath1 = @"/Users/dz0400817/Desktop/iOS/LGLKit/Study/opengl-lesson-1/opengl-lesson-4/abc.png";
    GLuint texture1 = createTexture(texturePath1);
    
    NSString *texturePath2 = @"/Users/dz0400817/Desktop/iOS/LGLKit/Study/opengl-lesson-1/opengl-lesson-4/123.png";
    GLuint texture2 = createTexture(texturePath2);
    
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
        glBindVertexArrayAPPLE(vao);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, (void *)0);
        
        glfwSwapBuffers(w);
        glfwPollEvents();
    }
    glfwTerminate();
    return 0;
}
