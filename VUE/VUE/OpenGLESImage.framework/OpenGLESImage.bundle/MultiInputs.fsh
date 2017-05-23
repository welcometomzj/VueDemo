/* 
  MultiInputs.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 15/8/11.
  Copyright (c) 2015年 Kwan Yiuleung. All rights reserved.
*/

varying highp vec2 texture0CoordinatePort;
varying highp vec2 texture1CoordinatePort;
varying highp vec2 texture2CoordinatePort;
varying highp vec2 texture3CoordinatePort;
varying highp vec2 texture4CoordinatePort;
varying highp vec2 texture5CoordinatePort;
varying highp vec2 texture6CoordinatePort;
varying highp vec2 texture7CoordinatePort;

uniform sampler2D sourceImage0;
uniform sampler2D sourceImage1;
uniform sampler2D sourceImage2;
uniform sampler2D sourceImage3;
uniform sampler2D sourceImage4;
uniform sampler2D sourceImage5;
uniform sampler2D sourceImage6;
uniform sampler2D sourceImage7;

uniform int inputCount;

void main()
{
    lowp vec4 sourceColor0 = texture2D(sourceImage0, texture0CoordinatePort);
    lowp vec4 sourceColor1 = texture2D(sourceImage1, texture1CoordinatePort);
    lowp vec4 sourceColor2 = texture2D(sourceImage2, texture2CoordinatePort);
    lowp vec4 sourceColor3 = texture2D(sourceImage3, texture3CoordinatePort);
    lowp vec4 sourceColor4 = texture2D(sourceImage4, texture4CoordinatePort);
    lowp vec4 sourceColor5 = texture2D(sourceImage5, texture5CoordinatePort);
    lowp vec4 sourceColor6 = texture2D(sourceImage6, texture6CoordinatePort);
    lowp vec4 sourceColor7 = texture2D(sourceImage7, texture7CoordinatePort);
    
    lowp vec4 outputColor = (sourceColor0 + sourceColor1 + sourceColor2 + sourceColor3 + sourceColor4 + sourceColor5 + sourceColor6 + sourceColor7) / 8.0;
    
    gl_FragColor = outputColor;
}