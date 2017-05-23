//
//  OIGIFWriter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 2017/2/20.
//  Copyright © 2017年 Kwan Yiuleung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <ImageIO/ImageIO.h>
#import "OIConsumer.h"

@interface OIGIFWriter : NSObject <OIConsumer>
{
    //图像目标
    CGImageDestinationRef destination_;
    NSDictionary *frameProperties_;
    OITexture *inputTexture_;
    BOOL enabled_;
    CMTime frameTime_;
    int recordedFrameCount_;
}

- (instancetype)initWithContentSize:(CGSize)contentSize outputURL:(NSURL *)outputURL;

@end
