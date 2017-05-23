/* 
  MultiplyBlend.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-12-19.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

varying highp vec2 textureCoordinatePort;
varying highp vec2 secondTextureCoordinatePort;

uniform sampler2D sourceImage;
uniform sampler2D secondSourceImage;

void main()
{
    lowp vec4 sourceColor = texture2D(sourceImage, textureCoordinatePort);
    lowp vec4 secondSourceColor = texture2D(secondSourceImage, secondTextureCoordinatePort);
    
    gl_FragColor = sourceColor * secondSourceColor;
}