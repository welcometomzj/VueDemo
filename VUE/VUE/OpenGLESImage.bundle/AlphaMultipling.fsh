/* 
  AlphaMultipling.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-11-6.
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
    
    sourceColor.rgb = sourceColor.rgb / sourceColor.a;
    
    sourceColor.a = sourceColor.a * secondSourceColor.a;
    
    gl_FragColor = sourceColor;
}