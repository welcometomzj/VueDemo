/* 
  UpsideDown.vsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-9-1.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

attribute vec4 position;
attribute vec2 textureCoordinate;

varying vec2 textureCoordinatePort;

void main()
{
    textureCoordinatePort = vec2(textureCoordinate.x, 1.0 - textureCoordinate.y);
    
    gl_Position = position;
}