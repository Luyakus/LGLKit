//
//  LGWindow.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//


#include <GLFW/glfw3.h>
#import "LGWindow.h"
@interface LGWindow()
@property (nonatomic, assign) GLFWwindow *w;
@end
@implementation LGWindow
- (instancetype)initWithSize:(CGSize)size title:(NSString *)title {
    if (self = [super init]) {
        [self initGLFW];
        if ((self.w = [self createWindowWidthSize:size title:title]) == NULL) {
            return nil;
        }
    }
    return self;
}

void framebufferSizeChangeCallback(GLFWwindow *w, int width, int height) {
    glViewport(0, 0, width, height);
}

- (void)initGLFW {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
}

- (GLFWwindow *)createWindowWidthSize:(CGSize)size title:(NSString *)title {
    GLFWwindow *w = glfwCreateWindow(size.width, size.height, (const char *)title.UTF8String, NULL, NULL);
    if (w == NULL) {
        NSLog(@"window 创建失败");
        return nil;
    }
    glfwMakeContextCurrent(w);
    glfwSetFramebufferSizeCallback(w, framebufferSizeChangeCallback);
//    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
//        NSLog(@"glad 初始化失败");
//        return nil;
//    }
    return w;
}


- (void)render:(void (^)(void))block {
    CGFloat r = (0x000000ff & (self.rgba >> 24)) / 255.0;
    CGFloat g = (0x000000ff & (self.rgba >> 16)) / 255.0;
    CGFloat b = (0x000000ff & (self.rgba >> 8)) / 255.0;
    CGFloat a = (0x000000ff & self.rgba) / 255.0;
    GLbitfield mask = self.mask;
    
    while (!glfwWindowShouldClose(self.w)) {
        if (glfwGetKey(self.w, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
            break;
        }
        if (block) {
            glClearColor(r, g, b, a);
            glClear(mask);
            
            block();
            
            glfwSwapBuffers(self.w);
            glfwPollEvents();
        }
    }
    glfwTerminate();
}
@end
