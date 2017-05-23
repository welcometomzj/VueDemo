//
//  OIProgram.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-3-3.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <OpenGLESImage/OIMaths.h>

@interface OIProgram : NSObject

- (id)initWithVertexShaderString:(NSString *)vShaderString fragmentShaderString:(NSString *)fShaderString;
- (id)initWithVertexShaderFilename:(NSString *)vShaderFilename fragmentShaderFilename:(NSString *)fShaderFilename;

- (void)use;
- (void)draw;
- (void)drawWithIndexCount:(GLsizei)count;

- (void)setCoordinatePointer:(const GLfloat *)pointer coordinateSize:(GLint)size forAttribute:(NSString *)attributeName;

- (void)setInt:(int)intValue forUniform:(NSString *)uniformName;
- (void)setIntArray:(int *)intArray withArrayCount:(int)count forUniform:(NSString *)uniformName;
- (void)setFloat:(float)floatValue forUniform:(NSString *)uniformName;
- (void)setTextureIndex:(int)index forTexture:(NSString *)textureName;
- (void)setFloatArray:(float *)floatArray withArrayCount:(int)count forUniform:(NSString *)uniformName;
- (void)set2DFloatVector:(OI2DFloatVector)vector forUniform:(NSString *)uniformName;
- (void)set4DFloatVectorArray:(OI4DFloatVector *)vectorArray withArrayCount:(int)count forUniform:(NSString *)uniformName;
- (void)set4x4Matrix:(float *)matrix forUniform:(NSString *)uniformName;

@end
