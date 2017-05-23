//
//  OITwoPassesFilter.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 14-4-16.
//  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
//

#import "OIFilter.h"

@interface OITwoPassesFilter : OIFilter
{
    OIFrameBufferObject *secondFilterFBO_;
    OIProgram *secondFilterProgram_;
}

+ (NSString *)secondVertexShaderFilename;
+ (NSString *)secondFragmentShaderFilename;

- (void)setSecondProgramUniform;

@end
