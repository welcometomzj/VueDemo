/* 
  FastSurfaceBlur.fsh
  OpenGLESImage

  Created by Kwan Yiuleung on 14-5-28.
  Copyright (c) 2014年 Kwan Yiuleung. All rights reserved.
*/

const int kMaxOffsetCount = 5;

varying highp vec2 textureCoordinatePort[kMaxOffsetCount];

uniform sampler2D sourceImage;

void main()
{
    mediump vec3 sourceColor = texture2D(sourceImage, textureCoordinatePort[2]).rgb;
    
    mediump vec3 offsetColor;
    mediump vec3 deltaColor;
    
    mediump vec3 totalWeight = vec3(0.0);
    mediump vec3 total = vec3(0.0);
    mediump vec3 weight;
    
    for(int i = 0; i < kMaxOffsetCount; i++)
    {
		if(i != 2)
		{
            offsetColor = texture2D(sourceImage, textureCoordinatePort[i]).rgb;
			deltaColor = abs(sourceColor - offsetColor);
			weight = vec3(1.0) - deltaColor / 0.14706;
			weight = clamp(weight, 0.01, 1.0);
			totalWeight += weight;
			total += offsetColor * weight;
		}
		else
		{
			totalWeight += vec3(1.0);
			total += sourceColor;
		}
        
    }
    
    sourceColor = total / totalWeight;
    sourceColor.rgb = clamp(sourceColor, 0.0, 1.0);
    
    gl_FragColor = vec4(sourceColor, 1.0);
}