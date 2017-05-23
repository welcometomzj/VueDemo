/* 
  MultiImagesSplicing.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-11-5.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
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
    
    lowp vec4 outputColor = vec4(0.5);
    
    if (sourceColor0.a < 0.05) {
        outputColor = texture2D(sourceImage1, texture1CoordinatePort);
    }
    else if (sourceColor0.a < 0.15) {
        outputColor = texture2D(sourceImage2, texture2CoordinatePort);
    }
    else if (sourceColor0.a < 0.25) {
        outputColor = texture2D(sourceImage3, texture3CoordinatePort);;
    }
    else if (sourceColor0.a < 0.35) {
        outputColor = texture2D(sourceImage4, texture4CoordinatePort);;
    }
    else if (sourceColor0.a < 0.45) {
        outputColor = texture2D(sourceImage5, texture5CoordinatePort);
    }
    else if (sourceColor0.a < 0.55) {
        outputColor = texture2D(sourceImage6, texture6CoordinatePort);
    }
    else if (sourceColor0.a < 0.65) {
        outputColor = texture2D(sourceImage7, texture7CoordinatePort);
    }
    
    gl_FragColor = outputColor;
}