//
//  MACLGLKit.h
//  MACLGLKit
//
//  Created by Sam on 2020/3/24.
//  Copyright © 2020 Sam. All rights reserved.
//

#import <Foundation/Foundation.h>

//! Project version number for MACLGLKit.
FOUNDATION_EXPORT double MACLGLKitVersionNumber;

//! Project version string for MACLGLKit.
FOUNDATION_EXPORT const unsigned char MACLGLKitVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <MACLGLKit/PublicHeader.h>



#if TARGET_OS_IPHONE
#import <LGLKit/LGLInclude.h>
#import <LGLKit/LGElementBuffereObject.h>
#import <LGLKit/LGFragmentShader.h>
#import <LGLKit/LGProgram.h>
#import <LGLKit/LGShader.h>
#import <LGLKit/LGTexture.h>
#import <LGLKit/LGVertexArrayObject.h>
#import <LGLKit/LGVertexBufferObject.h>
#import <LGLKit/LGVertexShader.h>
#import <LGLKit/LGFrameBufferObject.h>
#import <LGLKit/LGRenderBufferObject.h>
#import <LGLKit/LGFrameBufferTexture.h>
#import <LGLKit/LGProcessor.h>
#import <LGLKit/LGFilter.h>
#elif TARGET_OS_MAC
#import <MACLGLKit/LGLInclude.h>
#import <MACLGLKit/LGElementBuffereObject.h>
#import <MACLGLKit/LGFragmentShader.h>
#import <MACLGLKit/LGProgram.h>
#import <MACLGLKit/LGShader.h>
#import <MACLGLKit/LGTexture.h>
#import <MACLGLKit/LGVertexArrayObject.h>
#import <MACLGLKit/LGVertexBufferObject.h>
#import <MACLGLKit/LGVertexShader.h>
#import <MACLGLKit/LGFrameBufferObject.h>
#import <MACLGLKit/LGRenderBufferObject.h>
#import <MACLGLKit/LGFrameBufferTexture.h>
#import <MACMACLGLKit/LGWindow.h>
#endif
