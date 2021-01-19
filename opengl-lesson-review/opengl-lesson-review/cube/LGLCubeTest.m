//
//  LGLCubeTest.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/25.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGLCubeTest.h"
#import <MACLGLKit/LGLKit.h>
#import "vertexes.h"

@implementation LGLCubeTest

static NSString *sourcePathForName(NSString * relativePath) {
    NSString *filePath = [NSString stringWithFormat:@"%s", __FILE__];
    NSString *sourcePath = [filePath.stringByDeletingLastPathComponent stringByAppendingPathComponent:relativePath];
    return sourcePath;
}

static NSString *vertexShaderString(void) {
    NSString *path = sourcePathForName(@"cube_vert.glsl");
    NSString *src = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return src;
}

static NSString *fragmentShaderString(void) {
    NSString *path = sourcePathForName(@"/cube_frag.glsl");
    NSString *src = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return src;
}

+ (void)test {
    LGWindow *w = [[LGWindow alloc] initWithSize:CGSizeMake(600, 600) title:@"cube"];
    w.rgba = 0x172749ff;
    w.mask = GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT;
    
    LGVertexArrayObject *vao = [[LGVertexArrayObject alloc] init];
    LGVertexBufferObject *vbo = [[LGVertexBufferObject alloc]
                                 initWithVertexArray:LGLfloatArrayPack(vertexes, sizeof(vertexes)/sizeof(float))
                                 lineWidth:@[@3, @2]];
    [vao addVertexBufferObject:vbo];
    
    LGVertexShader *vs = [[LGVertexShader alloc] initWithString:vertexShaderString()];
    LGFragmentShader *fs = [[LGFragmentShader alloc] initWithString:fragmentShaderString()];
    LGProgram *program = [[LGProgram alloc] initWithVertexShader:vs fragmentShader:fs];
    
    LGTexture *t = [[LGTexture alloc] initWithPath:sourcePathForName(@"../abc.png")];
    [program setShaderVariable:^(GLuint prog) {
        glUniform1i(glGetUniformLocation(prog, "texture1"), 0);
        t.textureUnit = 0;
    }];
    
    [w render:^{
        [program use];
        [program activeTextures:@[t]];
        [vao draw];
    }];
}
@end
