//
//  OIProducerAnimationTimer.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-9-19.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OIProducer;

@interface OIProducerAnimationTimer : NSObject

+ (OIProducerAnimationTimer *)defaultProducerAnimationTimer;

@property (readwrite, nonatomic) NSInteger frameRate;

@property (readonly, nonatomic, getter=isRunning) BOOL running;

@property (copy, nonatomic) void (^animationTimerDidStartBlock)(void);
@property (copy, nonatomic) void (^animationTimerWillStopBlock)(void);
@property (copy, nonatomic) void (^animationTimerDidStopBlock)(void);

- (void)setTarget:(OIProducer *)target;

/*
 Animation Control
 */
@property (readwrite, nonatomic) BOOL paused;

- (BOOL)start;
- (void)stop;

@end
