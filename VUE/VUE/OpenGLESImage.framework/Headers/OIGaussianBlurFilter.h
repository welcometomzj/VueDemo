//
//  OIGaussianBlurFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-4-23.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OITwoPassesFilter.h"

@interface OIGaussianBlurFilter : OITwoPassesFilter

@property (readwrite, nonatomic) int radius;

@end
