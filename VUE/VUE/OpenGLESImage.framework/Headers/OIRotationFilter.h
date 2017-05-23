//
//  OIRotationFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-7-21.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIFilter.h"

@interface OIRotationFilter : OIFilter

@property (readwrite, nonatomic) CGPoint anchorPoint;

@property (readwrite, nonatomic) float degrees;

@end
