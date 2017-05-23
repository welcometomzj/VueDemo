/* 
  Blend.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-7-25.
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
    
    if (opacity < 0.0 || opacity > 1.0) {
        sourceColor.rgb = mix(sourceColor.rgb, secondSourceColor.rgb, (1.0 - sourceColor.a));
    }
    else {
        sourceColor.rgb = mix(sourceColor.rgb, secondSourceColor.rgb, opacity);
    }
    
    sourceColor.a = max(sourceColor.a, secondSourceColor.a);
    
    gl_FragColor = sourceColor;
}