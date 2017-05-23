//
//  FCHCamera.h
//  Facechat
//
//  Created by Kwan Yiuleung on 16/5/30.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <OpenGLESImage/OpenGLESImage.h>

@class FCHCamera;

@protocol FCHCameraDelegate <NSObject, OIVideoCaptorDelegate>

@optional
- (void)camera:(FCHCamera *)camera didReceiveAudioSampleBuffer:(CMSampleBufferRef)sampleBuffer;
- (void)camera:(FCHCamera *)camera didGetStringFromQRCode:(NSString *)result;

@end

/*!
 @class FCHCamera
 
 @abstract
 本项目中的主要镜头类。
 
 @discussion
 集成了视频流采集输出、音频采集输出，拍照和二维码扫描等功能。后续的视频流特效处理，音视频保存等功能需要配合OpenGLESImage框架里的其它类实现。由于镜头的初始化和启动、关闭均非常耗时，如无特殊需求，尽量使用此类的单例而不是另行实例化本类，以提高程序效率。
 
 */
@interface FCHCamera : OIStillImageCamera <AVCaptureAudioDataOutputSampleBufferDelegate, AVCaptureMetadataOutputObjectsDelegate>

/*!
 @method defaultCamera
 @abstract 本类的单例。
 @discussion 由于镜头的初始化和启动、关闭均非常耗时，如无特殊需求，尽量使用此单例而不是另行初始化，以提高程序效率。
 */
+ (FCHCamera *)defaultCamera;

@property (weak, nonatomic) id <FCHCameraDelegate> delegate;

@property (readwrite, getter=microphoneIsEnabled, nonatomic) BOOL microphoneEnabled;

@property (readwrite, getter=QRCodeDetectionIsEnabled, nonatomic) BOOL QRCodeDetectionEnabled;

- (NSDictionary *)recommendedAudioSettingsForWriterWithOutputFileType:(NSString *)outputFileType;

@end
