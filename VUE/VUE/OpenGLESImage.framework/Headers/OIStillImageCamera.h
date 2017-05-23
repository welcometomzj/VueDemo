//
//  OIStillImageCamera.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-3-31.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIVideoCaptor.h"


typedef enum _OIStillImageCameraFlashMode {
    OIStillImageCameraFlashModeOff   = 0,
    OIStillImageCameraFlashModeOn    = 1,
    OIStillImageCameraFlashModeAuto  = 2,
    OIStillImageCameraFlashModeTorch = 3
} OIStillImageCameraFlashMode;

@class UIImage;

@interface OIStillImageCamera : OIVideoCaptor

@property (readonly, nonatomic) BOOL hasFlash;

@property (readwrite, nonatomic) OIStillImageCameraFlashMode flashMode;

- (void)captureImageSampleBufferAsynchronouslyWithCompletionHandler:(void (^)(CMSampleBufferRef imageSampleBuffer, NSError *error))handler;
- (void)captureOriginalImageAsynchronouslyWithCompletionHandler:(void (^)(UIImage *originalImage, NSError *error))handler;
- (void)captureProcessedImageAsynchronouslyWithCompletionHandler:(void (^)(UIImage *processedImage, NSError *error))handler;
- (void)captureOriginalImageAndProcessedImageAsynchronouslyWithCompletionHandler:(void (^)(UIImage *originalImage, UIImage *processedImage, NSError *error))handler;

@end
