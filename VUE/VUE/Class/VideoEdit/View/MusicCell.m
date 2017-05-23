//
//  MusicCell.m
//  VUE
//
//  Created by admin on 17/3/10.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MusicCell.h"

@interface MusicCell ()
@property (nonatomic, weak)UILabel *nameLabel;
@end

@implementation MusicCell

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
    self.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    self.layer.borderWidth = 1;

    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 92, 40)];
    nameLabel.numberOfLines = 0;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:16];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
}

- (void)setMusicName:(NSString *)musicName
{
    self.nameLabel.text = musicName;
}


- (void)setSelected:(BOOL)selected
{
    if (selected) {
        self.layer.borderColor = [UIColor redColor].CGColor;
    }else{
        self.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    }
}

@end
