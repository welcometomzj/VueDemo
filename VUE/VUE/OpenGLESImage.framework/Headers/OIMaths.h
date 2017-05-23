//
//  OIMaths.h
//  OpenGLESImage
//
//  Created by Kwan Yiuleung on 15/8/18.
//  Copyright (c) 2015年 Kwan Yiuleung. All rights reserved.
//

#ifndef OpenGLESImage_OIMaths_h
#define OpenGLESImage_OIMaths_h

#define OI_PI     3.14159265358979323846264338327950288419716939937510L
#define OI_2PI    6.28318530717958647692528676655900576839433879875020L
#define OI_PI_2    1.57079632679489661923132169163975144209858469968755L
#define OI_SQRT_1_2  0.70710678118654752440084436210484903928483593768847L
#define OI_SQRT_2    1.41421356237309504880168872420969807856967187537695L
#define OI_SQRT_2PI  2.50662827463100024161235523934010416269302368164062L

typedef struct OI2DFloatVector_ {
    float x;
    float y;
} OI2DFloatVector;

typedef struct OI3DFloatVector_ {
    float x;
    float y;
    float z;
} OI3DFloatVector;

typedef struct OI4DFloatVector_ {
    float x;
    float y;
    float z;
    float w;
} OI4DFloatVector;

typedef struct OIColor_ {
    float red;
    float green;
    float blue;
    float alpha;
} OIColor;

static inline double OIClamp(double x, double min, double max)
{
    return (x < min ? min : (x > max ? max : x));
}

static inline float OIClampf(float x, float min, float max)
{
    return (x < min ? min : (x > max ? max : x));
}

static inline int OIClampi(int x, int min, int max)
{
    return (x < min ? min : (x > max ? max : x));
}

#endif
