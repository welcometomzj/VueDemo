//
//  FCHCamera.m
//  Facechat
//
//  Created by Kwan Yiuleung on 16/5/30.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "FCHCamera.h"

@interface FCHCamera ()
{
    dispatch_queue_t microphoneQueue_;
    
    AVCaptureDevice *microphone_;
    AVCaptureDeviceInput *audioInput_;
    AVCaptureAudioDataOutput *audioOutput_;
    AVCaptureMetadataOutput *QRCodeOutput_;
}

@end

@implementation FCHCamera

@synthesize delegate;

#pragma mark -
#pragma mark - 类方法

FCHCamera *defaultCamera_ = nil;

/*!
 @method defaultCamera
 @abstract 本类的单例。
 @discussion 由于镜头的初始化和启动、关闭均非常耗时，如无特殊需求，尽量使用此单例而不是另行初始化，以提高程序效率。
 */
+ (FCHCamera *)defaultCamera
{
    if (defaultCamera_ == nil) {
        defaultCamera_ = [[FCHCamera alloc] initWithCameraPosition:AVCaptureDevicePositionBack sessionPreset:AVCaptureSessionPreset640x480];
    }
    
    return defaultCamera_;
}

#pragma mark - Lifecycle

- (void)dealloc
{
    microphone_ = nil;
    
    if (cameraSession_) {
        [self stopRunning];
        
        if (audioInput_) {
            [cameraSession_ removeInput:audioInput_];
            audioInput_ = nil;
        }
        if (audioOutput_) {
            [audioOutput_ setSampleBufferDelegate:nil queue:dispatch_get_main_queue()];
            [cameraSession_ removeOutput:audioOutput_];
            audioOutput_ = nil;
        }
    }
    
    if (microphoneQueue_) {
        microphoneQueue_ = NULL;
    }
}

- (id)init
{
    self = [self initWithCameraPosition:AVCaptureDevicePositionBack sessionPreset:AVCaptureSessionPresetHigh];
    if (self) {
        //
    }
    return self;
}

- (id)initWithCameraPosition:(AVCaptureDevicePosition)cameraPosition sessionPreset:(NSString *)sessionPreset
{
    self = [super initWithCameraPosition:cameraPosition sessionPreset:sessionPreset];
    
    if (self) {
        microphoneQueue_ = dispatch_queue_create("com.shuliansoftware.OpenGLESImage.microphoneQueue", NULL);
        
        [cameraSession_ beginConfiguration];
        
        microphone_ = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        
        NSError *error = nil;
        
        audioInput_ = [[AVCaptureDeviceInput alloc] initWithDevice:microphone_ error:&error];
        
        if (error) {
            NSLog(@"OpenGLESImage Error at FCHCamera - (id)initWithCameraPosition: sessionPreset:, message: %@.", error);
        }
        
        if ([cameraSession_ canAddInput:audioInput_])
        {
            [cameraSession_ addInput:audioInput_];
        }
        else {
            NSLog(@"OpenGLESImage Error at FCHCamera - (id)initWithCameraPosition: sessionPreset:, message: audio input can not be add.");
        }
        
        audioOutput_ = [[AVCaptureAudioDataOutput alloc] init];
        
        //由于加入mic的输出之后，引起很多bug，比如不能震动，后台音乐关闭等，故将添加mic输出的代码移到后面，等需要录音时再添加。
//        if ([cameraSession_ canAddOutput:audioOutput_])
//        {
//            [cameraSession_ addOutput:audioOutput_];
//        }
//        else
//        {
//            NSLog(@"OpenGLESImage Error at FCHCamera - (id)initWithCameraPosition: sessionPreset:, message: audio output can not be add.");
//        }
//        
//        [audioOutput_ setSampleBufferDelegate:self queue:microphoneQueue_];
        
        [cameraSession_ commitConfiguration];
    }
    
    return self;
}

#pragma mark - 属性的setter和getter

- (void)setMicrophoneEnabled:(BOOL)microphoneEnabled
{
    if (_microphoneEnabled == microphoneEnabled) {
        return;
    }
    
    _microphoneEnabled = microphoneEnabled;
    
    if (_microphoneEnabled) {
        [cameraSession_ beginConfiguration];
        
        if ([cameraSession_ canAddOutput:audioOutput_])
        {
            [cameraSession_ addOutput:audioOutput_];
        }
        else
        {
            NSLog(@"OpenGLESImage Error at FCHCamera - (id)initWithCameraPosition: sessionPreset:, message: audio output can not be add.");
        }
        
        [audioOutput_ setSampleBufferDelegate:self queue:microphoneQueue_];

        [cameraSession_ commitConfiguration];
    }
    else {
        [cameraSession_ beginConfiguration];
        
        [audioOutput_ setSampleBufferDelegate:nil queue:NULL];
        
        [cameraSession_ removeOutput:audioOutput_];
        
        [cameraSession_ commitConfiguration];
    }
}

- (void)setQRCodeDetectionEnabled:(BOOL)QRCodeDetectionEnabled
{
    if (QRCodeDetectionEnabled) {
        [cameraSession_ beginConfiguration];
        
        QRCodeOutput_ = [[AVCaptureMetadataOutput alloc] init];
        
        //设置代理监听输出对象的输出数据，在主线程中刷新
        [QRCodeOutput_ setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
        // 添加输出到会话中（判断session是否已满）
        if ([cameraSession_ canAddOutput:QRCodeOutput_])
        {
            [cameraSession_ addOutput:QRCodeOutput_];
        }
        else
        {
            NSLog(@"OpenGLESImage Error at FCHCamera - (id)initWithCameraPosition: sessionPreset:, message: qrcode output can not be add.");
        }
        
        //告诉输出对象, 需要输出什么样的数据 (二维码还是条形码等) 要先创建会话才能设置
        QRCodeOutput_.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        
        [cameraSession_ commitConfiguration];
    }
    else {
        [cameraSession_ beginConfiguration];
        
        [cameraSession_ removeOutput:QRCodeOutput_];
        
        [QRCodeOutput_ setMetadataObjectsDelegate:nil queue:NULL];
        
        QRCodeOutput_ = nil;
        
        [cameraSession_ commitConfiguration];
    }
    
    _QRCodeDetectionEnabled = QRCodeDetectionEnabled;
}

#pragma mark - 公有方法

- (NSDictionary *)recommendedAudioSettingsForWriterWithOutputFileType:(NSString *)outputFileType
{
    return [audioOutput_ recommendedAudioSettingsForAssetWriterWithOutputFileType:outputFileType];
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate & AVCaptureAudioDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if (!self.isEnabled) {
        return;
    }
    
    if (captureOutput == audioOutput_)
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(camera:didReceiveAudioSampleBuffer:)]) {
            CFRetain(sampleBuffer);
            [self.delegate camera:self didReceiveAudioSampleBuffer:sampleBuffer];
            CFRelease(sampleBuffer);
        }
    }
    else if (captureOutput == videoOutput_)
    {
        [super captureOutput:captureOutput didOutputSampleBuffer:sampleBuffer fromConnection:connection];
    }
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

//二维码扫描结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects.count > 0 && self.delegate && [self.delegate respondsToSelector:@selector(camera:didGetStringFromQRCode:)]) {
        AVMetadataMachineReadableCodeObject *metaDataObject = [metadataObjects firstObject];
        [self.delegate camera:self didGetStringFromQRCode:metaDataObject.stringValue];
    }
    
}

@end
