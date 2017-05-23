/* 
  Rotation.vsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-7-21.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

attribute vec4 position;
attribute vec2 textureCoordinate;

varying vec2 textureCoordinatePort;

uniform mat4 rotationMatrix;
uniform vec2 anchorPoint;
uniform float whRate;

void main()
{
    vec4 rotatedPosition = position;
    rotatedPosition.x = rotatedPosition.x - anchorPoint.x;
    rotatedPosition.y = rotatedPosition.y / whRate - anchorPoint.y;
    
    rotatedPosition = rotationMatrix * rotatedPosition;
    
    rotatedPosition.x = rotatedPosition.x + anchorPoint.x;
    rotatedPosition.y = rotatedPosition.y * whRate + anchorPoint.y;
    
    gl_Position = rotatedPosition;
    
    textureCoordinatePort = textureCoordinate;
}
