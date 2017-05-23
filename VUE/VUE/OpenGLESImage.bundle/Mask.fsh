/* 
  Mask.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-8-20.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

varying highp vec2 textureCoordinatePort;
varying highp vec4 positionPort;

uniform sampler2D sourceImage;
uniform lowp float maskAlpha;
uniform highp float maskBoundsX1;
uniform highp float maskBoundsX2;
uniform highp float maskBoundsY1;
uniform highp float maskBoundsY2;

void main()
{
    lowp vec4 sourceColor = texture2D(sourceImage, textureCoordinatePort);
    
    if (positionPort.x > maskBoundsX1 && positionPort.x < maskBoundsX2 && positionPort.y > maskBoundsY2 && positionPort.y < maskBoundsY1) {
        sourceColor.a = maskAlpha;
    }
    else {
        sourceColor.a = 0.0;
    }

    gl_FragColor = sourceColor;
}