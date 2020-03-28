//
//  LGTexture.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGTexture.h"

@interface LGTexture()
@property (nonatomic, strong) GLKTextureInfo *texture;
@end
@implementation LGTexture
- (instancetype)initWithPath:(NSString *)path {
    NSError *err = nil;
    if (self = [super init]) {
       self.texture = [GLKTextureLoader textureWithContentsOfFile:path options:@{GLKTextureLoaderOriginBottomLeft:@(YES)} error:&err];
    }
    return self;
}

- (GLuint)name {
    return self.texture.name;
}
@end
