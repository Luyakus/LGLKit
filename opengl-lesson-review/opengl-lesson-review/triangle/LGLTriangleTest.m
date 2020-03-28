//
//  LGLTriangleTest.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/25.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGLTriangleTest.h"
#import <MACLGLKit/LGLKit.h>
@implementation LGLTriangleTest

static NSString *vertexShaderString(void) {
    NSString *path = @"/Volumes/Sam/音视频/opengl/opengl-lesson-review/opengl-lesson-review/triangle/triangle_vert.glsl";
    NSString *src = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return src;
}

static NSString *fragmentShaderString(void) {
    NSString *path = @"/Volumes/Sam/音视频/opengl/opengl-lesson-review/opengl-lesson-review/triangle/triangle_frag.glsl";
    NSString *src = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return src;
}

+ (void)test {
    LGWindow *w = [[LGWindow alloc] initWithSize:CGSizeMake(600, 600) title:@"triangle"];
    w.rgba = 0x172749ff;
    w.mask = GL_COLOR_BUFFER_BIT;
    
    LGVertexArrayObject *vao = [[LGVertexArrayObject alloc] init];
    float vertexes[] = {
        -0.5, -0.5, 0,
         0.5, -0.5, 0,
         0.5,  0.5, 0
    };
    LGVertexBufferObject *vbo = [[LGVertexBufferObject alloc]
                                 initWithVertexArray:LGLfloatArrayPack(vertexes, sizeof(vertexes)/sizeof(float))
                                 lineWidth:@[@3]];
    [vao addVertexBufferObject:vbo];
    
    LGVertexShader *vs = [[LGVertexShader alloc] initWithString:vertexShaderString()];
    LGFragmentShader *fs = [[LGFragmentShader alloc] initWithString:fragmentShaderString()];
    LGProgram *program = [[LGProgram alloc] initWithVertexShader:vs fragmentShader:fs];
    
    [w render:^{
        [program use];
        [vao draw];
    }];
}

@end
