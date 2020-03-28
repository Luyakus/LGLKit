//
//  main.m
//  opengl-lesson-8
//
//  Created by Sam on 2020/2/5.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <opengl_lesson_util/opengl_lesson_util.h>
#import "vertices.h"
#import "cube_positions.h"
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#import <Foundation/Foundation.h>

GLuint bindOpenglObject() {
    GLuint vao, vbo;
    glGenVertexArrays(1, &vao);
    glGenBuffers(1, &vbo);
    
    glBindVertexArray(vao);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);
    
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBindVertexArray(0);
    return vao;
}

int main(int argc, const char * argv[]) {
    glfwInitialize();
    GLFWwindow *w = createWindow(800, 600, @"opengl-lesson-8", NULL);
    gladLoadGlfw();
    
    NSString *vertexShaderPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-8/vert.glsl";
    GLuint vertexShader = createShader(vertexShaderPath, GL_VERTEX_SHADER);
    
    NSString *fragmentShaderPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-8/frag.glsl";
    GLuint fragmentShader = createShader(fragmentShaderPath, GL_FRAGMENT_SHADER);
    
    NSString *lightFragmentShaderPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-8/light_frag.glsl";
    GLuint lightFragmentShader = createShader(lightFragmentShaderPath, GL_FRAGMENT_SHADER);
    
    GLuint program = createProgramWithShader(vertexShader, fragmentShader);
    GLuint lightProgram = createProgramWithShader(vertexShader, lightFragmentShader);
    
    GLuint vao = bindOpenglObject();
    
    GLuint lightVao = bindOpenglObject();
    
    glm::mat4 model, lightModel, view, projection;

    model = glm::translate(model, cubePositions[4]);
    model = glm::rotate(model, glm::radians(30.0f), glm::vec3(0.1f, 0.2f, 0.3f));
    
    lightModel = glm::translate(lightModel, cubePositions[1]);
    lightModel = glm::rotate(lightModel, glm::radians(30.0f), glm::vec3(0.1f, 0.2f, 0.3f));
    
    view = glm::translate(view, glm::vec3(0.0f, 0.0f, -3.0f));
    projection = glm::perspective(glm::radians(45.0f), 800.0f/600.f, 0.1f, 100.0f);
    
    glEnable(GL_DEPTH_TEST);
    while (!glfwWindowShouldClose(w)) {
        if (glfwGetKey(w, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
            glfwSetWindowShouldClose(w, true);
        }
        
        glClearColor(0.1, 0.2, 0.3, 1);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        
        glUseProgram(program);
        glBindVertexArray(vao);
        glUniformMatrix4fv(glGetUniformLocation(program, "transform"), 1, 0, glm::value_ptr(projection * view * model));
        glDrawArrays(GL_TRIANGLES, 0, 36);
        
        glUseProgram(lightProgram);
        glBindVertexArray(lightVao);
        glm::mat4 transform = projection * view * lightModel;
        glUniformMatrix4fv(glGetUniformLocation(program, "transform"), 1, GL_FALSE, glm::value_ptr(transform));
        glDrawArrays(GL_TRIANGLES, 0, 36);

        glfwSwapBuffers(w);
        glfwPollEvents();
    }
    
    glfwTerminate();
    return 0;
}
