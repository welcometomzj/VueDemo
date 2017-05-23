/* 
  GaussianBlur.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-5-22.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

const int kMaxKernelCount = 11;

varying highp vec2 textureCoordinatePort[kMaxKernelCount];

uniform sampler2D sourceImage;
uniform mediump float kernels[kMaxKernelCount];
uniform int kernelCount;

void main(void)
{
    mediump vec3 color = vec3(0.0);
    
    for (int i = 0; i < kernelCount; i++) {
        color += kernels[i] * texture2D(sourceImage, textureCoordinatePort[i]).rgb;
    }
    
    gl_FragColor = vec4(color, 1.0);
}