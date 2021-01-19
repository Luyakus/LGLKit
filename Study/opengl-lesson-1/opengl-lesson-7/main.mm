//
//  main.m
//  opengl-lesson-7
//
//  Created by Sam on 2020/2/4.
//  Copyright © 2020 Sam. All rights reserved.
//
#include "vertices.h"
#include "cube_positions.h"

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>
#include <glm/gtc/type_ptr.hpp>

#import <opengl_lesson_util/opengl_lesson_util.h>
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

    glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 5 * sizeof(float), (void *)(3 * sizeof(float)));
    glEnableVertexAttribArray(1);

    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);

    return vao;
}

void windowSizeChangeCallback(GLFWwindow *w, int width, int height) {
    glViewport(0, 0, width, height);
}

float detailTime = 0.0f;
float lastFrame = 0.0f;

glm::vec3 cameraPosition = glm::vec3(0.0f, 0.0f, 3.0f);
glm::vec3 cameraFront = glm::vec3(0.0f, 0.0f, -1.0f);
glm::vec3 cameraUp = glm::vec3(0.0f, 1.0f, 0.0f);


float lastX = 400.0f;
float lastY = 300.0f;

float pitch = 0.0f;
float yaw = -90.0f;
bool firstMouse = true;

void cursorPosCallback(GLFWwindow *, double xpos, double ypos) {
    if (firstMouse) {
        lastX = xpos;
        lastY = ypos;
        firstMouse = false;
    }
    
    float xoffset = xpos - lastX;
    float yoffset = lastY - ypos; // reversed since y-coordinates go from bottom to top
    lastX = xpos;
    lastY = ypos;
    
    float sensitivity = 0.1f; // change this value to your liking
    xoffset *= sensitivity;
    yoffset *= sensitivity;
    
    yaw += xoffset;
    pitch += yoffset;
    
    // make sure that when pitch is out of bounds, screen doesn't get flipped
    if (pitch > 89.0f)
        pitch = 89.0f;
    if (pitch < -89.0f)
        pitch = -89.0f;
    
    glm::vec3 front;
    front.x = cos(glm::radians(yaw)) * cos(glm::radians(pitch));
    front.y = sin(glm::radians(pitch));
    front.z = sin(glm::radians(yaw)) * cos(glm::radians(pitch));
    cameraFront = glm::normalize(front);
}

int main(int argc, const char * argv[]) {
    glfwInitialize();
    GLFWwindow *w = createWindow(800, 600, @"opengl-lesson-7", windowSizeChangeCallback);
    glfwSetCursorPosCallback(w, cursorPosCallback);
    gladLoadGlfw();

    NSString *vertexShaderPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-7/vert.glsl";
    GLuint vertexShader = createShader(vertexShaderPath, GL_VERTEX_SHADER);

    NSString *fragmentShaderPath = @"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-7/frag.glsl";
    GLuint fragmentShader = createShader(fragmentShaderPath, GL_FRAGMENT_SHADER);

    GLuint program = createProgramWithShader(vertexShader, fragmentShader);

    GLuint texture = createTexture(@"/Users/sam/Desktop/opengl/opengl-lesson-1/opengl-lesson-7/123.png");

    GLuint vao = bindOpenglObject();
    
    glm::mat4 projection;
    
    projection = glm::perspective(glm::radians(45.0f), 800.0f/600.0f, 0.1f, 100.0f);

//    glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    
    while (!glfwWindowShouldClose(w)) {
        float currentFrame = glfwGetTime();
        detailTime = currentFrame - lastFrame;
        lastFrame = currentFrame;
        float cameraSpeed = detailTime * 2.5;
        if (glfwGetKey(w, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
            glfwSetWindowShouldClose(w, GL_TRUE);
        } else if (glfwGetKey(w, GLFW_KEY_A) == GLFW_PRESS) {
            cameraPosition -= glm::normalize(glm::cross(cameraFront, cameraUp)) * cameraSpeed;
        } else if (glfwGetKey(w, GLFW_KEY_D) == GLFW_PRESS) {
            cameraPosition += glm::normalize(glm::cross(cameraFront, cameraUp)) * cameraSpeed;
        } else if (glfwGetKey(w, GLFW_KEY_W) == GLFW_PRESS) {
            cameraPosition += cameraFront * cameraSpeed;
        } else if (glfwGetKey(w, GLFW_KEY_S) == GLFW_PRESS) {
            cameraPosition -= cameraFront * cameraSpeed;
        }
        glEnable(GL_DEPTH_TEST);
        glClearColor(0.1, 0.2, 0.3, 1);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glUseProgram(program);
        
        glBindTexture(GL_TEXTURE_2D, texture);
        glBindVertexArray(vao);
        
        glm::mat4 view;
        view = glm::lookAt(cameraPosition,
                           cameraPosition + cameraFront,
                           cameraUp);
       
        for (int i = 0; i < 10; i ++) {
            glm::mat4 model;
            model = glm::translate(model, cubePositions[i]);
            model = glm::rotate(model, (float)glfwGetTime(), glm::vec3(0.1f, 0.2f, 0.3f));
            glm::mat4 transform = projection * view * model;
            glUniformMatrix4fv(glGetUniformLocation(program, "transform"), 1, GL_FALSE, glm::value_ptr(transform));
            glDrawArrays(GL_TRIANGLES, 0, 36);
        }
        
        glfwSwapBuffers(w);
        glfwPollEvents();
    }
    glfwTerminate();

    return 0;
}
