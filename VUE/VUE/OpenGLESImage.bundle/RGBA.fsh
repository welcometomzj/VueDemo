/* 
  RGBA.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-8-21.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

varying highp vec2 textureCoordinatePort;

uniform sampler2D sourceImage;
uniform lowp float redFactor;
uniform lowp float greenFactor;
uniform lowp float blueFactor;
uniform lowp float alphaFactor;

void main()
{
    lowp vec4 sourceColor = texture2D(sourceImage, textureCoordinatePort);
    
    sourceColor = vec4(sourceColor.r * redFactor, sourceColor.g * greenFactor, sourceColor.b * blueFactor, sourceColor.a * alphaFactor);
    
    sourceColor = clamp(sourceColor, 0.0, 1.0);
    
    gl_FragColor = sourceColor;
}