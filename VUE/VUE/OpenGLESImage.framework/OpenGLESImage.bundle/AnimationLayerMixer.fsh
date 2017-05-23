/*
 AnimationLayerMixer.fsh
 OpenGLESImage
 
 Created by Kwan Yiuleung on 15/8/11.
 Copyright (c) 2015年 Kwan Yiuleung. All rights reserved.
 */

const int MAX_LAYER_COUNT = 8;

varying highp vec2 texture0CoordinatePort;
varying highp vec2 texture1CoordinatePort;
varying highp vec2 texture2CoordinatePort;
varying highp vec2 texture3CoordinatePort;
varying highp vec2 texture4CoordinatePort;
varying highp vec2 texture5CoordinatePort;
varying highp vec2 texture6CoordinatePort;
varying highp vec2 texture7CoordinatePort;

uniform sampler2D sourceImages[MAX_LAYER_COUNT];

//uniform sampler2D sourceImage0;
//uniform sampler2D sourceImage1;
//uniform sampler2D sourceImage2;
//uniform sampler2D sourceImage3;
//uniform sampler2D sourceImage4;
//uniform sampler2D sourceImage5;
//uniform sampler2D sourceImage6;
//uniform sampler2D sourceImage7;

uniform int inputCount;

uniform int mixModes[MAX_LAYER_COUNT];
uniform lowp float alphas[MAX_LAYER_COUNT];
uniform lowp vec4 tones[MAX_LAYER_COUNT];

lowp vec4 normalBlend(lowp vec4 sourceColor, lowp vec4 destColor)
{
    lowp vec4 result;
    result.rgb = mix(sourceColor.rgb, destColor.rgb, destColor.a);
    result.a = max(sourceColor.a, destColor.a);
    return result;
}

lowp vec4 screenBlend(lowp vec4 sourceColor, lowp vec4 destColor)
{
    lowp vec4 whiteColor = vec4(1.0);
    
    return whiteColor - ((whiteColor - sourceColor) * (whiteColor - destColor));
}

lowp vec4 alphaPreMultipliedBlend(lowp vec4 sourceColor, lowp vec4 destColor)
{
    lowp vec4 result;
    
    result.rgb = destColor.rgb + sourceColor.rgb * (1.0 - destColor.a);
    
    result.rgb = clamp(result.rgb, 0.0, 1.0);
    
    result.a = max(sourceColor.a, destColor.a);
    
    return result;
}

void main()
{
    highp vec2 coordinates[MAX_LAYER_COUNT];
    
    coordinates[0] = texture0CoordinatePort;
    coordinates[1] = texture1CoordinatePort;
    coordinates[2] = texture2CoordinatePort;
    coordinates[3] = texture3CoordinatePort;
    coordinates[4] = texture4CoordinatePort;
    coordinates[5] = texture5CoordinatePort;
    coordinates[6] = texture6CoordinatePort;
    coordinates[7] = texture7CoordinatePort;
    
    lowp vec4 outputColor = texture2D(sourceImages[0], texture0CoordinatePort);
    
    if (tones[0].a >= 0.0) {
        outputColor.rgb = mix(outputColor.rgb, tones[0].rgb, tones[0].a);
        
        outputColor.rgb = clamp(outputColor.rgb, 0.0, 1.0);
    }
    
    for (int i = 1; i < inputCount; ++i) {
        lowp vec4 destColor = texture2D(sourceImages[i], coordinates[i]);
        
        if (alphas[i] >= 0.0) {
            destColor.a = alphas[i];
        }
        
        if (tones[i].a >= 0.0) {
            destColor.rgb = mix(destColor.rgb, tones[i].rgb, tones[i].a);
            
            destColor.rgb = clamp(destColor.rgb, 0.0, 1.0);
        }
        
        if (mixModes[i] == 0) {
            outputColor = normalBlend(outputColor, destColor);
        }
        else if (mixModes[i] == 1) {
            
        }
        else if (mixModes[i] == 3) {
            outputColor = screenBlend(outputColor, destColor);
        }
        else if (mixModes[i] == 4) {
            outputColor = alphaPreMultipliedBlend(outputColor, destColor);
        }
    }
    
    gl_FragColor = outputColor;
}