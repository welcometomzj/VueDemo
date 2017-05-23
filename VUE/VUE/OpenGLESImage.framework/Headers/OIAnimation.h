//
//  OIAnimation.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 15/6/26.
//  Copyright (c) 2015年 Kwan Yiuleung. All rights reserved.
//

#import <OpenGLESImage/OpenGLESImage.h>

enum OIAnimationStatus_ {
    OIAnimationStatusReady,
    OIAnimationStatusPlaying,
    OIAnimationStatusPaused
};

typedef enum OIAnimationStatus_ OIAnimationStatus;

@class OIAnimation;

@protocol OIAnimationDelegate <NSObject>

@optional
- (void)animationDidEnd:(OIAnimation *)animation;

@end

@class OIAnimationScript;

@interface OIAnimation : OIProducer

- (instancetype)initWithScript:(OIAnimationScript *)script;

@property (assign, nonatomic) id <OIAnimationDelegate> delegate;

@property (readonly, nonatomic) OIAnimationStatus status;

- (void)start;
- (void)pause;
- (void)stop;

@end
