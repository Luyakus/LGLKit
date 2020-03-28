//
//  LGProgram.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGProgram.h"
@interface LGProgram()
@property (nonatomic, assign) GLuint program;
@end
@implementation LGProgram
- (instancetype)initWithVertexShader:(LGShader *)vertexShader fragmentShader:(LGShader *)fragmentShander {
    NSAssert(vertexShader, @"vertexShader 不能为空");
    NSAssert(fragmentShander, @"fragmentShader 不能为空");
    if (self = [super init]) {
        GLint program = glCreateProgram();
        glAttachShader(program, vertexShader.shader);
        glAttachShader(program, fragmentShander.shader);
        glLinkProgram(program);
        
        char info[512]; int isSuccess;
        glGetProgramiv(program, GL_LINK_STATUS, &isSuccess);
        if (!isSuccess) {
            glGetProgramInfoLog(program, 512, NULL, info);
            NSLog(@"%s", info);
            return nil;
        }
        self.program = program;
    }
    return self;
}

- (void)use {
    glUseProgram(self.program);
}

- (void)setShaderVariable:(void (^)(GLuint))block {
    [self use];
    if (block) {
        block(self.program);
    }
}

- (void)activeTextures:(NSArray *)textures {
    [self use];
    for (int i = 0; i < textures.count; i ++) {
        LGTexture *t = textures[i];
        glActiveTexture(GL_TEXTURE0 + t.textureUnit);
        glBindTexture(GL_TEXTURE_2D, t.name);
    }
}
@end
