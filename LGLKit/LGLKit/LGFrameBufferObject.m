//
//  LGFrameBufferObject.m
//  LGLKit
//
//  Created by Sam on 2020/4/7.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGFrameBufferObject.h"

@interface LGFrameBufferObject()
@property (nonatomic, assign) GLuint fbo;
@end

@implementation LGFrameBufferObject
- (instancetype)init {
    if (self = [super init]) {
        GLuint fbo;
        glGenFramebuffers(1, &fbo);
        self.fbo = fbo;
    }
    return self;
}

- (void)attchFrameBufferTexture:(LGFrameBufferTexture *)texture {
    [self bind];
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, texture.name, 0);
    [self unBind];
}

- (void)attchRenderBufferObject:(LGRenderBufferObject *)rbo {
    [self bind];
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_STENCIL_ATTACHMENT, GL_RENDERBUFFER, rbo.rbo);
    [self unBind];
}

- (BOOL)complete {
    [self bind];
    BOOL success = glCheckFramebufferStatus(GL_FRAMEBUFFER) == GL_FRAMEBUFFER_COMPLETE;
    [self unBind];
    return success;
}

- (void)bind {
    glBindFramebuffer(GL_FRAMEBUFFER, self.fbo);
}

- (void)unBind {
    glBindFramebuffer(GL_FRAMEBUFFER, 0);
}
@end
