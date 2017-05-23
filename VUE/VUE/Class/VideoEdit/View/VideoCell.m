//
//  VideoCell.m
//  VUE
//
//  Created by admin on 17/3/13.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "VideoCell.h"

@interface VideoCell ()
@property (nonatomic, weak) UILabel *titleLabel;
@end

@implementation VideoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.bounds = CGRectMake(0, 0, 50, 20);
    titleLabel.center = self.contentView.center;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
}

- (void)setSelected:(BOOL)selected
{
    if (selected) {
        self.layer.borderColor = [UIColor redColor].CGColor;
    }else{
        self.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}

- (void)setCellTitle:(NSString *)cellTitle
{
    _cellTitle = cellTitle;
    _titleLabel.text = cellTitle;
}

@end
