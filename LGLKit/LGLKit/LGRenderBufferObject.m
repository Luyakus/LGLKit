//
//  LGRenderBufferObject.m
//  LGLKit
//
//  Created by Sam on 2020/4/7.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGRenderBufferObject.h"

@interface LGRenderBufferObject()
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) GLuint rbo;
@end

@implementation LGRenderBufferObject
- (instancetype)initWithSize:(CGSize)size {
    if (self = [super init]) {
        unsigned int rbo;
        glGenRenderbuffers(1, &rbo);
        glBindRenderbuffer(GL_RENDERBUFFER, rbo);
        glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH24_STENCIL8, size.width, size.height);
        glBindRenderbuffer(GL_RENDERBUFFER, 0);
        self.rbo = rbo;
        self.size = size;
    }
    return self;
}
@end
