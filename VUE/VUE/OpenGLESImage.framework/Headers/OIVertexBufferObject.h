//
//  OIVertexBufferObject.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 16/8/8.
//  Copyright © 2016年 Kwan Yiuleung. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 @enum OIVertexBufferObjectType
 @abstract OIVertexBufferObject的类型
 
 @constant OIVertexBufferObjectTypeVertices
 用于存放顶点数据的实例用此类型。
 @constant OIVertexBufferObjectTypeIndices
 用于存放索引数据的实例用此类型。
 */
typedef enum OIVertexBufferObjectType_ {
    OIVertexBufferObjectTypeVertices,
    OIVertexBufferObjectTypeIndices
} OIVertexBufferObjectType;

/*!
 @enum OIVertexBufferObjectUsage
 @abstract OIVertexBufferObject的用法
 
 @constant OIVertexBufferObjectUsageStatic
 数据使用周期内不会发生变化的OIVertexBufferObject。
 @constant OIVertexBufferObjectUsageDynamic
 数据使用周期内周期性发生变化的OIVertexBufferObject。
 @constant OIVertexBufferObjectUsageStream
 数据使用周期内会频繁变化的OIVertexBufferObject。
 */
typedef enum OIVertexBufferObjectUsage_ {
    OIVertexBufferObjectUsageStatic,
    OIVertexBufferObjectUsageDynamic,
    OIVertexBufferObjectUsageStream
} OIVertexBufferObjectUsage;

/*!
 @class OIVertexBufferObject
 
 @abstract 对OpenGLES中Vertex Buffer Object的封装。
 
 @discussion 为了方便使用，本类对VBO相关的OpenGLES函数进行了封装，定义了使用VBO时所需的一些常用方法，主要提供给OIProgram调用。
 
 */
@interface OIVertexBufferObject : NSObject

/*!
 @method initWithType:buffer:size:usage:
 @abstract 本类的初始化方法。
 @discussion 本类暂时不能用普通init函数初始化，实例化本类时请用此方法。
 @param type       VBO的类型，分为顶点和顶点索引两种，详见OIVertexBufferObjectType的注释。
 @param buffer     用于填充VBO的buffer，当此参数置NULL时，只为VBO分配内存，不填充数据。
 @param bufferSize 用于填充VBO的buffer的大小，单位为字节。当buffer参数置NULL时，会为VBO分配此参数大小的内存。
 @param usage      VBO的用法，分为静态、动态和流三种，详见OIVertexBufferObjectUsage注释。OpenGLES会为不同的用法做优化。
 @result 本类的一个实例。
 */
- (instancetype)initWithType:(OIVertexBufferObjectType)type buffer:(void *)buffer size:(long)bufferSize usage:(OIVertexBufferObjectUsage)usage;

/*!
 @method updateLocation:byBuffer:withSize:
 @abstract 用于更新VBO中的数据。
 @discussion 可使用此方法更新VBO中的数据，或为初始化时未指定buffer的VBO填充数据。对于需要更改数据的VBO，初始化时用法应设置为OIVertexBufferObjectUsageDynamic或OIVertexBufferObjectUsageStream。
 @param offset     一个偏移量，指明需要更新的VBO位置。
 @param buffer     用于更新VBO的buffer。
 @param bufferSize 用于更新VBO的buffer的大小，单位为字节。
 */
- (void)updateLocation:(int)offset byBuffer:(void *)buffer withSize:(long)bufferSize;

/*!
 @method bind
 @abstract 用于绑定VBO。
 @discussion 第三方调用OIVertexBufferObject的实例方法前需先绑定一次。
 */
- (void)bind;

/*!
 @method unbind
 @abstract 用于解绑OIVertexBufferObject。
 @discussion 第三方调用OIVertexBufferObject的实例方法后需解除绑定。
 */
- (void)unbind;

@end
