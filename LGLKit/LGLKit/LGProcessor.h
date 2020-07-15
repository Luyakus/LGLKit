//
//  LGProcessor.h
//  LGLKit
//
//  Created by Sam on 2020/4/7.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLInclude.h"
#import "LGFilter.h"
NS_ASSUME_NONNULL_BEGIN

@interface LGProcessor : NSObject

- (instancetype)initWithContext:(EAGLContext *)context;

- (void)addFilter:(LGFilter *)filter;
- (UIImage *)processImage:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
