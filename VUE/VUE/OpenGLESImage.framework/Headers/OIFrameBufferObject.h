//
//  OIFrameBufferObject.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-3-6.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class OITexture;
@class CAEAGLLayer;

typedef enum _OIFrameBufferObjectType {
    OIFrameBufferObjectTypeUnknow            = 0,
    OIFrameBufferObjectTypeOffscreen         = 1,
    OIFrameBufferObjectTypeForDisplay        = 2,
    OIFrameBufferObjectTypeSpecifiedCVBuffer = 3
} OIFrameBufferObjectType;

enum OIFrameBufferObjectContentMode_ {
    OIFrameBufferObjectContentModeNormal,
    OIFrameBufferObjectContentModeResizeToFill,     //The option to scale the content to fit the size of itself by changing the aspect ratio of the content if necessary.
    OIFrameBufferObjectContentModeResizeAspect,     //The option to scale the content to fit the size of the view by maintaining the aspect ratio. Any remaining area of the view’s bounds is transparent.
    OIFrameBufferObjectContentModeResizeAspectFill  //The option to scale the content to fill the size of the view. Some portion of the content may be clipped to fill the view’s bounds.
};
typedef enum OIFrameBufferObjectContentMode_ OIFrameBufferObjectContentMode;

@interface OIFrameBufferObject : NSObject

@property (readonly, nonatomic) CGSize size;
@property (readonly, nonatomic) OITexture *texture;
@property (readonly, nonatomic) OIFrameBufferObjectType type;
@property (nonatomic) OIFrameBufferObjectContentMode contentMode;

- (id)init;

- (void)setupStorageForOffscreenWithSize:(CGSize)fboSize;
- (void)setupStorageForDisplayFromLayer:(CAEAGLLayer *)layer;
- (void)setupStorageWithSpecifiedCVBuffer:(CVBufferRef)CVBuffer;

- (void)bindToPipeline;
- (void)clearBufferWithRed:(float)red green:(float)green blue:(float)blue alpha:(float)alpha;

- (const GLfloat *)verticesCoordinateForDrawableRect:(CGRect)rect;

@end
