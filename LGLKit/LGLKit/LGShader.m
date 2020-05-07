//
//  LGShader.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGShader.h"
@interface LGShader()
@property (nonatomic, assign) GLint shader;
@end
@implementation LGShader
- (instancetype)initWithString:(NSString *)string {
    if (self = [super init]) {
        const char *src = (const char *)string.UTF8String;
        GLint shader = glCreateShader(self.shaderType);
        glShaderSource(shader, 1, &src, NULL);
        glCompileShader(shader);
        
        char info[512]; int isSuccess;
        glGetShaderiv(shader, GL_COMPILE_STATUS, &isSuccess);
        if (!isSuccess) {
            glGetShaderInfoLog(shader, 512, NULL, info);
            NSLog(@"%@ %s", (self.shaderType == GL_VERTEX_SHADER ? @"vertexShader" : @"fragmentShader"), info);
            NSAssert(nil, nil);
            return nil;
        }
        self.shader = shader;
    }
    return self;
}
@end
