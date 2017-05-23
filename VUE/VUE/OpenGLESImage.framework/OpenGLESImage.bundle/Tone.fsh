/* 
  Tone.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-10-27.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

varying highp vec2 textureCoordinatePort;

uniform sampler2D sourceImage;
uniform lowp float red;
uniform lowp float green;
uniform lowp float blue;
uniform lowp float percentage;

void main()
{
    lowp vec4 sourceColor = texture2D(sourceImage, textureCoordinatePort);
    lowp vec3 toneColor = vec3(red, green, blue);
    
    sourceColor.rgb = mix(sourceColor.rgb, toneColor, percentage);
    
    sourceColor.rgb = clamp(sourceColor.rgb, 0.0, 1.0);
    
    gl_FragColor = sourceColor;
}