//
//  main.m
//  opengl-lesson-1
//
//  Created by Sam on 2020/1/20.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

#include <GLFW/glfw3.h>

//
//void framebuffer_size_callback(GLFWwindow* window, int width, int height);//回调函数原型声明
//void processInput(GLFWwindow *window);
//
//// settings
//const unsigned int SCR_WIDTH = 800;
//const unsigned int SCR_HEIGHT = 600;
//
//int main(int argc, char * argv[]) {
//
//    //初始化GLFW
//    glfwInit();
//    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
//    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
//    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
//#ifdef __APPLE__
//    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE); // uncomment this statement to fix compilation on OS X
//#endif
//    //创建一个窗口对象
//    GLFWwindow* window = glfwCreateWindow(SCR_WIDTH, SCR_HEIGHT, "FirstGL", NULL, NULL);
//    if (window == NULL)
//    {
//        NSLog(@"window 创建失败");
//        glfwTerminate();
//        return -1;
//    }
//    //通知GLFW将我们窗口的上下文设置为当前线程的主上下文
//    glfwMakeContextCurrent(window);
//    //对窗口注册一个回调函数,每当窗口改变大小，GLFW会调用这个函数并填充相应的参数供你处理
//    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);
//    //初始化GLAD用来管理OpenGL的函数指针
//    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
//    {
//        NSLog(@"Failed to initialize GLAD");
//        return -1;
//    }
//
//    //渲染循环
//    while(!glfwWindowShouldClose(window))
//    {
//        // 输入
//        processInput(window);
//
//        // 渲染指令
//        glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
//        glClear(GL_COLOR_BUFFER_BIT);
//
//        // 检查并调用事件，交换缓冲
//        glfwSwapBuffers(window);//检查触发事件
//        glfwPollEvents();    //交换颜色缓冲
//    }
//
//    //释放/删除之前的分配的所有资源
//    glfwTerminate();
//    return EXIT_SUCCESS;
//}
//
////输入控制，检查用户是否按下了返回键(Esc)
//void processInput(GLFWwindow *window)
//{
//    if(glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
//        glfwSetWindowShouldClose(window, true);
//}
//
//// 当用户改变窗口的大小的时候，视口也应该被调整
//void framebuffer_size_callback(GLFWwindow* window, int width, int height)
//{
//    // 注意：对于视网膜(Retina)显示屏，width和height都会明显比原输入值更高一点。
//    glViewport(0, 0, width, height);
//}

const unsigned int width = 800;
const unsigned int height = 600;


void processInput(GLFWwindow *w);
void windowSizeChangeCallback(GLFWwindow *w, int width, int height);


int main(int argc, char *argv[]) {
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
    
    GLFWwindow *w = glfwCreateWindow(width, height, "opengl", NULL, NULL);
    if (!w) {
        NSLog(@"window 创建失败");
        return -1;
    }
    
    glfwMakeContextCurrent(w);
    glfwSetFramebufferSizeCallback(w, windowSizeChangeCallback);
    
    
    while (!glfwWindowShouldClose(w)) {
        processInput(w);
        
        glClearColor(0.1, 0.2, 0.3, 1);
        glClear(GL_COLOR_BUFFER_BIT);
        
        glfwSwapBuffers(w);
        glfwPollEvents();
    }
    glfwTerminate();
    return -1;
}

void processInput(GLFWwindow *w) {
    if (glfwGetKey(w, GLFW_KEY_ESCAPE) == GLFW_PRESS) {
        glfwSetWindowShouldClose(w, true);
    }
}
void windowSizeChangeCallback(GLFWwindow *w, int width, int height) {
    glViewport(0, 0, width, height);
}

