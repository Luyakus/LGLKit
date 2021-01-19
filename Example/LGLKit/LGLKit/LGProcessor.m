//
//  LGProcessor.m
//  LGLKit
//
//  Created by Sam on 2020/4/7.
//  Copyright © 2020 Sam. All rights reserved.
//

#import "LGProcessor.h"
#import "LGProcessorQueue.h"
#import "LGTexture.h"

@interface LGProcessor()
@property (nonatomic, strong) NSMutableArray <LGFilter *> *filters;
@property (nonatomic, weak) EAGLContext *context;
//@property (nonatomic, assign) CGSize imageSize;
@end

@implementation LGProcessor
- (instancetype)initWithContext:(EAGLContext *)context {
    [EAGLContext setCurrentContext:context];
    if (self = [super init]) {
        self.context = context;
        self.filters = @[].mutableCopy;
    }
    return self;
}

- (void)addFilter:(LGFilter *)filter {
    [self.filters addObject:filter];
}

- (UIImage *)processImage:(UIImage *)image {
    [EAGLContext setCurrentContext:self.context];
    LGTexture *texture = [[LGTexture alloc] initWithImage:image];
    LGFilter *preFilter = self.filters.firstObject;
    preFilter.size = image.size;
    preFilter.inTexture = texture.name;
    for (int i = 1; i < self.filters.count; i ++) {
        LGFilter *filter = self.filters[i];
        filter.size = image.size;
        filter.inTexture = preFilter.outTexture;
        preFilter = filter;
    }
    if (preFilter.outTexture) {
        UIImage *result = preFilter.outImage;
        return result;
    }
    return nil;
}


@end
