//
//  FilterController.m
//  opengles-lesson-review
//
//  Created by Sam on 2020/4/9.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "FilterController.h"
#import <LGLKit/LGLKit.h>
@implementation FilterController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *i = [UIImage imageNamed:@"cap"];
    UIImageView *v = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
    v.image = i;
    [self.view addSubview:v];
    EAGLContext  *context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES3];
    LGProcessor *p = [[LGProcessor alloc] initWithContext:context];
    
    NSString *f1Shader = @"#version 300 es\
                            precision mediump float;\
                            uniform sampler2D texture1;\
                            in vec2 texcoord;\
                            out vec4 fragColor;\
                            const float step_size = 0.01;\
                            void main() {\
                                fragColor = texture(texture1, vec2(floor(texcoord.x/step_size) * step_size, floor(texcoord.y/step_size) * step_size));\
                            }";
    LGFilter *f1 = [[LGFilter alloc] initWithFragmentShader:f1Shader];
    
    NSString *f2Shader = @"#version 300 es\
                           precision mediump float;\
                           uniform sampler2D texture1;\
                           in vec2 texcoord;\
                           out vec4 fragColor;\
                           const float ud = 80.0;\
                           void main() {\
                               float radius = 0.2;\
                               vec2 origin = vec2(0.5, 0.5);\
                               vec2 xy = texcoord;\
                               vec2 dxy = xy - origin;\
                               float dst = length(dxy);\
                               float angle = atan(dxy.x, dxy.y) + radians(ud) * (1.0 - (dst/radius) * (dst/radius));\
                               if (dst <= radius) {\
                                   xy = vec2(radius, radius) + dst * vec2(cos(angle), sin(angle));\
                               }\
                               fragColor = texture(texture1, xy);\
                           }";
    LGFilter *f2 =  [[LGFilter alloc] initWithFragmentShader:f2Shader];
    
    [p addFilter:f1];
    [p addFilter:f2];
    UIImage *i1 = [UIImage imageNamed:@"cap"];
    i1 = [p processImage:i1];

    UIImageView *v1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 350, self.view.frame.size.width, 200)];
    v1.image = i1;
    [self.view addSubview:v1];

}


- (NSString *)sourcePathForName:(NSString *)name {
    NSArray *arr = [name componentsSeparatedByString:@"."];
    NSString *fileName = arr.firstObject;
    NSString *fileExt = arr.lastObject;
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:fileExt];
    return path;
}
@end
