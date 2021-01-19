//
//  main.m
//  opengl-lesson-9
//
//  Created by Sam on 2020/2/8.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <opengl_lesson_util/opengl_lesson_util.h>

#include "vertices.h"
//#import "cube_positions.h"

//#include <glm/glm.hpp>
//#include <glm/gtc/matrix_transform.hpp>
//#include <glm/gtc/type_ptr.hpp>

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>


void windowSizeChangecallback(GLFWwindow *w, int width, int height) {
    glViewport(0, 0, width, height);
}


GLuint createVao() {
    GLuint vao, vbo;
    glGenVertexArrays(1, &vao);
    glGenBuffers(1, &vbo);
    
    glBindVertexArray(vao);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);
    
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(1);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
    return vao;
}

int main(int argc, const char * argv[]) {
   
    glfwInitialize();
    GLFWwindow *w = createWindow(800, 800, @"opengl-lesson-9", windowSizeChangecallback);
    gladLoadGlfw();
    
    GLuint vertexShader = createShader(@"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-9/vert.glsl", GL_VERTEX_SHADER);
    GLuint fragmentShader = createShader(@"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-9/frag.glsl", GL_FRAGMENT_SHADER);
    
    GLuint lightVertexShader = createShader(@"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-9/vert_light.glsl", GL_VERTEX_SHADER);

     GLuint lightFragmentShader = createShader(@"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-9/frag_light.glsl", GL_FRAGMENT_SHADER);
    GLuint program = createProgramWithShader(vertexShader, fragmentShader);
    GLuint lightProgram = createProgramWithShader(lightVertexShader, lightFragmentShader);
    
    GLuint vao = createVao();
    
    GLKMatrix4 model, lightModel, view, projection;
    model = GLKMatrix4Identity; //GLKMatrix4Rotate(GLKMatrix4Identity, M_PI / 6.0, 0.1, 0.2, 0.3);

    lightModel = GLKMatrix4Scale(GLKMatrix4Identity, 0.3, 0.3, 0.3);
    lightModel = GLKMatrix4Translate(GLKMatrix4Identity, 1.2, 1.0, 2.0);
    
    view = GLKMatrix4Translate(GLKMatrix4Identity, 0.5, 0.5, -4);
    
    projection = GLKMatrix4MakePerspective(45, 800.0/800.0, 0.1, 100.0);
    
    glEnable(GL_DEPTH_TEST);
    
    while (!glfwWindowShouldClose(w)) {
        if (glfwGetKey(w, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
            glfwSetWindowShouldClose(w, true);
        }
        
        
        glClearColor(0.1, 0.2, 0.3, 1.0);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        

        glUseProgram(program);
        
        glUniformMatrix4fv(glGetUniformLocation(program, "projection"), 1, 0, projection.m);
        glUniformMatrix4fv(glGetUniformLocation(program, "view"), 1, 0, view.m);
        glUniformMatrix4fv(glGetUniformLocation(program, "model"), 1, 0, model.m);
        
        glUniform3fv(glGetUniformLocation(program, "aColor"), 1, GLKVector3Make(1.0, 0.1, 0.3).v);
        glUniform3fv(glGetUniformLocation(program, "lightColor"), 1, GLKVector3Make(1.0, 1.0, 1.0).v);
        glUniform3fv(glGetUniformLocation(program, "lightPos"), 1, GLKVector3Make(5, 5, -10).v);
        glUniform3fv(glGetUniformLocation(program, "viewPos"), 1, GLKVector3Make(0, 0, -4).v);

        glBindVertexArray(vao);
        glDrawArrays(GL_TRIANGLES, 0, 36);
        glBindVertexArray(0);
        
        
        glUseProgram(lightProgram);
        GLKMatrix4 lightTransform = GLKMatrix4Multiply(projection, GLKMatrix4Multiply(view, lightModel));
        glUniformMatrix4fv(glGetUniformLocation(lightProgram, "transform"), 1, 0, lightTransform.m);
        glUniform3fv(glGetUniformLocation(lightProgram, "lightColor"), 1, GLKVector3Make(1.0, 1.0, 1.0).v);
        glBindVertexArray(vao);
        glDrawArrays(GL_TRIANGLES, 0, 36);
        glBindVertexArray(0);

        
        glfwSwapBuffers(w);
        glfwPollEvents();
    }
    glfwTerminate();
    return 0;
}
