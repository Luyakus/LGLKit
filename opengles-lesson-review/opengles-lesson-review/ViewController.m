//
//  ViewController.m
//  opengles-lesson-review
//
//  Created by Sam on 2020/3/24.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "ViewController.h"
#import "vertexes.h"
@interface ViewController ()
@property (nonatomic, strong) LGProgram *program;
@property (nonatomic, strong) LGVertexArrayObject *vao;
@property (nonatomic, strong) NSArray *textures;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test1];
    
}

- (void)test1 {
    EAGLContext  *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    [(GLKView *)self.view setContext:context];
    [EAGLContext setCurrentContext:context];
    self.preferredFramesPerSecond = 45;
    GLKView *view = (GLKView *)self.view;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
//    view.drawableColorFormat = GLKViewDrawableColorFormatRGBA8888;
    
    NSString *vertSrc = [self vertexShaderSrc];
    NSString *fragSrc = [self fragmentShaderSrc];
    LGVertexShader *vs = [[LGVertexShader alloc] initWithString:vertSrc];
    LGFragmentShader *fs = [[LGFragmentShader alloc] initWithString:fragSrc];
    self.program = [[LGProgram alloc] initWithVertexShader:vs fragmentShader:fs];
    
    GLuint indexes[] = {3, 2};
    self.vao = [[LGVertexArrayObject alloc] init];
    LGVertexBufferObject *vbo = [[LGVertexBufferObject alloc]
                                 initWithVertexArray:LGLfloatArrayPack(vertexes, sizeof(vertexes)/sizeof(float))
                                 lineWidth:LGLuintArrayPack(indexes, 2)];
    [self.vao addVertexBufferObject:vbo];
    
    NSString *texture1Path = [self texture1Path];
    LGTexture *t1 = [[LGTexture alloc] initWithPath:texture1Path];
    
    NSString *texture2Path = [self texture2Path];
    LGTexture *t2 = [[LGTexture alloc] initWithPath:texture2Path];
    
    GLfloat width = UIScreen.mainScreen.bounds.size.width;
    GLfloat height = UIScreen.mainScreen.bounds.size.height;
    GLKMatrix4 m = GLKMatrix4MakeRotation(M_PI / 4, 1, 1, 1);
    GLKMatrix4 v = GLKMatrix4Translate(GLKMatrix4Identity, 0, 0, -5);
    GLKMatrix4 p = GLKMatrix4MakePerspective(M_PI / 4, width/height, 0.1, 100);
    
    [self.program setShaderVariable:^(GLuint prog) {
        glUniform1i(glGetUniformLocation(prog, "texture1"), 0);
        t1.textureUnit = 0;
        
        glUniform1i(glGetUniformLocation(prog, "texture2"), 1);
        t2.textureUnit = 1;
        
        glUniformMatrix4fv(glGetUniformLocation(prog, "model"), 1, GL_FALSE, m.m);
        glUniformMatrix4fv(glGetUniformLocation(prog, "view"), 1, GL_FALSE, v.m);
        glUniformMatrix4fv(glGetUniformLocation(prog, "perspective"), 1, GL_FALSE, p.m);

    }];
    
    self.textures = @[t1, t2];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"--------");
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    static float raidans = M_PI / 4;
    
    glEnable(GL_DEPTH_TEST);
    glClearColor(0.1, 0.2, 0.3, 1.0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
  
    [self.program use];
    [self.program setShaderVariable:^(GLuint prog) {
        raidans += 0.01;
        GLKMatrix4 m = GLKMatrix4Rotate(GLKMatrix4Identity, raidans, 1, 1, 1);
        glUniformMatrix4fv(glGetUniformLocation(prog, "model"), 1, GL_FALSE, m.m);
    }];
    [self.program activeTextures:self.textures];
    [self.vao draw];
}

#pragma mark - helper;

- (NSString *)vertexShaderSrc {
    return [self shaderSrcForName:@"vert.glsl"];
}

- (NSString *)fragmentShaderSrc {
    return [self shaderSrcForName:@"frag.glsl"];
}

- (NSString *)texture1Path {
    return [self sourcePathForName:@"abc.png"];
}

- (NSString *)texture2Path {
    return [self sourcePathForName:@"def.png"];
}

- (NSString *)shaderSrcForName:(NSString *)shaderName {
    NSString *path = [self sourcePathForName:shaderName];
    NSString *src = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return src;
}

- (NSString *)sourcePathForName:(NSString *)name {
    NSArray *arr = [name componentsSeparatedByString:@"."];
    NSString *fileName = arr.firstObject;
    NSString *fileExt = arr.lastObject;
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:fileExt];
    return path;
}
@end
