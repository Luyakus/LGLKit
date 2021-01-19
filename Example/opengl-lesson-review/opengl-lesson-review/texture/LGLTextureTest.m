//
//  LGLTextureTest.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/25.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGLTextureTest.h"
#import <MACLGLKit/LGLKit.h>

@implementation LGLTextureTest

static NSString *sourcePathForName(NSString * relativePath) {
    NSString *filePath = [NSString stringWithFormat:@"%s", __FILE__];
    NSString *sourcePath = [filePath.stringByDeletingLastPathComponent stringByAppendingPathComponent:relativePath];
    return sourcePath;
}

static NSString *vertexShaderString(void) {
    NSString *path = sourcePathForName(@"texture_vert.glsl");
    NSString *src = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return src;
}

static NSString *fragmentShaderString(void) {
    NSString *path = sourcePathForName(@"texture_frag.glsl");
    NSString *src = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return src;
}

+ (void)test {
    LGWindow *w = [[LGWindow alloc] initWithSize:CGSizeMake(600, 600) title:@"texture"];
    w.rgba = 0x172749ff;
    w.mask = GL_COLOR_BUFFER_BIT;
    
    LGVertexArrayObject *vao = [[LGVertexArrayObject alloc] init];
    float vertexes[] = {
        -0.5, -0.5, 0, 0, 0,
         0.5, -0.5, 0, 1, 0,
         0.5,  0.5, 0, 1, 1,
         0.5,  0.5, 0, 1, 1,
        -0.5,  0.5, 0, 0, 1,
        -0.5, -0.5, 0, 0, 0,
    };
    LGVertexBufferObject *vbo = [[LGVertexBufferObject alloc]
                                 initWithVertexArray:LGLfloatArrayPack(vertexes, sizeof(vertexes)/sizeof(float))
                                 lineWidth:@[@3, @2]];
    [vao addVertexBufferObject:vbo];
    
    GLfloat trangle[] = {
        0.7, 0.8, 0, 1, 0,
        0.7, 0.5, 0, 0, 1,
        1, 0.5, 0, 1, 1
    };
    LGVertexArrayObject *vao1 = [[LGVertexArrayObject alloc] init];
    LGVertexBufferObject *vbo1 = [[LGVertexBufferObject alloc]
                                 initWithVertexArray:LGLfloatArrayPack(trangle, sizeof(trangle)/sizeof(float))
                                 lineWidth:@[@3, @2]];
    [vao1 addVertexBufferObject:vbo1];
    
    LGVertexShader *vs = [[LGVertexShader alloc] initWithString:vertexShaderString()];
    LGFragmentShader *fs = [[LGFragmentShader alloc] initWithString:fragmentShaderString()];
    LGProgram *program = [[LGProgram alloc] initWithVertexShader:vs fragmentShader:fs];
    
    
    LGVertexShader *vs1 = [[LGVertexShader alloc] initWithString:vertexShaderString()];
    LGFragmentShader *fs1 = [[LGFragmentShader alloc] initWithString:fragmentShaderString()];
    LGProgram *program1 = [[LGProgram alloc] initWithVertexShader:vs1 fragmentShader:fs1];
    
    LGTexture *t = [[LGTexture alloc] initWithPath:sourcePathForName(@"../abc.png")];
    [program setShaderVariable:^(GLuint prog) {
        glUniform1i(glGetUniformLocation(prog, "texture1"), 0);
        t.textureUnit = 0;
    }];
    
    [w render:^{
        [program use];
        [program activeTextures:@[t]];
        
        [program1 use];
        [program activeTextures:@[t]];
        [vao draw];
        [vao1 draw];
    }];
}
@end
