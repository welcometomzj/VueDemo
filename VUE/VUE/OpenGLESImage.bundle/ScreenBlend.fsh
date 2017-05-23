/* 
  ScreenBlend.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-10-23.
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
    
    lowp vec4 whiteColor = vec4(1.0);
    
    gl_FragColor = whiteColor - ((whiteColor - sourceColor) * (whiteColor - secondSourceColor));
}