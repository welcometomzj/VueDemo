//
//  OIMaskFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-8-20.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIFilter.h"

@interface OIMaskFilter : OIFilter

@property (readwrite, nonatomic) CGRect maskBounds;  // The alpha value will be set to 0.0 which in the area outside maskBounds. Default is covering the whole contentSize.
@property (readwrite, nonatomic) float maskAlpha;  // Setting the alpha value in maskBounds. It is a value between 0.0 and 1.0. If the value be set into this property is not belong to the range above, it will be clamp between 0.0 to 1.0. Default is 1.0.

@end
