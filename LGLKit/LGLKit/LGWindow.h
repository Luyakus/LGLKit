//
//  LGWindow.h
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLInclude.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGWindow : NSObject
@property (nonatomic, assign) GLbitfield mask;
@property (nonatomic, assign) uint32_t rgba;
- (instancetype)initWithSize:(CGSize)size title:(NSString *)title;
- (void)render:(void(^)(void))block;
@end

NS_ASSUME_NONNULL_END
