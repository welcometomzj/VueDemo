//
//  OIVideo.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-10-20.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIProducer.h"

@class AVAsset;

enum OIVideoStatus_ {
    OIVideoStatusWaiting,
    OIVideoStatusPlaying,
    OIVideoStatusPaused
};

typedef enum OIVideoStatus_ OIVideoStatus;

@class OIVideo;

@protocol OIVideoDelegate <NSObject>

@optional
- (void)video:(OIVideo *)video willOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer;
- (void)videoDidEnd:(OIVideo *)video;

@end

@interface OIVideo : OIProducer

- (id)initWithAVAsset:(AVAsset *)asset;
- (id)initWithURL:(NSURL *)URL;

@property (assign, nonatomic) id<OIVideoDelegate> delegate;

@property (retain, nonatomic) AVAsset *AVAsset;  //To set the AVAsset which be play by receiver.
@property (retain, nonatomic) NSURL *URL;  //If receiver do not init by (initWithURL:) and this property never be set, return nil. You can set the source video's URL by this, which be play by receiver.

@property (readonly, nonatomic) OIVideoStatus status;

@property (readonly, nonatomic) double duration; //返回视频的总长度，单位为秒。

@property (readwrite, nonatomic) BOOL playAtActualSpeed;  //Default is YES.

- (BOOL)play;
- (void)stop;

- (CMSampleBufferRef)copyNextAudioSampleBuffer;

@end
