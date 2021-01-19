//
//  LGVertexBufferObject.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGVertexBufferObject.h"
@interface LGVertexBufferObject()
@property (nonatomic, assign) GLuint vbo;
@property (nonatomic, strong) NSArray *vertexArray;
@property (nonatomic, strong) NSArray *lineWidth;
@end
@implementation LGVertexBufferObject

- (instancetype)initWithVertexArray:(NSArray *)array lineWidth:(NSArray *)lineWidth {
    if (self = [super init]) {
        self.vertexArray = array;
        self.lineWidth = lineWidth;
        GLuint vbo;
        glGenBuffers(1, &vbo);
        self.vbo = vbo;
    }
    return self;
}

@end



@implementation NSArray (LGLVBO)

+ (NSArray *)arraryWithVertexArray:(GLfloat[])vertexArray length:(GLuint)length {
    NSMutableArray *arr = @[].mutableCopy;
    for (int i = 0; i < length; i ++) {
        [arr addObject:@(vertexArray[i])];
    }
    return arr.copy;
}

@end
