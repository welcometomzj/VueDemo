//
//  OIVideoCaptor.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-3-31.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIProducer.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

typedef enum OIVideoCaptorOrientation_ {
    OIVideoCaptorOrientationUnknown            = UIDeviceOrientationUnknown,
    OIVideoCaptorOrientationPortrait           = UIDeviceOrientationPortrait,
    OIVideoCaptorOrientationPortraitUpsideDown = UIDeviceOrientationPortraitUpsideDown,
    OIVideoCaptorOrientationLandscapeLeft      = UIDeviceOrientationLandscapeLeft,
    OIVideoCaptorOrientationLandscapeRight     = UIDeviceOrientationLandscapeRight
} OIVideoCaptorOrientation;

typedef enum OIVideoCaptorFocusMode_ {
    OIVideoCaptorFocusModeLocked              = AVCaptureFocusModeLocked,
	OIVideoCaptorFocusModeAutoFocus           = AVCaptureFocusModeAutoFocus,
	OIVideoCaptorFocusModeContinuousAutoFocus = AVCaptureFocusModeContinuousAutoFocus,
} OIVideoCaptorFocusMode;

typedef enum OIVideoCaptorExposureMode_ {
    OIVideoCaptorExposureModeLocked					= AVCaptureExposureModeLocked,
	OIVideoCaptorExposureModeAutoExpose				= AVCaptureExposureModeAutoExpose,
	OIVideoCaptorExposureModeContinuousAutoExposure	= AVCaptureExposureModeContinuousAutoExposure,
} OIVideoCaptorExposureMode;

@class OIVideoCaptor;

@protocol OIVideoCaptorDelegate <NSObject>

@optional
- (void)videoCaptor:(OIVideoCaptor *)videoCaptor willOutputVideoSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end

@interface OIVideoCaptor : OIProducer <AVCaptureVideoDataOutputSampleBufferDelegate, UIAccelerometerDelegate>
{
    dispatch_queue_t cameraQueue_;
    
    AVCaptureSession *cameraSession_;
    AVCaptureDevice *camera_;
    AVCaptureDeviceInput *videoInput_;
    AVCaptureVideoDataOutput *videoOutput_;
    
    id<OIVideoCaptorDelegate> delegate_;
    AVCaptureDevicePosition position_;
    NSString *sessionPreset_;
    int frameRate_;
    OIVideoCaptorFocusMode focusMode_;
    CGPoint focusPoint_;
    OIVideoCaptorExposureMode exposureMode_;
    CGPoint exposurePoint_;
    float exposureTargetBias_;
    
    CMMotionManager *videoCaptorMotionManager_;
    
    OIVideoCaptorOrientation orientation_;
}

@property (assign, nonatomic) id <OIVideoCaptorDelegate> delegate;
@property (readonly, nonatomic) AVCaptureDevicePosition position;  // The value of this property is an AVCaptureDevicePosition indicating where the receiver's device is physically located on the system hardware.
@property (readwrite, copy, nonatomic) NSString *sessionPreset;
@property (readwrite, nonatomic) CMTime minFrameDuration;  // Default value is kCMTimeInvalid.
@property (readwrite, nonatomic) CMTime maxFrameDuration;  // Default value is kCMTimeInvalid.
@property (readwrite, nonatomic) int frameRate;
@property (readwrite, nonatomic) OIVideoCaptorFocusMode focusMode;
@property (readwrite, nonatomic) CGPoint focusPoint;
@property (readwrite, nonatomic) OIVideoCaptorExposureMode exposureMode;
@property (readwrite, nonatomic) CGPoint exposurePoint;
@property (readwrite, nonatomic) float exposureTargetBias;

- (id)initWithCameraPosition:(AVCaptureDevicePosition)cameraPosition sessionPreset:(NSString *)sessionPreset;

@property (readonly, nonatomic) OIVideoCaptorOrientation orientation;

- (void)startRunning;
- (void)stopRunning;
- (void)switchCamera;  // Switching the receiver's position between AVCaptureDevicePositionFront and AVCaptureDevicePositionBack.

@end
