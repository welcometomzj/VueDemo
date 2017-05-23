//
//  OIToneFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-10-27.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIFilter.h"

@interface OIToneFilter : OIFilter

- (id)initWithRed:(float)red green:(CGFloat)green blue:(CGFloat)blue percentage:(CGFloat)percentage;

@property(nonatomic) float red;
@property(nonatomic) float green;
@property(nonatomic) float blue;
@property(nonatomic) float percentage;

@end
