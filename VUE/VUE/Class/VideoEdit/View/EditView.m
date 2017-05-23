//
//  EditView.m
//  VUE
//
//  Created by admin on 17/3/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "EditView.h"
#import "EditViewToolView.h"
#import "UIView+Layout.h"

#define menuColor [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:1]
#define menuHeight 55
#define preViewHeight 432
#define screenWidth CGRectGetWidth(self.bounds)
#define screenHeight CGRectGetHeight(self.bounds)

@interface EditView ()
@property (nonatomic, weak)EditViewToolView *toolView;
@end

@implementation EditView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bounds = [UIScreen mainScreen].bounds;
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    NSArray *images = @[@"icon_edit_detailedParam", @"icon_edit_shotEdit", @"icon_edit_music", @"icon_edit_sticker"];
    CGFloat btnWidth = 21;
    CGFloat btnHeight = 20;
    CGFloat playViewWidth = 212;
    CGFloat spaceWidth = (screenWidth - btnWidth * images.count) / (images.count + 1);
    
    UIView *preView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, preViewHeight)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizerAtion)];
    [preView addGestureRecognizer:tap];
    [self addSubview:preView];
    
    UIView *menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, menuHeight)];
    [preView addSubview:menuView];
    menuView.backgroundColor = menuColor;
    
    for (int i = 0; i < images.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [menuView addSubview:btn];
        btn.frame = CGRectMake((spaceWidth + btnWidth) * i + spaceWidth, (menuHeight - btnWidth) / 2, btnWidth, btnHeight);
        btn.tag = 100+i;
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *playView = [[UIView alloc] initWithFrame:CGRectMake((screenWidth - playViewWidth) / 2, CGRectGetMaxY(menuView.frame), playViewWidth, preViewHeight - menuHeight)];
    playView.backgroundColor = [UIColor grayColor];
    [preView addSubview:playView];
    
    CGFloat bottomMenuHeight = screenHeight - preViewHeight;
    UIView *bottomMenuView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(preView.frame), screenWidth, bottomMenuHeight)];
    bottomMenuView.backgroundColor = menuColor;
    [self addSubview:bottomMenuView];
    
    
    CGFloat backBtnHeight = 42;
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomMenuView
     addSubview:backBtn];
    backBtn.layer.cornerRadius = backBtnHeight / 2;
    backBtn.backgroundColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1];
    [backBtn setImage:[UIImage imageNamed:@"icon_edit_back"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(50, (bottomMenuHeight - backBtnHeight) / 2, backBtnHeight, backBtnHeight);
    
    CGFloat completeBtnHeight = 80;
    UIButton *completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [completeBtn setImage:[UIImage imageNamed:@"icon_edit_confirm"] forState:UIControlStateNormal];
    [bottomMenuView addSubview:completeBtn];
    completeBtn.frame = CGRectMake((screenWidth - completeBtnHeight) / 2, (bottomMenuHeight - completeBtnHeight) / 2, completeBtnHeight, completeBtnHeight);
    
    
    self.preView = preView;
    self.playView = playView;
    self.bottomMenuView = bottomMenuView;
    self.backBtn = backBtn;
    self.completeBtn = completeBtn;
}

- (void)btnAction:(UIButton *)sender
{
    NSUInteger btnTag = sender.tag - 100;
    CGFloat toolViewMinY = preViewHeight - menuHeight;
    CGFloat toolViewHeight = screenHeight - toolViewMinY;
    EditViewToolView *toolView = [[EditViewToolView alloc] initWithType:btnTag frame:CGRectMake(0, screenHeight, screenWidth, toolViewHeight)];
    [self addSubview:toolView];
    self.toolView = toolView;
    __weak typeof(self) weakSelf = self;
    toolView.completeBlock = ^(NSArray *orderArray){
        [weakSelf hideToolView];
        if (orderArray == nil) {
            return;
        }
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(rankVideoOrder:)]) {
            [weakSelf.delegate rankVideoOrder:orderArray];
        }
    };
    
    [UIView animateWithDuration:0.3 animations:^{
        self.preView.fc_top = -menuHeight;
        self.bottomMenuView.alpha = 0;
        toolView.fc_top = toolViewMinY;
    }];
}

- (void)tapGestureRecognizerAtion
{
    if (self.preView.frame.origin.y == 0) {
        return;
    }
    [self hideToolView];
}

- (void)hideToolView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.preView.frame = CGRectMake(0, 0, screenWidth, preViewHeight);
        self.bottomMenuView.alpha = 1;
        self.toolView.fc_top = screenHeight;
    } completion:^(BOOL finished) {
        [self.toolView removeFromSuperview];
        self.toolView = nil;
    }];
}

@end
