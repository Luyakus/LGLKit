//
//  LGVertexBufferObject.h
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLInclude.h"

NS_ASSUME_NONNULL_BEGIN

#define LGLfloatArrayPack(_arr, _length) [NSArray arraryWithVertexArray:(_arr) length:(_length)]

@interface NSArray(LGLVBO)
+ (NSArray *)arraryWithVertexArray:(GLfloat[_Nonnull])vertexArray length:(GLuint)length;
@end

@interface LGVertexBufferObject : NSObject
@property (nonatomic, readonly) GLuint vbo;
@property (nonatomic, readonly) NSArray *vertexArray;
@property (nonatomic, readonly) NSArray *lineWidth;
- (instancetype)initWithVertexArray:(NSArray *)array lineWidth:(NSArray *)lineWidth;

@end

NS_ASSUME_NONNULL_END
