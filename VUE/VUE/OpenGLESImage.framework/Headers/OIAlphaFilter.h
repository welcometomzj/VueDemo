//
//  OIAlphaFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-8-1.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIFilter.h"

@interface OIAlphaFilter : OIFilter

@property (readwrite, nonatomic) float alpha;  //It is a value between 0.0 and 1.0. If the value be set into this property is not belong to the range above, it will be set to 0.0 or 1.0. Default is 0.5.

@end
