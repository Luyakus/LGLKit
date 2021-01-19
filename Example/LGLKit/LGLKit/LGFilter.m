//
//  LGFilter.m
//  LGLKit
//
//  Created by Sam on 2020/4/7.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGFilter.h"
#import "LGVertexShader.h"
#import "LGFragmentShader.h"
#import "LGProgram.h"

#import "LGFrameBufferTexture.h"
#import "LGFrameBufferObject.h"

#import "LGVertexArrayObject.h"
#import "LGVertexBufferObject.h"





@interface LGFilter()
@property (nonatomic, strong) LGProgram *program;
@property (nonatomic, strong) LGFrameBufferObject *fbo;
@property (nonatomic, strong) LGVertexArrayObject *vao;
@property (nonatomic, copy) void (^renderBlock)(LGProgram *);
@property (nonatomic, copy) NSString *src;
@end

@implementation LGFilter
- (instancetype)initWithFragmentShader:(NSString *)shaderSrc renderBlock:(nonnull void (^)(LGProgram * _Nonnull))renderBlock{
    if (self = [super init]) {
        self.src = shaderSrc;
        self.renderBlock = renderBlock;
        
        LGVertexShader *vert = [[LGVertexShader alloc] initWithString:LGLVertexShaderSrc];
        LGFragmentShader *frag = [[LGFragmentShader alloc] initWithString:self.src];
        LGProgram *program = [[LGProgram alloc] initWithVertexShader:vert fragmentShader:frag];
        self.program = program;
    }
    return self;
}

- (instancetype)initWithFragmentShader:(NSString *)shaderSrc {
    return [self initWithFragmentShader:shaderSrc renderBlock:^(LGProgram *p){}];
}
    

- (GLuint)outTexture {
    
    GLfloat vertexes[] = {
        -1, -1, 0, 0, 0,
         1, -1, 0, 1, 0,
         1,  1, 0, 1, 1,
         1,  1, 0, 1, 1,
        -1,  1, 0, 0, 1,
        -1, -1, 0, 0, 0,
    };

    self.vao = [[LGVertexArrayObject alloc] init];
    LGVertexBufferObject *vbo = [[LGVertexBufferObject alloc] initWithVertexArray:LGLfloatArrayPack(vertexes, sizeof(vertexes)/sizeof(GLfloat)) lineWidth:@[@3, @2]];
    [self.vao addVertexBufferObject:vbo];
    
    
    
    self.fbo = [[LGFrameBufferObject alloc] init];
    LGFrameBufferTexture *texture = [[LGFrameBufferTexture alloc] initWithSize:self.size];
    [self.fbo attchFrameBufferTexture:texture];
    
    NSAssert([self.fbo complete], @"framebuffer not complete");
    
    [self.fbo bind];
    glViewport(0, 0, self.size.width, self.size.height);
    glClearColor(1.0, 0, 1.0, 1);
    glClear(GL_COLOR_BUFFER_BIT);
    [self.program use];
    if (self.renderBlock) self.renderBlock(self.program);
    glBindTexture(GL_TEXTURE_2D, self.inTexture);
    [self.vao draw];
    [self.fbo unBind];
    return texture.name;
}


- (UIImage *)outImage {
    [self.fbo bind];
    GLint x = 0, y = 0;
    GLfloat width = self.size.width, height = self.size.height;
    NSInteger dataLength = width * height * 4;
    GLubyte *data = (GLubyte*)malloc(dataLength * sizeof(GLubyte));
    
    glPixelStorei(GL_PACK_ALIGNMENT, 4);
    glReadPixels(x, y, width, height, GL_RGBA, GL_UNSIGNED_BYTE, data);
    
    CGDataProviderRef ref = CGDataProviderCreateWithData(NULL, data, dataLength, NULL);
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGImageRef iref = CGImageCreate(width, height, 8, 32, width * 4, colorspace, kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast,
                                    ref, NULL, true, kCGRenderingIntentDefault);
    
    
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    CGContextRef cgcontext = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(cgcontext, kCGBlendModeCopy);
    CGContextDrawImage(cgcontext, CGRectMake(0.0, 0.0, width, height), iref);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    free(data);
    CFRelease(ref);
    CFRelease(colorspace);
    CGImageRelease(iref);
    [self.fbo unBind];
    return image;
}
@end
