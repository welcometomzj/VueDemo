//
//  OIRGBAFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-8-21.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIFilter.h"

@interface OIRGBAFilter : OIFilter

// Normalized values by which each color channel is multiplied. The range is from 0.0 up, with 1.0 as the default.
@property (readwrite, nonatomic) float redFactor;
@property (readwrite, nonatomic) float greenFactor;
@property (readwrite, nonatomic) float blueFactor;
@property (readwrite, nonatomic) float alphaFactor;

@end
