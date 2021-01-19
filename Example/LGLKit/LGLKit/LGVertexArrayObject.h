//
//  LGVertexArrayObject.h
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLInclude.h"
#import "LGVertexBufferObject.h"
#import "LGElementBuffereObject.h"
NS_ASSUME_NONNULL_BEGIN

@interface LGVertexArrayObject : NSObject
@property (nonatomic, readonly) GLuint vao;
- (void)addVertexBufferObject:(LGVertexBufferObject *)vbo;
- (void)addElementBufferObject:(LGElementBuffereObject *)ebo;
- (void)draw;

@end

NS_ASSUME_NONNULL_END
