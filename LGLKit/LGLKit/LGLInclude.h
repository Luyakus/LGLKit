//
//  LGLInclude.h
//  LGLKit
//
//  Created by Sam on 2020/3/24.
//  Copyright © 2020 Sam. All rights reserved.
//

#ifndef LGLInclude_h
#define LGLInclude_h

#if TARGET_OS_IPHONE

#import <OpenGLES/ES3/gl.h>

#elif TARGET_OS_MAC

#include <GLFW/glfw3.h>
#import <OpenGL/gl3.h>

#endif

#import <GLKit/GLKit.h>

#endif /* LGLInclude_h */