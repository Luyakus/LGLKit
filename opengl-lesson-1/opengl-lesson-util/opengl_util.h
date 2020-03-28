//
//  opengl_util.h
//  opengl-lesson-util
//
//  Created by Sam on 2020/2/4.
//  Copyright © 2020 Sam. All rights reserved.
//

#include <glad/glad.h>
#include <GLFW/glfw3.h>
#import <Foundation/Foundation.h>

#ifdef __cplusplus
extern "C" {
extern void glfwInitialize(void);
extern void gladLoadGlfw(void);
extern GLFWwindow *createWindow(int width, int height, NSString *title,  GLFWframebuffersizefun callback);
extern GLuint createShader(NSString *path, GLenum type);
extern GLuint createProgramWithShader(GLuint vertextShader, GLuint fragmentShader);
extern GLuint createTexture(NSString *path);
}

#else

extern void glfwInitialize(void);
extern void gladLoadGlfw(void);
extern GLFWwindow *createWindow(int width, int height, NSString *title,  GLFWframebuffersizefun callback);
extern GLuint createShader(NSString *path, GLenum type);
extern GLuint createProgramWithShader(GLuint vertextShader, GLuint fragmentShader);
extern GLuint createTexture(NSString *path);

#endif
