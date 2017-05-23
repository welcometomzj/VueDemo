/* 
  BoxBlur.vsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-8-13.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

attribute vec4 position;
attribute vec2 textureCoordinate;

uniform float horizontalOffset;
uniform float verticalOffset;
uniform float blurSize;

varying vec2 textureCoordinatePort;
varying vec2 oneStepLeftTextureCoordinate;
varying vec2 twoStepsLeftTextureCoordinate;
varying vec2 oneStepRightTextureCoordinate;
varying vec2 twoStepsRightTextureCoordinate;

void main()
{
    vec2 firstOffset = vec2(1.5 * horizontalOffset, 1.5 * verticalOffset) * blurSize;
    vec2 secondOffset = vec2(3.5 * horizontalOffset, 3.5 * verticalOffset) * blurSize;
    
    oneStepLeftTextureCoordinate = textureCoordinate - firstOffset;
    twoStepsLeftTextureCoordinate = textureCoordinate - secondOffset;
    oneStepRightTextureCoordinate = textureCoordinate + firstOffset;
    twoStepsRightTextureCoordinate = textureCoordinate + secondOffset;
    
    textureCoordinatePort = textureCoordinate;
    
    gl_Position = position;
}