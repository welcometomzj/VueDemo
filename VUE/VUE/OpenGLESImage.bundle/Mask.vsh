/* 
  Mask.vsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-8-20.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

attribute vec4 position;
attribute vec2 textureCoordinate;

varying vec2 textureCoordinatePort;
varying vec4 positionPort;

void main()
{
    textureCoordinatePort = textureCoordinate;
    
    positionPort = position;
    
    gl_Position = position;
}