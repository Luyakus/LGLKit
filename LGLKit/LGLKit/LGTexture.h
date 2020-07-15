//
//  LGTexture.h
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLInclude.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGTexture : NSObject
@property (nonatomic, assign) GLuint textureUnit;
@property (nonatomic, readonly) GLuint name;

#if TARGET_OS_MAC
- (instancetype)initWithPath:(NSString *)path;
#elif TARGET_OS_IPHONE
- (instancetype)initWithImage:(UIImage *)image;
#endif

- (void)active;
- (void)bind;
@end

NS_ASSUME_NONNULL_END
