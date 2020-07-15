//
//  LGLTransformTest.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/25.
//  Copyright © 2020 Sam. All rights reserved.
//
#import <GLKit/GLKit.h>
#import "LGLTransformTest.h"
#import <MACLGLKit/LGLKit.h>
#import "vertexes.h"

@implementation LGLTransformTest

static NSString *vertexShaderString(void) {
    NSString *path = @"/Users/sam/Desktop/iOS/LGLKit/opengl-lesson-review/opengl-lesson-review/transform/transform_vert.glsl";
    NSString *src = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    return src;
}

static NSString *fragmentShaderString(void) {
    NSString *path = @"/Users/sam/Desktop/iOS/LGLKit/opengl-lesson-review/opengl-lesson-review/transform/transform_frag.glsl";
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
    
    LGTexture *t = [[LGTexture alloc] initWithPath:@"/Users/sam/Desktop/iOS/LGLKit/opengl-lesson-review/opengl-lesson-review/abc.png"];
    [program setShaderVariable:^(GLuint prog) {
        glUniform1i(glGetUniformLocation(prog, "texture1"), 0);
        t.textureUnit = 0;
        glUniformMatrix4fv(glGetUniformLocation(prog, "model"), 1, GL_FALSE, GLKMatrix4Identity.m);
    }];
    
    __block float angle = 0;
    [w render:^{
        glEnable(GL_DEPTH_TEST);
        [program use];
        angle += 0.05;
        GLKMatrix4 model = GLKMatrix4Identity;
        model = GLKMatrix4Rotate(model, angle, 1, 1, 1);
        [program setShaderVariable:^(GLuint prog) {
            glUniformMatrix4fv(glGetUniformLocation(prog, "model"), 1, GL_FALSE, model.m);
        }];
        [program activeTextures:@[t]];
        [vao draw];
    }];

}
@end
