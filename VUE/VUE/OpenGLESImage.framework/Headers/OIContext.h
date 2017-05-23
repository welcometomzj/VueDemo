//
//  OIContext.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-2-19.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import <Foundation/Foundation.h>


@class EAGLContext;
@class EAGLSharegroup;
@class OIFrameBufferObject;
@protocol EAGLDrawable;

/*!
 @class OIContext
 
 @abstract
 整个OpenGLESImage框架的运行环境。
 
 @discussion
 所有OpenGLESImage与OpenGLES有关的的基础类（包括OIFrameBufferObject、OIProgram和OITexture）都必需运行在在本类提供的图像处理队列中，并在调用以上类时先设置OIContext的单例为当前Context。本框架目前使用OpenGLES 2.0的运行环境。
 
 */
@interface OIContext : NSObject

/*!
 @method sharedContext
 @abstract 提供OIContext单例的类方法。
 @discussion 整个OpenGLESImage框架及其第三方扩展类都应只使用此单例，请勿自行初始化本类的其它实例。
 @result OIContext的单例。
 */
+ (OIContext *)sharedContext;

/*!
 @method performSynchronouslyOnImageProcessingQueue:
 @abstract 方便在OIContext提供的图像处理队列中执行代码的类方法。
 @param block 想在OIContext图像处理队列中同步执行的代码块。
 @discussion 本方法参数block中的代码会同步在OIContext的图像处理队列中执行。调用此方法时无需担心因当前就在OIContext的图像处理队列中而引发bug。此类方法会隐式调用本类单例的setAsCurrentContext方法。
 */
+ (void)performSynchronouslyOnImageProcessingQueue:(void (^)(void))block;

/*!
 @method performAsynchronouslyOnImageProcessingQueue:
 @abstract 方便在OIContext提供的图像处理队列中执行代码的类方法。
 @param block 想在OIContext图像处理队列中异步执行的代码块。
 @discussion 本方法参数block中的代码会异步在OIContext的图像处理队列中执行。调用此方法时无需担心因当前就在OIContext的图像处理队列中而引发bug。此类方法会隐式调用本类单例的setAsCurrentContext方法。
 */
+ (void)performAsynchronouslyOnImageProcessingQueue:(void (^)(void))block;


+ (void)noLongerBeNeed;

/*!
 @property imageProcessingQueue
 @abstract OpenGLES代码的运行队列。
 @discussion 为OpenGLESImage框架中所有的OpenGLES代码提供一个专门的队列，本框架中所有的OpenGLES代码以及包含OpenGLES代码的几个基础类（包括OIFrameBufferObject、OIProgram和OITexture）都必需运行在此队列中。performSynchronouslyOnImageProcessingQueue方法和performAsynchronouslyOnImageProcessingQueue均是使用此队列。
 @result 一个用于运行OpenGLES代码的dispatch_queue_t。
 */
@property (readonly, nonatomic) dispatch_queue_t imageProcessingQueue;

/*!
 @property sharegroup
 @abstract OpenGLES的共享组。
 @discussion 用于不同的OpenGLES运行环境之间共享OpenGL资源，详见EAGLSharegroup的官方文档。请在setAsCurrentContext首次被调用前设置好本属性，setAsCurrentContext被调用后任何设置均无效。
 @result 一个EAGLSharegroup对象。
 */
@property (readwrite, retain, nonatomic) EAGLSharegroup *sharegroup;

/*!
 @method setAsCurrentContext
 @abstract 用于设置本类实例为当前的OpenGLES运行环境。
 @discussion 本框架中所有的OpenGLES代码以及包含OpenGLES代码的几个基础类（包括OIFrameBufferObject、OIProgram和OITexture）在被调用前，均须首先调用OIContext单例的此方法以设置好运行环境。
 */
- (void)setAsCurrentContext;

/*!
 @method presentFrameBufferObject:
 @abstract 展示OIFrameBufferObject中内容到UIView上的方法。
 @param fbo 用于展示的OIFrameBufferObject实例。
 @discussion 传入的OIFrameBufferObject实例的type属性必需为OIFrameBufferObjectTypeForDisplay，否则此方法不起作用。
 */
- (void)presentFrameBufferObject:(OIFrameBufferObject *)fbo;

@end
