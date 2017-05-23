//
//  OIVerticalBoxBlurFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-11-5.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIFilter.h"

@interface OIVerticalBoxBlurFilter : OIFilter

@property (nonatomic) float blurSize;  // A scaling for the size of the applied blur, default of 1.0.

@end
