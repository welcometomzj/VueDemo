//
//  OIImage.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-3-27.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIProducer.h"


@class UIImage;

@interface OIImage : OIProducer

// Initialization Methods

- (id)initWithUIImage:(UIImage *)image;

@property (retain, nonatomic) UIImage *sourceImage;
@property (readonly, nonatomic) UIImage *processedImage;

// Animation Image

@property (readonly, nonatomic, getter=isAnimatedImage) BOOL animatedImage;  // If a OIImage instance is initialized with a animated UIImage, it will return YES. Otherwise return NO.
@property (nonatomic) float animatedImageDuration;  // It can not be set and will return 0.0 when the animatedImage return NO. If the animatedImage return YES, default is the UImage's duration which used to initialize.
@property (nonatomic) int animatedImageRepeatCount;  // It can not be set and return 0 when the animatedImage return NO. -1 means infinite (default is 0).

- (void)startImageAnimating;
- (void)stopImageAnimating;
- (void)pauseAnimating:(BOOL)pause;
- (BOOL)isImageAnimating;

@end
