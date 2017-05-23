//
//  UIView+Layout.m
//  Facechat
//
//  Created by 许孝泳 on 16/10/30.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

- (CGFloat)fc_left {
  return self.frame.origin.x;
}

- (void)setFc_left:(CGFloat)x {
  CGRect frame = self.frame;
  frame.origin.x = x;
  self.frame = frame;
}

- (CGFloat)fc_top {
  return self.frame.origin.y;
}

- (void)setFc_top:(CGFloat)y {
  CGRect frame = self.frame;
  frame.origin.y = y;
  self.frame = frame;
}

- (CGFloat)fc_right {
  return self.frame.origin.x + self.frame.size.width;
}

- (void)setFc_right:(CGFloat)right {
  CGRect frame = self.frame;
  frame.origin.x = right - frame.size.width;
  self.frame = frame;
}

- (CGFloat)fc_bottom {
  return self.frame.origin.y + self.frame.size.height;
}

- (void)setFc_bottom:(CGFloat)bottom {
  CGRect frame = self.frame;
  frame.origin.y = bottom - frame.size.height;
  self.frame = frame;
}

- (CGFloat)fc_width {
  return self.frame.size.width;
}

- (void)setFc_width:(CGFloat)width {
  CGRect frame = self.frame;
  frame.size.width = width;
  self.frame = frame;
}

- (CGFloat)fc_height {
  return self.frame.size.height;
}

- (void)setFc_height:(CGFloat)height {
  CGRect frame = self.frame;
  frame.size.height = height;
  self.frame = frame;
}

- (CGFloat)fc_centerX {
  return self.center.x;
}

- (void)setFc_centerX:(CGFloat)centerX {
  self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)fc_centerY {
  return self.center.y;
}

- (void)setFc_centerY:(CGFloat)centerY {
  self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)fc_origin {
  return self.frame.origin;
}

- (void)setFc_origin:(CGPoint)origin {
  CGRect frame = self.frame;
  frame.origin = origin;
  self.frame = frame;
}

- (CGSize)fc_size {
  return self.frame.size;
}

- (void)setFc_size:(CGSize)size {
  CGRect frame = self.frame;
  frame.size = size;
  self.frame = frame;
}

+ (void)showOscillatoryAnimationWithLayer:(CALayer *)layer type:(FCOscillatoryAnimationType)type{
  NSNumber *animationScale1 = type == FCOscillatoryAnimationToBigger ? @(1.15) : @(0.5);
  NSNumber *animationScale2 = type == FCOscillatoryAnimationToBigger ? @(0.92) : @(1.15);
  
  [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
    [layer setValue:animationScale1 forKeyPath:@"transform.scale"];
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.15 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
      [layer setValue:animationScale2 forKeyPath:@"transform.scale"];
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [layer setValue:@(1.0) forKeyPath:@"transform.scale"];
      } completion:nil];
    }];
  }];
}

@end
