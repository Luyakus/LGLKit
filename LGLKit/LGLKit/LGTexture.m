//
//  LGTexture.m
//  opengl-lesson-review
//
//  Created by Sam on 2020/3/23.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGTexture.h"
#import "LGLInclude.h"
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


#if TARGET_OS_IPHONE
- (instancetype)initWithImage:(UIImage *)image {
    NSError *err = nil;
    if (self = [super init]) {
        NSData *data = UIImagePNGRepresentation(image);
//        UIImage *_ = [UIImage imageWithData:data];
        self.texture = [GLKTextureLoader textureWithContentsOfData:data options:@{GLKTextureLoaderOriginBottomLeft:@(YES)} error:&err];
    }
    return self;
}
#endif

- (void)active {
    glActiveTexture(GL_TEXTURE0 + self.textureUnit);
}

- (void)bind {
    glBindTexture(GL_TEXTURE_2D, self.texture.name);
}

- (GLuint)name {
    return self.texture.name;
}
@end
