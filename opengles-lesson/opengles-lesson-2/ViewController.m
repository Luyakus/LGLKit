//
//  ViewController.m
//  opengles-lesson-2
//
//  Created by Sam on 2020/2/7.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "ViewController.h"
#import <OpenGLES/ES3/gl.h>
@interface ViewController () {
    GLuint program, vao;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    EAGLContext *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    [(GLKView *)self.view setContext:context];
    [EAGLContext setCurrentContext:context];
    
//    glPolygonMode(GL_FRONT_AND_BACK, GL_LINES);

    NSString *vpath = [[NSBundle mainBundle] pathForResource:@"vert" ofType:@"glsl"];
    NSString *vsource =  [NSString stringWithContentsOfFile:vpath encoding:NSUTF8StringEncoding error:nil];
    GLuint vertexShader = [self createShader:vsource type:GL_VERTEX_SHADER];

    NSString *fpath = [[NSBundle mainBundle] pathForResource:@"frag" ofType:@"glsl"];
    NSString *fsource = [NSString stringWithContentsOfFile:fpath encoding:NSUTF8StringEncoding error:nil];
    GLuint fragmentShader = [self createShader:fsource type:GL_FRAGMENT_SHADER];
    
    program = [self createProgramWithVertexShader:vertexShader fragmentShader:fragmentShader];
    vao = [self createVao];
}


- (GLuint)createShader:(NSString *)source type:(GLenum)shaderType {
    GLuint shader = glCreateShader(shaderType);
    const char *src = source.UTF8String;
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
        NSLog(@"link 失败 %s", infoLog);
        exit(-1);
    }
    return program;
}

float vertexs[] = {
    -0.5, -0.5, 0, 1.0, 0.0, 0.0,
     0.5, -0.5, 0, 0.0, 1.0, 0.0,
     0.5,  0.5, 0, 0.0, 0.0, 1.0,
    -0.5,  0.5, 0, 0.1, 0.7, 0.2,
};

GLuint indecies[] = {
    0, 1, 2,
    2, 3, 0
};

- (GLuint)createVao {
    GLuint vao, vbo, ebo;
    glGenVertexArrays(1, &vao);
    glGenBuffers(1, &vbo);
    glGenBuffers(1, &ebo);
    
    glBindVertexArray(vao);
    
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertexs), vertexs, GL_STATIC_DRAW);
    
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_TRUE, 6 * sizeof(float), (void *)0);
    glEnableVertexAttribArray(0);
    
    glVertexAttribPointer(1, 3, GL_FLOAT, GL_TRUE, 6 * sizeof(float), (void *)(3 * sizeof(float)));
    glEnableVertexAttribArray(1);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indecies), indecies, GL_STATIC_DRAW);
    
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
    
    return vao;
}




- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0.1, 0.2, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    glUseProgram(program);
    glBindVertexArray(vao);
    glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, 0);
}

@end
