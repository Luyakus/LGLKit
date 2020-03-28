//
//  ViewController.m
//  opengles-lesson-1
//
//  Created by Sam on 2020/2/7.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) GLKBaseEffect *baseEffect;
@property (nonatomic, assign) GLuint vbo;
@property (nonatomic, readonly) GLKView *gv;
@end

float vertexs[] = {
    -0.5, -0.5, 0,
     0.5, -0.5, 0,
       0,  0.5, 0
};

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.gv.context = context;
    [EAGLContext setCurrentContext:context];
    [self configShader];
    [self bindVbo];
}

- (void)configShader {
    self.baseEffect = [[GLKBaseEffect alloc] init];
    self.baseEffect.useConstantColor = YES;
    self.baseEffect.constantColor = GLKVector4Make(1.0, 0, 1.0, 1);
}

- (void)bindVbo {
    glGenBuffers(1, &self->_vbo);
    glBindBuffer(GL_ARRAY_BUFFER, self.vbo);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexs), vertexs, GL_STATIC_DRAW);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    [self.baseEffect prepareToDraw];
    glClearColor(0.1, 0.2, 0.3, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    glDrawArrays(GL_TRIANGLES, 0, 3);
}

- (GLKView *)gv {
    return (GLKView *)self.view;
}

- (void)dealloc {
    glDeleteBuffers(1, &self->_vbo);
    self.vbo = 0;
    [EAGLContext setCurrentContext:nil];
}
@end
