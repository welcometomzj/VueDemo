/* 
  FastSurfaceBlur.vsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-5-28.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

const int kMaxOffsetCount = 5;

attribute vec4 position;
attribute vec2 textureCoordinate;

uniform int radius;
uniform int stepDistance;
uniform mediump vec2 offset;

varying vec2 textureCoordinatePort[kMaxOffsetCount];

void main()
{
    mediump float count = -float(radius);
    
    int j = 0;
    for (int i = -8; i <= 8; i += 4, j++) {
        textureCoordinatePort[j] = textureCoordinate + float(i) * offset;
    }
    for ( ; j < kMaxOffsetCount; j++) {
        textureCoordinatePort[j] = vec2(0.0);
    }
    
    gl_Position = position;
}