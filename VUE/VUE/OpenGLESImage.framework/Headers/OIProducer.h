//
//  OIProducer.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-2-24.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <CoreMedia/CoreMedia.h>
#import "OIProducerAnimationTimer.h"

@class OIProducer;

@protocol OIProducerAnimationDelegate <NSObject>

@optional
- (void)animationDidBegin:(NSString *)animationID;
- (void)animationDidFinish:(NSString *)animationID;

@end


@protocol OIConsumer;

@class OITexture;

enum OIProducerAnimationStatus_ {
    OIProducerAnimationStatusNoAnimation,
    OIProducerAnimationStatusConfiguring,
    OIProducerAnimationStatusRendering,
    OIProducerAnimationStatusPaused
};

typedef enum OIProducerAnimationStatus_ OIProducerAnimationStatus;

enum OIProducerAnimationRepeatMode_ {
    OIProducerAnimationRepeatModeNormal,
    OIProducerAnimationRepeatModeMirrored
};

typedef enum OIProducerAnimationRepeatMode_ OIProducerAnimationRepeatMode;

enum OIProducerAnimationEasingMode_ {
    OIProducerAnimationEasingModeLinear,
    OIProducerAnimationEasingModeEaseInSine,
    OIProducerAnimationEasingModeEaseOutSine,
    OIProducerAnimationEasingModeEaseInOutSine
};

typedef enum OIProducerAnimationEasingMode_ OIProducerAnimationEasingMode;

@interface OIProducer : NSObject
{
    dispatch_semaphore_t imageProcessingSemaphore_;
    
    BOOL enabled_;
    NSMutableArray *consumers_;
    CGRect outputFrame_;
    OITexture *outputTexture_;
    
    double animationDelay_;
    double animationDuration_;
    float animationRepeatCount_;
    OIProducerAnimationRepeatMode animationRepeatMode_;
    OIProducerAnimationEasingMode animationEasingMode_;
    CGRect originalOutputFrame_;
    CGRect targetOutputFrame_;
}

@property (readwrite, nonatomic, getter = isEnabled) BOOL enabled;
@property (readwrite, nonatomic) CGRect outputFrame;
@property (readonly, nonatomic) NSArray *consumers;
@property (readwrite, nonatomic) int tag;

/*Animation Properties*/
@property (readwrite, nonatomic) double animationDelay;  // Default is 0.0.
@property (readwrite, nonatomic) double animationDuration;  // Default is 1.0.
@property (readwrite, nonatomic) float animationRepeatCount;  // Default is 0.0.
@property (readwrite, nonatomic) OIProducerAnimationRepeatMode animationRepeatMode;  // Default is OIProducerAnimationRepeatModeNormal
@property (readwrite, nonatomic) OIProducerAnimationEasingMode animationEasingMode;  // Default is OIProducerAnimationEasingModeLinear.

- (void)addConsumer:(id <OIConsumer>)consumer;
- (void)replaceConsumer:(id <OIConsumer>)consumer withNewConsumer:(id <OIConsumer>)newConsumer;
- (void)removeConsumer:(id <OIConsumer>)consumer;
- (void)removeAllConsumers;

- (void)deleteOutputTexture;

- (void)produceAtTime:(CMTime)time;

/* Animation Methods*/

+ (OIProducerAnimationStatus)animationStatus;
+ (BOOL)beginAnimationConfigurationWithAnimationID:(NSString *)animationID;
+ (void)commitAnimationConfiguration;
+ (void)pauseAnimation;
+ (void)restartAnimaion;
+ (void)cancelAnimation;
+ (void)setAnimationDelegate:(id<OIProducerAnimationDelegate>)animationDelegate;
+ (void)setAnimationFrameRate:(NSInteger)frameRate;  // Default is 30fps.

/* Animation Hooks */

- (void)determineAnimationParametersWithTime:(CMTime)time;
- (void)calculateAnimationParametersWithFactor:(double)animationFactor;
- (void)setAnimationParametersToOriginalForRepeat;
- (void)setAnimationParametersToTargetForFinish;

@end
