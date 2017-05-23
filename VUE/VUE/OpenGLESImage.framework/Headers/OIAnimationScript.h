//
//  OIAnimationScript.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 15/8/4.
//  Copyright (c) 2015年 Kwan Yiuleung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface OIAnimationScript : NSObject

- (instancetype)initWithScriptItems:(NSArray *)items;

@property (nonatomic) float totalTime;

@property (nonatomic) int frameRate;

@property (nonatomic) CGSize frameSize;

- (NSArray *)layerConfigurationsAtTime:(float)seconds;
- (NSArray *)layerMixerConfigurationsAtTime:(float)seconds;

@end
