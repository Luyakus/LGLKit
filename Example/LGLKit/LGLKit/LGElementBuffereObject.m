//
//  LGElementBuffereObject.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGElementBuffereObject.h"
@interface LGElementBuffereObject()
@property (nonatomic, strong) NSArray *indexArray;
@property (nonatomic, assign) GLuint ebo;
@end
@implementation LGElementBuffereObject
- (instancetype)initWithIndexArray:(NSArray *)array {
    if (self = [super init]) {
        self.indexArray = array;
        GLuint ebo;
        glGenBuffers(1, &ebo);
        self.ebo = ebo;
    }
    return self;
}
@end



@implementation NSArray (LGLEBO)

+ (NSArray *)arraryWithIndexArray:(GLuint[])indexArray length:(GLuint)length {
    NSMutableArray *arr = @[].mutableCopy;
       for (int i = 0; i < length; i ++) {
           [arr addObject:@(indexArray[i])];
       }
    return arr.copy;
}

@end
