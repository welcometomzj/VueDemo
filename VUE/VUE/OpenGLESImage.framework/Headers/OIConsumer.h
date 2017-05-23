//
//  OIConsumer.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-3-15.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreMedia/CoreMedia.h>


enum OIConsumerContentMode_ {
    OIConsumerContentModeNormal,
    OIConsumerContentModeResizeToFill,     //The option to scale the content to fit the size of itself by changing the aspect ratio of the content if necessary.
    OIConsumerContentModeResizeAspect,     //The option to scale the content to fit the size of the view by maintaining the aspect ratio. Any remaining area of the view’s bounds is transparent.
    OIConsumerContentModeResizeAspectFill  //The option to scale the content to fill the size of the view. Some portion of the content may be clipped to fill the view’s bounds.
};
typedef enum OIConsumerContentMode_ OIConsumerContentMode;

@class UIImage;
@class OIProducer;
@class OITexture;

@protocol OIConsumer <NSObject>

@required

@property (readwrite, nonatomic, getter=isEnabled) BOOL enabled;
@property (readwrite, nonatomic) CGSize contentSize;
@property (readwrite, nonatomic) OIConsumerContentMode contentMode;
@property (readonly, nonatomic) NSArray *producers;

- (void)setProducer:(OIProducer *)producer;
- (void)removeProducer:(OIProducer *)producer;
- (void)setInputTexture:(OITexture *)inputTexture;
- (void)renderRect:(CGRect)rect atTime:(CMTime)time;

@optional
- (UIImage *)imageFromCurrentFrame;

@end
