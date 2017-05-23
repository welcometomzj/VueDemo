//
//  CameraViewController.m
//  VUE
//
//  Created by admin on 17/2/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CameraViewController.h"
#import "EditViewController.h"

#define kLimitRecLen 3.0f
#define kRecordW 70
#define kRecordCenter CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height - 43 -35)

@interface CameraViewController ()
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, strong) NSMutableArray *tempVideoUrls;
@end

@implementation CameraViewController
{
    NSUInteger videoCount;
    CGFloat _allTime;
}
@dynamic view;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.recordBtn addTarget:self action:@selector(startRecord) forControlEvents:UIControlEventTouchUpInside];
    [self.view.deleteVideoBtn addTarget:self action:@selector(deleteVideo) forControlEvents:UIControlEventTouchUpInside];
    [self.view.changeCameraBtn addTarget:self action:@selector(changeCamera) forControlEvents:UIControlEventTouchUpInside];
    
#if !TARGET_IPHONE_SIMULATOR
    //真机情况下创建镜头
    [self createCamera];
#endif
    
}
- (void)loadView
{
    CameraView *cameraView = [CameraView new];
    self.view = cameraView;
}

- (CameraView *)view
{
    return (CameraView *)super.view;
}

#pragma mark -创建镜头
- (void)createCamera
{
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (videoAuthStatus == AVAuthorizationStatusNotDetermined) {
        
        ///询问用户权限：相机、麦克风。
        [self enquireUserAuthority];
        
    } else if (videoAuthStatus == AVAuthorizationStatusRestricted || videoAuthStatus == AVAuthorizationStatusDenied) {
        
//        [self anotherTimeEnquireUserAuthority];
    } else {
        
        ///立即创建镜头
        [self authorizedCreateCamera];
    }
}

#pragma mark - 初始化camera_

//权限允许后，初始化camera_
- (void)authorizedCreateCamera
{
    writerAdaptor_ = [[OIFilter alloc] initWithContentSize:self.view.previewView.contentSize];
    writerAdaptor_.outputFrame = CGRectMake(0, 0, 1080, 1920);
    camera_ = [[FCHCamera alloc] initWithCameraPosition:AVCaptureDevicePositionBack sessionPreset:AVCaptureSessionPreset1920x1080];
    camera_.sessionPreset = AVCaptureSessionPreset640x480;
    camera_.delegate = self;
    
    NSString *path = [self getVideoPathWithDeleteExitPath:YES];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    //NSDictionary *videoCompressionProps = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:1.6*1024.0*1024.0], AVVideoAverageBitRateKey, nil];
    //videoCompressionProps, AVVideoCompressionPropertiesKey
    NSDictionary *writerSetting = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecH264, AVVideoCodecKey, nil];
    
    videoWriter_ = [[OIAudioVideoWriter alloc] initWithContentSize:CGSizeMake(1080.0, 1920.0) outputURL:fileURL fileType:AVFileTypeQuickTimeMovie settings:writerSetting];
    videoWriter_.delegate = self;
    videoWriter_.shouldWriteWithAudio = YES;
    videoWriter_.writingInRealTime = YES;
    videoWriter_.enabled = NO;
    videoWriter_.compressionAudioSettings = [camera_ recommendedAudioSettingsForWriterWithOutputFileType:AVFileTypeQuickTimeMovie];
    [writerAdaptor_ addConsumer:videoWriter_];
    
    camera_.microphoneEnabled = YES;
    
    CGRect outputFrame;
    outputFrame.origin.y = 0.0;
    outputFrame.size.height = self.view.previewView.contentSize.height;
    outputFrame.size.width = outputFrame.size.height/4.0*3.0;
    outputFrame.origin.x = (self.view.previewView.contentSize.width - outputFrame.size.width)/2.0;
    camera_.outputFrame = outputFrame;
    [camera_ addConsumer:self.view.previewView];
    [camera_ addConsumer:writerAdaptor_];
    [camera_ startRunning];
}

#pragma mark - Button Action

//开始录像
- (void)startRecord
{
#if !TARGET_IPHONE_SIMULATOR
    if (videoRecording_) {
        return;
    }
    if (videoCount>2) {
        EditViewController *edVc = [EditViewController new];
        edVc.didExitVideo = YES;
        [self.navigationController pushViewController:edVc animated:YES];
        return;
    }
    videoRecording_ = YES;
    
    camera_.microphoneEnabled = YES;
    videoWriter_.enabled = YES;
    
    //3秒最长录制时间
    [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(stopRecordingVideo) userInfo:nil repeats:NO];
    
    self.view.baseView.hidden = YES;
    self.view.timeLabel.hidden = NO;
    [self.view.layer addSublayer:self.view.progressLayer];
    
    _timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(timerupdating)];
    _timer.frameInterval = 3;
    [_timer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    _allTime = 0;
#else
    EditViewController *edVc = [EditViewController new];
    [self.navigationController pushViewController:edVc animated:YES];
#endif
}

//停止录像
- (void)stopRecordingVideo
{
    if (videoRecording_) {
        camera_.microphoneEnabled = NO;
        videoWriter_.enabled = NO;
        [videoWriter_ finishWriting];
        videoRecording_ = NO;
        [_timer invalidate];
        _timer = nil;
        [self.view.progressLayer removeFromSuperlayer];
        self.view.baseView.hidden = NO;
        self.view.timeLabel.hidden = YES;
    }
}

