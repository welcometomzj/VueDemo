//
//  OIFastSurfaceBlurFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-5-28.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OITwoPassesFilter.h"

@interface OIFastSurfaceBlurFilter : OITwoPassesFilter

@property (readwrite, nonatomic) int radius;

@property (readwrite, nonatomic) int stepDistance;

@end
