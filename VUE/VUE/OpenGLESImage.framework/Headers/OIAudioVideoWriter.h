//
//  OIAudioVideoWriter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-8-25.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "OIConsumer.h"

enum OIAudioVideoWriterStatus_ {
    OIAudioVideoWriterStatusWaiting   = 0,
    OIAudioVideoWriterStatusWriting   = 1,
    OIAudioVideoWriterStatusCompleted = 2,
    OIAudioVideoWriterStatusFailed    = 3,
    OIAudioVideoWriterStatusCancelled = 4
};

typedef enum OIAudioVideoWriterStatus_ OIAudioVideoWriterStatus;

@class OIAudioVideoWriter;

@protocol OIAudioVideoWriterDelegate <NSObject>

@optional

- (void)audioVideoWriterRequestNextAudioSampleBuffer:(OIAudioVideoWriter *)audioVideoWriter;

- (void)audioVideoWriterDidfinishWriting:(OIAudioVideoWriter *)audioVideoWriter;

@end

@interface OIAudioVideoWriter : NSObject <OIConsumer>

@property (assign, nonatomic) id<OIAudioVideoWriterDelegate> delegate;

@property (readonly, nonatomic) OIAudioVideoWriterStatus status;

@property (retain, nonatomic) NSURL *outputURL;  // Indicating the receiver's target file path. Once the receiver get the first input frame, the change of this property will work after - (void)finishWriting be call and the next first frame input.

@property (readwrite, nonatomic) int frameRate;  // It determine the count of frame that will be wrote per second. When it is 0, the frame rate will be determine by the time that is passed in by method - (void)renderRect:(CGRect)rect atTime:(CMTime)time. This property can not be changed if reciver's status is not OIAudioVideoWriterStatusWaiting. Default is 0.

@property (nonatomic) BOOL shouldWriteWithAudio;  // If you want to encode a video with audio by using - (void)writeWithAudioSampleBuffer: , you should set this property to YES before you input the first frame to receiver. Default is NO.

@property (retain, nonatomic) NSDictionary *compressionAudioSettings;  // When shouldWriteWithAudio is set to YES and this property is not set anything, receiver will use the default settings to compress the audio buffer input by - (void)writeWithAudioSampleBuffer: . You should set shouldWriteWithAudio to YES firstly and set this property before you input the first frame to receiver in order to the settings be set can work.

@property (readwrite, nonatomic, getter=isWritingInRealTime) BOOL writingInRealTime;  // When receiver should write in real time (e.g. writing video data from camera or writing audio data from mircophone), this property should be set to YES. Default is NO.

- (id)initWithContentSize:(CGSize)contentSize outputURL:(NSURL *)outputURL;  // Using AVFileTypeQuickTimeMovie file type.
- (id)initWithContentSize:(CGSize)contentSize outputURL:(NSURL *)outputURL fileType:(NSString *)outputFileType settings:(NSDictionary *)outputSettings;  // When receiver is writing audio data from mircophone, the outputFileType should be AVFileTypeQuickTimeMovie.

- (void)writeWithAudioSampleBuffer:(CMSampleBufferRef)audioSampleBuffer;

- (void)finishWriting;

@end
