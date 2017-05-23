//
//  CameraView.m
//  VUE
//
//  Created by admin on 17/2/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "CameraView.h"
#import <OpenGLESImage/OpenGLESImage.h>
#import "UIButton+ImageTitleSpacing.h"

@implementation CameraView

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
    CGFloat  screenWidth = self.bounds.size.width;
    CGRect displayBounds = CGRectMake(0, 0, screenWidth, self.bounds.size.height);
    _previewView = [[OIView alloc] initWithFrame:displayBounds];
    _previewView.backgroundColor = [UIColor blackColor];
    [self addSubview:_previewView];
    
    //毛玻璃
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    effectView.frame = displayBounds;
    [self addSubview:effectView];
    effectView.hidden = YES;
    UILabel *titleLabel = [[UILabel alloc] init];//227
    titleLabel.text = @"拍摄完成";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.frame = CGRectMake((screenWidth - 100) / 2, 227, 100, 20);
    [effectView addSubview:titleLabel];
    
    UIButton *captureDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    captureDeleteBtn.frame = CGRectMake((screenWidth - 108) / 2, CGRectGetMaxY(titleLabel.frame)+22, 108, 18);
    [captureDeleteBtn setTitle:@"删除上一分段" forState:UIControlStateNormal];
    captureDeleteBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [captureDeleteBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [captureDeleteBtn setImage:[UIImage imageNamed:@"icon_capture_complete_delete"] forState:UIControlStateNormal];
    [captureDeleteBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:9];
    [effectView addSubview:captureDeleteBtn];
    
    UIButton *captureNextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    captureNextBtn.frame = CGRectMake((screenWidth - 95) / 2, CGRectGetMaxY(captureDeleteBtn.frame) + 10, 95, 18);
    [captureNextBtn setTitle:@"前往下一步" forState:UIControlStateNormal];
    [captureNextBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    captureNextBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [captureNextBtn setImage:[UIImage imageNamed:@"icon_capture_complete_next"] forState:UIControlStateNormal];
    [captureNextBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:9];
    [effectView addSubview:captureNextBtn];
    
    
    UIView *baseView = [[UIView alloc] initWithFrame:displayBounds];
    [self addSubview:baseView];
    
    //更多按钮
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseView addSubview:moreBtn];
    moreBtn.frame = CGRectMake(22, 15, 23, 22);
    [moreBtn setImage:[UIImage imageNamed:@"icon_nav_more"] forState:UIControlStateNormal];
    
    //切换镜头按钮
    UIButton *changeCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseView addSubview:changeCameraBtn];
    changeCameraBtn.frame = CGRectMake(self.bounds.size.width - 44, 15, 24, 24);
    [changeCameraBtn setImage:[UIImage imageNamed:@"icon_nav_switch_camera"] forState:UIControlStateNormal];
    
    //切换滤镜按钮
    UIButton *changeFilterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseView addSubview:changeFilterBtn];
    changeFilterBtn.frame = CGRectMake((self.bounds.size.width - 44) / 2, 5, 44, 44);
    [changeFilterBtn setImage:[UIImage imageNamed:@"icon_nav_filter"] forState:UIControlStateNormal];
    
    
    //进入相册视频按钮
    UIButton *pickVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseView addSubview:pickVideoBtn];
    pickVideoBtn.frame = CGRectMake(33, self.bounds.size.height - 64 - 28, 28, 28);
    [pickVideoBtn setImage:[UIImage imageNamed:@"icon_shoot_pick"] forState:UIControlStateNormal];
    
    //删除按钮
    UIButton *deleteVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseView addSubview:deleteVideoBtn];
    deleteVideoBtn.frame = CGRectMake(self.bounds.size.width - 40 - 28, self.bounds.size.height - 66.5 - 23, 28, 23);
    deleteVideoBtn.hidden = YES;
    [deleteVideoBtn setImage:[UIImage imageNamed:@"icon_shoot_delete_shot"] forState:UIControlStateNormal];
    
    //录制按钮
    UIButton *recordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [baseView addSubview:recordBtn];
    recordBtn.frame = CGRectMake((self.bounds.size.width - 70) / 2, self.bounds.size.height - 43 - 70, 70, 70);
    [recordBtn setImage:[UIImage imageNamed:@"icon_functionGuide_record"] forState:UIControlStateNormal];

    //录制按钮（下一步）
    UIImageView *recordNextImage = [[UIImageView alloc] initWithFrame:recordBtn.frame];
    recordNextImage.image = [UIImage imageNamed:@"icon_shoot_record_next"];
    recordNextImage.hidden = YES;
    [baseView addSubview:recordNextImage];
    
    //进度条
    UIView *progressBar = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(recordBtn.frame) - 22, 0, 4)];
    progressBar.backgroundColor = [UIColor redColor];
    [baseView addSubview:progressBar];
    
    //圆形进度条
    self.progressLayer = [CAShapeLayer layer];
    self.progressLayer.lineWidth = 3.0f;
    self.progressLayer.fillColor = nil;
    self.progressLayer.strokeColor = [UIColor whiteColor].CGColor;
    self.progressLayer.lineCap = kCALineCapRound;
    
    //倒计时
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.bounds = CGRectMake(0, 0, 70, 20);
    timeLabel.hidden = YES;
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.center = recordBtn.center;
    [self addSubview:timeLabel];
    
    self.moreBtn = moreBtn;
    self.changeCameraBtn = changeCameraBtn;
    self.changeFilterBtn = changeFilterBtn;
    self.pickVideoBtn = pickVideoBtn;
    self.deleteVideoBtn = deleteVideoBtn;
    self.recordBtn = recordBtn;
    self.progressBar = progressBar;
    self.baseView = baseView;
    self.timeLabel = timeLabel;
    self.effectView = effectView;
    self.recordNextImage = recordNextImage;
}


- (void)setProgress:(NSUInteger)progress
{
    CGFloat width = CGRectGetWidth(self.bounds) * progress / 3;
    CGRect frame = self.progressBar.frame;
    self.progressBar.frame = CGRectMake(0, frame.origin.y, width, frame.size.height);
}



@end
