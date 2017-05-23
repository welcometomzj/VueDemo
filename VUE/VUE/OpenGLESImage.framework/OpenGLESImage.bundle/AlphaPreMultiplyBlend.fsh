/* 
  NonPreMultiplyBlend.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-10-28.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

varying highp vec2 textureCoordinatePort;
varying highp vec2 secondTextureCoordinatePort;

uniform sampler2D sourceImage;
uniform sampler2D secondSourceImage;
uniform lowp float opacity;

void main()
{
    lowp vec4 sourceColor = texture2D(sourceImage, textureCoordinatePort);
    lowp vec4 secondSourceColor = texture2D(secondSourceImage, secondTextureCoordinatePort);
    
    sourceColor.rgb = sourceColor.rgb + secondSourceColor.rgb * (1.0 - sourceColor.a);
    
    sourceColor.rgb = clamp(sourceColor.rgb, 0.0, 1.0);
    
    sourceColor.a = max(sourceColor.a, secondSourceColor.a);
    
    gl_FragColor = sourceColor;
}