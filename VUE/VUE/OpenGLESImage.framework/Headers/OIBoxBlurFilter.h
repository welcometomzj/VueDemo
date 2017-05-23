//
//  OIBoxBlurFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-8-13.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OITwoPassesFilter.h"

@interface OIBoxBlurFilter : OITwoPassesFilter

@property(readwrite, nonatomic) float blurSize;  // A scaling for the size of the applied blur, default of 1.0.

@end
