/* 
  MultiImagesSplicing.vsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-11-5.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

attribute vec4 position;
attribute vec2 texture0Coordinate;
attribute vec2 texture1Coordinate;
attribute vec2 texture2Coordinate;
attribute vec2 texture3Coordinate;
attribute vec2 texture4Coordinate;
attribute vec2 texture5Coordinate;
attribute vec2 texture6Coordinate;
attribute vec2 texture7Coordinate;

varying vec2 texture0CoordinatePort;
varying vec2 texture1CoordinatePort;
varying vec2 texture2CoordinatePort;
varying vec2 texture3CoordinatePort;
varying vec2 texture4CoordinatePort;
varying vec2 texture5CoordinatePort;
varying vec2 texture6CoordinatePort;
varying vec2 texture7CoordinatePort;

void main()
{
    texture0CoordinatePort = texture0Coordinate;
    texture1CoordinatePort = texture1Coordinate;
    texture2CoordinatePort = texture2Coordinate;
    texture3CoordinatePort = texture3Coordinate;
    texture4CoordinatePort = texture4Coordinate;
    texture5CoordinatePort = texture5Coordinate;
    texture6CoordinatePort = texture6Coordinate;
    texture7CoordinatePort = texture7Coordinate;
    
    gl_Position = position;
}