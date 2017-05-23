//
//  OIVideoCamera.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-12-1.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIVideoCaptor.h"

@class OIVideoCamera;

@protocol OIVideoCameraDelegate <NSObject, OIVideoCaptorDelegate>

@optional
- (void)videoCamera:(OIVideoCamera *)videoCamera didReceiveAudioSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end

@interface OIVideoCamera : OIVideoCaptor <AVCaptureAudioDataOutputSampleBufferDelegate>

@property (assign, nonatomic) id <OIVideoCameraDelegate> delegate;

@end
