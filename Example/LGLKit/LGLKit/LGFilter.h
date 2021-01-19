//
//  LGFilter.h
//  LGLKit
//
//  Created by Sam on 2020/4/7.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGLInclude.h"
#import "LGProgram.h"
NS_ASSUME_NONNULL_BEGIN

static NSString *const LGLVertexShaderSrc = LGLSHADER_STRING
(
\#version 300 es
precision mediump float;
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aTexcoord;
out vec2 texcoord;
void main() {
    gl_Position = vec4(aPos, 1);
    texcoord = aTexcoord;
}
);

static NSString *const LGLFragmentShaderSrc = LGLSHADER_STRING
(
\#version 300 es
precision mediump float;
in vec2 texcoord;
uniform sampler2D texture1;
out vec4 FragColor;
void main() {
    FragColor = texture(texture1, texcoord);
}
);

@interface LGFilter : NSObject

@property (nonatomic, assign) GLuint inTexture;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, readonly) LGProgram *program;
@property (nonatomic, readonly) GLuint outTexture;
@property (nonatomic, readonly) UIImage *outImage;


- (instancetype)initWithFragmentShader:(NSString *)shaderSrc renderBlock:(void(^)(LGProgram *program))renderBlock;
- (instancetype)initWithFragmentShader:(NSString *)shaderSrc;
@end

NS_ASSUME_NONNULL_END
