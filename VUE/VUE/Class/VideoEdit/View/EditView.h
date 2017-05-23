//
//  EditView.h
//  VUE
//
//  Created by admin on 17/3/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditViewDelegate <NSObject>

- (void)rankVideoOrder:(NSArray *)orderArray;

@end

@interface EditView : UIView
@property (nonatomic, weak)UIView *preView;
@property (nonatomic, weak)UIView *playView;
@property (nonatomic, weak)UIView *bottomMenuView;
@property (nonatomic, weak)UIButton *backBtn;
@property (nonatomic, weak)UIButton *completeBtn;

@property (nonatomic, weak)id<EditViewDelegate> delegate;
@end
