//
//  OIView.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-3-26.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OIConsumer.h"


@class OIFrameBufferObject;
@class OITexture;
@class OIProgram;

@interface OIView : UIView <OIConsumer>
{
    BOOL enabled_;
    OIFrameBufferObject *displayFBO_;
    OITexture *inputTexture_;
    OIProgram *displayProgram_;
    CGSize contentSize_;
    OIConsumerContentMode contentMode_;
    NSMutableArray *producers_;
}

@end
