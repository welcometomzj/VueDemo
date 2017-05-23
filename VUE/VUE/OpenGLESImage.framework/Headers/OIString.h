//
//  OIString.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-9-3.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIProducer.h"
#import <UIKit/UIKit.h>

@class UIColor;

@interface OIString : OIProducer

- (id)initWithNSString:(NSString *)string fontSize:(float)fontSize size:(CGSize)size;
- (id)initWithNSString:(NSString *)string fontName:(NSString *)fontName fontSize:(float)fontSize color:(UIColor *)color size:(CGSize)size;

@property (copy, readwrite, nonatomic) NSString *NSString;
@property (copy, readwrite, nonatomic) NSString *fontName;
@property (readwrite, nonatomic) float fontSize;
@property (nonatomic) NSTextAlignment textAlignment;   // default is NSTextAlignmentLeft
@property (retain, readwrite, nonatomic) UIColor *color;
@property (readwrite, nonatomic) float alpha;

@end
