//
//  OIMultiRendersFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-11-4.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIFilter.h"

@interface OIMultiRendersFilter : OIFilter
{
    int renderCount_;
    int currentRenderCount_;
}

@property (readwrite, nonatomic) int renderCount;  //It determines receiver render how many times between another output. Default is 2.

@end
