//
//  OIAnimationScriptItem.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 15/8/4.
//  Copyright (c) 2015年 Kwan Yiuleung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <OpenGLESImage/OIMaths.h>

typedef enum OIAnimationScriptItemTargetType_ {
    OIAnimationScriptItemTargetTypeBackground,
    OIAnimationScriptItemTargetTypeImage,
    OIAnimationScriptItemTargetTypeMask,
    OIAnimationScriptItemTargetTypeImageInMask,
    OIAnimationScriptItemTargetTypeText,
    OIAnimationScriptItemTargetTypeTextBackground,
    OIAnimationScriptItemTargetTypeLightingEffect,
    OIAnimationScriptItemTargetTypeCover
} OIAnimationScriptItemTargetType;

typedef enum OIAnimationEasingMode_ {
    OIAnimationEasingModeLinear,
    OIAnimationEasingModeEaseInSine,
    OIAnimationEasingModeEaseOutSine,
    OIAnimationEasingModeEaseInOutSine
} OIAnimationEasingMode;

static const float   kOIAnimationScriptItemNoAlpha = -1.0;
static const float   kOIAnimationScriptItemNoBlur  = -1.0;
static const OIColor kOIAnimationScriptItemNoTone  = {-1.0, -1.0, -1.0, -1.0};

@class OIProducer;
@class OIAnimationLayerConfiguration;
@class OIAnimationLayerMixerConfiguration;

@interface OIAnimationScriptItem : NSObject

+ (OIAnimationScriptItem *)animationScriptItemWithTarget:(OIProducer *)target targetType:(OIAnimationScriptItemTargetType)targetType targetIndex:(int)targetIndex startTime:(float)startTime endTime:(float)endTime;

@property (retain, nonatomic) OIProducer *target;

@property (nonatomic) OIAnimationScriptItemTargetType targetType;

@property (nonatomic) int targetIndex;

@property (nonatomic) float startTime;
@property (nonatomic) float endTime;

@property (nonatomic) CGRect originalBounds;
@property (nonatomic) CGRect finalBounds;

@property (nonatomic) float originalAlpha;
@property (nonatomic) float finalAlpha;

@property (nonatomic) float originalBlurSize;
@property (nonatomic) float finalBlurSize;

@property (nonatomic) OIColor originalTone;
@property (nonatomic) OIColor finalTone;

@property (nonatomic) OIAnimationEasingMode easingMode;

- (BOOL)isAvailableAtTime:(float)seconds;

- (OIAnimationLayerConfiguration *)layerConfigurationAtTime:(float)seconds;
- (OIAnimationLayerMixerConfiguration *)layerMixerConfigurationAtTime:(float)seconds;

@end
