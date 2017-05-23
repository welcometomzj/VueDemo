/* 
  GaussianBlur.vsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-5-22.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

const int kMaxKernelCount = 11;

attribute vec4 position;
attribute vec2 textureCoordinate;

uniform float hOffsets[kMaxKernelCount];
uniform float vOffsets[kMaxKernelCount];

varying vec2 textureCoordinatePort[kMaxKernelCount];

void main()
{
    vec2 offset = vec2(0.0);
    for (int i = 0; i < kMaxKernelCount; i++) {
        offset = vec2(hOffsets[i], vOffsets[i]);
        textureCoordinatePort[i] = textureCoordinate + offset;
    }
    
    gl_Position = position;
}