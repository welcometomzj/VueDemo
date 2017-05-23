//
//  EditViewController.h
//  VUE
//
//  Created by admin on 17/3/6.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditView.h"

@interface EditViewController : UIViewController<EditViewDelegate>

NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, strong) NSArray *paths;
@property (nonatomic, assign) BOOL didExitVideo;
NS_ASSUME_NONNULL_END

@property (null_resettable, nonatomic, strong) EditView *view;
@end