//删除视频
- (void)deleteVideo
{
    videoCount -= 1;
    if (videoCount == 0) {
        self.view.deleteVideoBtn.hidden = YES;
    }
    
    if (videoCount <3) {
        self.view.effectView.hidden = YES;
        self.view.recordNextImage.hidden = YES;
    }
    NSString *path = [self getVideoPathWithDeleteExitPath:YES];

    NSURL *fileURL = [NSURL fileURLWithPath:path];
    videoWriter_.outputURL = fileURL;
    
    self.view.progress = videoCount;
    
    [self.tempVideoUrls removeObject:[NSURL fileURLWithPath:[self getVideoPathWithDeleteExitPath:NO]]];
}

//切换前后镜头
- (void)changeCamera
{
    CATransition *animation = [CATransition animation];
    animation.duration = .5f;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = @"oglFlip";
    animation.subtype = kCATransitionFromRight;
    [self.view.layer addAnimation:animation forKey:nil];
    
    [camera_ switchCamera];
}

//定时器方法
- (void)timerupdating {
    _allTime += 0.05;
    [self updateProgress:_allTime / kLimitRecLen];
}

//更新进度条
- (void)updateProgress:(CGFloat)value {
    NSLog(@"%f",value);
    NSAssert(value <= 1.0 && value >= 0.0, @"Progress could't accept invail number .");
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:kRecordCenter radius:kRecordW / 2 startAngle:- M_PI_2 endAngle:2 * M_PI * (value) - M_PI_2 clockwise:YES];
    self.view.progressLayer.path = path.CGPath;
    self.view.timeLabel.text = [NSString stringWithFormat:@"%.1f",(1-value) * 3];
}

#pragma mark - 请求权限

- (void)enquireUserAuthority
{
    AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    AVAuthorizationStatus audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    if (videoAuthStatus && audioAuthStatus) { //镜头和麦克风都允许
        [self authorizedCreateCamera];
    } else {
        if(videoAuthStatus == AVAuthorizationStatusNotDetermined){
            [self enquireUserCameraAuthority];
        }
        if(audioAuthStatus == AVAuthorizationStatusNotDetermined){
            [self enquireUserMicAuthority];
        }
    }
}
///麦克风权限
- (void)enquireUserMicAuthority
{
    NSString *mediaType = AVMediaTypeAudio;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus ==AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        //        NSLog(@"Mic Restricted");
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    else if(authStatus == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            if(granted){
                AVAuthorizationStatus videoAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                if (videoAuthStatus) {
                    [self authorizedCreateCamera];
                }
            }
        }];
    }
}

///相机权限
- (void)enquireUserCameraAuthority
{
    __weak typeof(self)weakSelf = self;
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    
    if(authStatus ==AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
    else if(authStatus == AVAuthorizationStatusNotDetermined){
        [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
            if(granted){
                AVAuthorizationStatus audioAuthStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
                if (audioAuthStatus) {
                    [weakSelf authorizedCreateCamera];
                }
            }
        }];
    }
}

#pragma mark -OIAudioVideoWriterDelegate

- (void)audioVideoWriterRequestNextAudioSampleBuffer:(OIAudioVideoWriter *)audioVideoWriter
{
    
}

- (void)audioVideoWriterDidfinishWriting:(OIAudioVideoWriter *)audioVideoWriter
{
    //回到主线程
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (self.view.deleteVideoBtn.hidden) {
            self.view.deleteVideoBtn.hidden = NO;
        }
        
        [self.tempVideoUrls addObject:[NSURL fileURLWithPath:[self getVideoPathWithDeleteExitPath:NO]]];
        
        if (videoCount >=2) {
            EditViewController *editVc = [EditViewController new];
            editVc.paths = self.tempVideoUrls;
            [self.navigationController pushViewController:editVc animated:YES];
            self.view.effectView.hidden = NO;
            self.view.recordNextImage.hidden = NO;
        }
        
        videoCount += 1;
        self.view.progress = videoCount;
        NSString *path = [self getVideoPathWithDeleteExitPath:YES];
        NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
        videoWriter_.outputURL = fileURL;
    });
}

#pragma mark - FCHCameraDelegate

- (void)camera:(FCHCamera *)camera didReceiveAudioSampleBuffer:(CMSampleBufferRef)sampleBuffer
{
    if (videoWriter_.isEnabled) {
        [videoWriter_ writeWithAudioSampleBuffer:sampleBuffer];
    }
}

#pragma mark -

//创建视频路径
//deleteExitPath 删除该路径已存在的文件
- (NSString *)getVideoPathWithDeleteExitPath:(BOOL)deleteExitPath
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *storePath = [documentPath stringByAppendingPathComponent:@"TempVideos"];
    if(![fileManager fileExistsAtPath:storePath]){
        [fileManager createDirectoryAtPath:storePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *realName = [NSString stringWithFormat:@"tempVideo%ld.mp4", videoCount];
    storePath = [storePath stringByAppendingPathComponent:realName];
    if (deleteExitPath) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:storePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:storePath error:nil];
        }
    }
    return storePath;
}

- (NSMutableArray *)tempVideoUrls
{
    if (!_tempVideoUrls) {
        _tempVideoUrls = [NSMutableArray arrayWithCapacity:3];
    }
    return _tempVideoUrls;
}

@end
