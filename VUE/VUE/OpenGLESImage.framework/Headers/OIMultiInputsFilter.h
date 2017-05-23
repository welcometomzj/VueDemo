//
//  OIMultiInputsFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-11-4.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIFilter.h"

@interface OIMultiInputsFilter : OIFilter

@property (nonatomic) unsigned int inputCount;

- (id)initWithContentSize:(CGSize)contentSize inputCount:(unsigned int)inputCount;

@end
