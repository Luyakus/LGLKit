//
//  LGProgram.h
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLInclude.h"
#import "LGTexture.h"
#import "LGShader.h"
NS_ASSUME_NONNULL_BEGIN

@interface LGProgram : NSObject
@property (nonatomic, readonly) GLuint program;
- (instancetype)initWithVertexShader:(LGShader *)vertexShader fragmentShader:(LGShader *)fragmentShander;
- (void)use;
- (void)activeTextures:(NSArray *)textures;

- (void)setShaderVariable:(void(^)(GLuint prog))block;
@end

NS_ASSUME_NONNULL_END
