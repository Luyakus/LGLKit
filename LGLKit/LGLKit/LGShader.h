//
//  LGShader.h
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLInclude.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGShader : NSObject
@property (nonatomic, readonly) GLenum shaderType;
@property (nonatomic, readonly) GLint shader;
- (instancetype)initWithString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
