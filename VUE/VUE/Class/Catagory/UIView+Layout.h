//
//  UIView+Layout.h
//  Facechat
//
//  Created by 许孝泳 on 16/10/30.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
  FCOscillatoryAnimationToBigger,
  FCOscillatoryAnimationToSmaller,
} FCOscillatoryAnimationType;

@interface UIView (Layout)

@property (nonatomic) CGFloat fc_left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat fc_top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat fc_right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat fc_bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat fc_width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat fc_height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat fc_centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat fc_centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint fc_origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  fc_size;        ///< Shortcut for frame.size.

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(FCOscillatoryAnimationType)type;

@end

