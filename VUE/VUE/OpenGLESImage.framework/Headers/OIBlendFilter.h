//
//  OIBlendFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-7-25.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OITwoInputsFilter.h"

@interface OIBlendFilter : OITwoInputsFilter

@property (readwrite, nonatomic) float opacity;  //This property between 0.0 and 1.0 is used to set the opacity of first input texture. When it is not belong to the range above, the first input texture will be blend with the second input texture by its alpha value. Default is -1.0.

@end
