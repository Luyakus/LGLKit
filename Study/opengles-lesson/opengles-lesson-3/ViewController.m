//
//  ViewController.m
//  opengles-lesson-3
//
//  Created by Sam on 2020/2/8.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "ViewController.h"
#import "vertices.h"
#import <OpenGLES/ES3/gl.h>
@interface ViewController ()
@property (nonatomic, assign) GLuint vao;
@property (nonatomic, strong) GLKTextureInfo *texture1;
@property (nonatomic, strong) GLKTextureInfo *texture2;
@property (nonatomic, assign) GLuint program;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    [(GLKView *)self.view setContext:context];
    [EAGLContext setCurrentContext:context];
    
    NSString *vpath = [[NSBundle mainBundle] pathForResource:@"vert" ofType:@"glsl"];
    NSString *vsource =  [NSString stringWithContentsOfFile:vpath encoding:NSUTF8StringEncoding error:nil];
    GLuint vertexShader = [self createShaderWithSource:vsource type:GL_VERTEX_SHADER];
    
    NSString *fpath = [[NSBundle mainBundle] pathForResource:@"frag" ofType:@"glsl"];
    NSString *fsource = [NSString stringWithContentsOfFile:fpath encoding:NSUTF8StringEncoding error:nil];
    GLuint fragmentShader = [self createShaderWithSource:fsource type:GL_FRAGMENT_SHADER];
    
    self.program = [self createProgramWithVertexShader:vertexShader fragmentShader:fragmentShader];
    self.vao = [self createVao];
    
    NSString *tPath1 = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"png"];
    self.texture1 = [GLKTextureLoader textureWithContentsOfFile:tPath1 options:@{GLKTextureLoaderOriginBottomLeft:@(YES)} error:nil];
     
    NSString *tPath2 = [[NSBundle mainBundle] pathForResource:@"abc" ofType:@"png"];
    self.texture2 = [GLKTextureLoader textureWithContentsOfFile:tPath2 options:@{GLKTextureLoaderOriginBottomLeft:@(YES)} error:nil];
    
    glUseProgram(self.program);
    glUniform1i(glGetUniformLocation(self.program, "texture1"), 0);
    glUniform1i(glGetUniformLocation(self.program, "texture2"), 1);
    
//    glUniformMatrix4fv(<#GLint location#>, <#GLsizei count#>, <#GLboolean transpose#>, <#const GLfloat *value#>)
    
    GLKMatrix4 mat;
}


- (GLuint)createShaderWithSource:(NSString *)source type:(GLenum)shaderType {
    GLuint shader = glCreateShader(shaderType);
    const char *src = (const char *)source.UTF8String;
    glShaderSource(shader, 1, &src, NULL);
    glCompileShader(shader);
    
    int success;
    char infoLog[512];
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
        glGetShaderInfoLog(shader, 512, NULL, infoLog);
        NSLog(@"%@ 编译失败 %s",source, infoLog);
        exit(-1);
    }
    return shader;
}

- (GLuint)createProgramWithVertexShader:(GLuint)vertexShader fragmentShader:(GLuint)fragmentShader {
    GLuint program = glCreateProgram();
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    glLinkProgram(program);
    int success;
    char infoLog[512];
    glGetProgramiv(program, GL_LINK_STATUS, &success);
    if (!success) {
        glGetProgramInfoLog(program, 512, NULL, infoLog);
        NSLog(@"link program 失败 %s", infoLog);
        exit(-1);
    }
    return program;
}

- (GLuint)createVao {
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


- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.1, 0.2, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    glUseProgram(self.program);
    
    glActiveTexture(GL_TEXTURE0);
    glBindTexture(GL_TEXTURE_2D, self.texture1.name);
    
    glActiveTexture(GL_TEXTURE1);
    glBindTexture(GL_TEXTURE_2D, self.texture2.name);
    
    glBindVertexArray(self.vao);
    glDrawArrays(GL_TRIANGLES, 0, 36);
}
@end
