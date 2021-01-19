//
//  LGRenderBufferObject.h
//  LGLKit
//
//  Created by Sam on 2020/4/7.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLInclude.h"

NS_ASSUME_NONNULL_BEGIN

@interface LGRenderBufferObject : NSObject
@property (nonatomic, readonly) GLuint rbo;
@property (nonatomic, readonly) CGSize size;

- (instancetype)initWithSize:(CGSize)size;
@end

NS_ASSUME_NONNULL_END
