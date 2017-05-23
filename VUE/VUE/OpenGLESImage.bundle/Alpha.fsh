/* 
  Alpha.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-8-1.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

varying highp vec2 textureCoordinatePort;

uniform sampler2D sourceImage;
uniform lowp float alpha;

void main()
{
    gl_FragColor = vec4(texture2D(sourceImage, textureCoordinatePort).rgb, alpha);
}