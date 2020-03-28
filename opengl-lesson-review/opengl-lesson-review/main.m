//
//  main.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/22.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MACLGLKit/LGLKit.h>
#import "LGLTriangleTest.h"
#import "LGLTextureTest.h"
#import "LGLCubeTest.h"
#import "LGLTransformTest.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        [LGLTriangleTest test];
//        [LGLTextureTest test];
//        [LGLCubeTest test];
        [LGLTransformTest test];
    }
    return 0;
}
/*
  LGWindow *w = [[LGWindow alloc] initWithSize:CGSizeMake(800, 600) title:@"opengl-lesson-review"];
         w.rgba = 0x19324Bff;
         w.mask = GL_COLOR_BUFFER_BIT;
         LGVertexShader *vs = [[LGVertexShader alloc] initWithString:vertexShaderString()];
         LGFragmentShader *fs = [[LGFragmentShader alloc] initWithString:fragmentShaderString()];
         LGProgram *program = [[LGProgram alloc] initWithVertexShader:vs fragmentShader:fs];
         
         LGVertexArrayObject *vao = [[LGVertexArrayObject alloc] init];
         
         GLuint indexes[] = {3, 2};
         LGVertexBufferObject *vbo = [[LGVertexBufferObject alloc]
                                      initWithVertexArray:LGLfloatArrayPack(vertexes, sizeof(vertexes)/sizeof(float))
                                      lineWidth:LGLuintArrayPack(indexes, 2)];
         [vao addVertexBufferObject:vbo];
         
         LGTexture *t1 = [[LGTexture alloc] initWithPath:@"/Volumes/Sam/音视频/opengl/opengl-lesson-review/opengl-lesson-review/abc.png"];
                 
         CGFloat width = 800.0;
         CGFloat height = 600.0;
         GLKMatrix4 model = GLKMatrix4Identity;
 //        model = GLKMatrix4Rotate(model, M_PI_2, 1, 1, 1);
 //        model = GLKMatrix4Scale(model, 1, width/height, 1);
 //
         [program setShaderVariaable:^(GLuint prog) {
             glUniform1i(glGetUniformLocation(prog, "texture1"), 0);
             t1.textureUnit = 0;
             glUniformMatrix4fv(glGetUniformLocation(prog, "model"), 1, GL_FALSE, model.m);
         }];
         [w render:^{
             [program use];
             [program activeTextures:@[t1]];
             [vao draw];
         }];
 */
