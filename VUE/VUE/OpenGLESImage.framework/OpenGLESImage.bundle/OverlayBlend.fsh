/* 
  OverlayBlend.fsh
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
    
    if (secondSourceColor.r <= 0.5) {
        sourceColor.r = 2.0 * sourceColor.r * secondSourceColor.r;
    }
    else {
        sourceColor.r = 1.0 - 2.0 * (1.0 - sourceColor.r) * (1.0 - secondSourceColor.r);
    }
    
    if (secondSourceColor.g <= 0.5) {
        sourceColor.g = 2.0 * sourceColor.g * secondSourceColor.g;
    }
    else {
        sourceColor.g = 1.0 - 2.0 * (1.0 - sourceColor.g) * (1.0 - secondSourceColor.g);
    }
    
    if (secondSourceColor.b <= 0.5) {
        sourceColor.b = 2.0 * sourceColor.b * secondSourceColor.b;
    }
    else {
        sourceColor.b = 1.0 - 2.0 * (1.0 - sourceColor.b) * (1.0 - secondSourceColor.b);
    }
    
    sourceColor.rgb = clamp(sourceColor.rgb, 0.0, 1.0);
    
    gl_FragColor = sourceColor;
}