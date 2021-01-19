//
//  LGProcessorQueue.h
//  LGLKit
//
//  Created by Sam on 2020/4/9.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LGProcessorQueue : NSObject
+ (void)doAsync:(void(^)(void))something;
+ (void)doSync:(void(^)(void))something;
@end

NS_ASSUME_NONNULL_END
