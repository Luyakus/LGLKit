//
//  LGFrameBufferObject.h
//  LGLKit
//
//  Created by Sam on 2020/4/7.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLInclude.h"
#import "LGFrameBufferTexture.h"
#import "LGRenderBufferObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface LGFrameBufferObject : NSObject
@property (nonatomic, readonly)  GLuint fbo;

- (void)attchFrameBufferTexture:(LGFrameBufferTexture *)texture;
- (void)attchRenderBufferObject:(LGRenderBufferObject *)rbo;
- (BOOL)complete;
- (void)bind;
- (void)unBind;
@end

NS_ASSUME_NONNULL_END
