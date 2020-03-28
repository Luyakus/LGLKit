//
//  main.m
//  opengl-lesson-3
//
//  Created by Sam on 2020/1/29.
//  Copyright © 2020 Sam. All rights reserved.
//

#include <glad/glad.h>
#include <GLFW/glfw3.h>
#import <Foundation/Foundation.h>

void processInput(GLFWwindow *w) {
    if (glfwGetKey(w, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
        glfwSetWindowShouldClose(w, true);
    }
}

void windowSizeChangeCallback(GLFWwindow *w, int width, int height) {
    glViewport(0, 0, width, height);
}

NSString *shaderSource(NSString *path) {
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
}

int compileShader(NSString *src, GLenum shaderType) {
    int success;
    char infoLog[512];
    const char *cSrc = (const char *)src.UTF8String;
    GLuint shader = glCreateShader(shaderType);
    glShaderSource(shader, 1, &cSrc, NULL);
    glCompileShader(shader);
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
        glGetShaderInfoLog(shader, 512, NULL, infoLog);
        NSLog(@"%@ 编译失败 %s", src, infoLog);
        return -1;
    }
    return shader;
}

int createProgramWithShader(int vertexShader, int fragmentShader) {
    int success;
    char infoLog[512];
    GLuint program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    
    glGetProgramiv(program, GL_LINK_STATUS, &success);
    if (!success) {
        glGetProgramInfoLog(program, 512, NULL, infoLog);
        NSLog(@"shader 链接失败 %s", infoLog);
        return -1;
    }
    
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);

    return program;
}

int bindOpenglObject() {
    GLuint vao, vbo, ebo;
    float vertices[] = {
           -0.5, -0.5, 0.0,
            0.5, -0.5, 0.0,
            0.5,  0.5, 0.0,
           -0.5,  0.5, 0.0,
    };
    
    int indecies[] = {
        0, 1, 2,
        2, 3, 0
    };
    glGenVertexArrays(1, &vao);
    glGenBuffers(1, &vbo);
    glGenBuffers(1, &ebo);
    
    glBindVertexArray(vao);
    
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indecies), indecies, GL_STATIC_DRAW);
    
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void *)(3 * sizeof(float)));
    glEnableVertexAttribArray(1);

    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
    return vao;
}

void passUniform(GLuint program) {
    float time =  glfwGetTime();
    float red = (sin(time) / 2.0f) + 0.5f;
    int location = glGetUniformLocation(program, "changeAlpha");
    glUniform4f(location, red, 0, 0, 1);
}

void glfwInitialize() {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
}

const int width = 800;
const int height = 600;

int main(int argc, const char * argv[]) {
    glfwInitialize();
    
    GLFWwindow *w = glfwCreateWindow(width, height, "opengl-lesson-3", NULL, NULL);
    if (!w) {
        NSLog(@"window 创建失败");
        return -1;
    }
    
    glfwMakeContextCurrent(w);
    glfwSetFramebufferSizeCallback(w, windowSizeChangeCallback);
    
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        NSLog(@"glad 初始化失败");
        return -1;
    }
    
    NSString *vertPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-3/vert.glsl";
    NSString *fragPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-3/frag.glsl";
    int vertexShader = compileShader(shaderSource(vertPath), GL_VERTEX_SHADER);
    int fragShader = compileShader(shaderSource(fragPath), GL_FRAGMENT_SHADER);
    int program = createProgramWithShader(vertexShader, fragShader);
    
    int vao = bindOpenglObject();
//    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

    while (!glfwWindowShouldClose(w)) {
        processInput(w);
        
        glClearColor(0.1, 0.2, 0.3, 1);
        glClear(GL_COLOR_BUFFER_BIT);
        
        glUseProgram(program);
        
        passUniform(program);
        
        glBindVertexArray(vao);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
//        glDrawArrays(GL_TRIANGLES, 0, 3);
        
        glfwSwapBuffers(w);
        glfwPollEvents();
    }
    glfwTerminate();
    return 0;
}
