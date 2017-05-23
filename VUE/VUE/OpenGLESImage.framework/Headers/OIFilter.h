//
//  OIFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-3-15.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIProducer.h"
#import "OIConsumer.h"
#import "OIContext.h"
#import "OIFrameBufferObject.h"
#import "OIProgram.h"
#import "OITexture.h"

@interface OIFilter : OIProducer <OIConsumer>
{
    NSMutableArray *producers_;
    OIFrameBufferObject *filterFBO_;
    OIProgram *filterProgram_;
    OITexture *inputTexture_;
    CGSize contentSize_;
}

+ (NSString *)vertexShaderFilename;
+ (NSString *)fragmentShaderFilename;

- (id)initWithContentSize:(CGSize)contentSize;

- (void)setProgramUniform;

- (UIImage *)imageFromCurrentFrame;

@end
