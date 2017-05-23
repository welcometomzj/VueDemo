/* 
  BoxBlur.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-8-13.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

varying highp vec2 textureCoordinatePort;
varying highp vec2 oneStepLeftTextureCoordinate;
varying highp vec2 twoStepsLeftTextureCoordinate;
varying highp vec2 oneStepRightTextureCoordinate;
varying highp vec2 twoStepsRightTextureCoordinate;

uniform sampler2D sourceImage;

void main()
{
    lowp vec4 sourceColor = texture2D(sourceImage, textureCoordinatePort) * 0.2;
    sourceColor += texture2D(sourceImage, oneStepLeftTextureCoordinate) * 0.2;
    sourceColor += texture2D(sourceImage, oneStepRightTextureCoordinate) * 0.2;
    sourceColor += texture2D(sourceImage, twoStepsLeftTextureCoordinate) * 0.2;
    sourceColor += texture2D(sourceImage, twoStepsRightTextureCoordinate) * 0.2;
    
    gl_FragColor = sourceColor;
}