//
//  LGElementBuffereObject.h
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLInclude.h"
NS_ASSUME_NONNULL_BEGIN

#define LGLuintArrayPack(_arr, _length) [NSArray arraryWithIndexArray:(_arr) length:(_length)]


@interface NSArray(LGLEBO)
+ (NSArray *)arraryWithIndexArray:(GLuint[])indexArray length:(GLuint)length;
@end

@interface LGElementBuffereObject : NSObject
@property (nonatomic, readonly) GLuint ebo;
@property (nonatomic, readonly) NSArray *indexArray;
- (instancetype)initWithIndexArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
