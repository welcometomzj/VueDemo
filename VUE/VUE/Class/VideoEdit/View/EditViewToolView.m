//
//  EditViewToolView.m
//  VUE
//
//  Created by admin on 17/3/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "EditViewToolView.h"
#import "EditViewSelectMusicView.h"
#import "EditViewRankVideoView.h"

#define selfWidth  CGRectGetWidth(self.bounds)
#define selfHeight CGRectGetHeight(self.bounds)
#define toolViewHeight selfHeight - 44

@interface EditViewToolView ()
@property (nonatomic, assign)EditViewToolViewType toolType;
@property (nonatomic, strong)EditViewSelectMusicView *selectMusicView;
@property (nonatomic, strong)EditViewRankVideoView *rankVideoView;
@end

@implementation EditViewToolView

- (void)dealloc
{
    
}

- (instancetype)initWithType:(EditViewToolViewType)toolViewType frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _toolType = toolViewType;
        self.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:1];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    CGFloat topViewHeight = 44;
    CGFloat titleLabelWidth = 100;
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selfWidth, topViewHeight)];
    [self addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((selfWidth - titleLabelWidth) / 2, 0, titleLabelWidth, topViewHeight)];
    [topView addSubview:titleLabel];
    titleLabel.text = [self getTitle];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    UIButton *comfirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    comfirmBtn.frame = CGRectMake(selfWidth - 60, 0, 60, topViewHeight);
    [comfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    comfirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [comfirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [comfirmBtn addTarget:self action:@selector(completeEdit) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:comfirmBtn];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topView.frame)-0.5, selfWidth, 0.5)];
    [topView addSubview:line];
    line.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    
    [self addToolView];
}

- (void)addToolView
{
    switch (_toolType) {
        case EditViewToolViewTypeDetail:
            
            break;
            
        case EditViewToolViewTypeShot:
            [self addSubview:self.rankVideoView];
            break;
            
        case EditViewToolViewTypeMusic:
            [self addSubview:self.selectMusicView];
            break;
            
        case EditViewToolViewTypeSticker:
            
            break;
            
        default:
            break;
    }

}

- (NSString *)getTitle
{
    NSString *title = nil;
    switch (_toolType) {
        case EditViewToolViewTypeDetail:
            title = @"画面调节";//
            break;
            
        case EditViewToolViewTypeShot:
            title = @"分段编辑";
            break;
            
        case EditViewToolViewTypeMusic:
            title = @"添加音乐";
            break;
            
        case EditViewToolViewTypeSticker:
            title = @"添加贴图";
            break;
            
        default:
            break;
    }
    return title;
}

- (void)completeEdit
{    
    NSArray *orderArray = nil;
    if (_toolType == EditViewToolViewTypeShot) {
        orderArray = [_rankVideoView getOrder];
    }
    if (_completeBlock) {
        _completeBlock(orderArray);
    }
}

#pragma mark - 懒加载

- (EditViewSelectMusicView *)selectMusicView
{
    if (!_selectMusicView) {
        _selectMusicView = [[EditViewSelectMusicView alloc] initWithFrame:CGRectMake(0, 44, selfWidth, toolViewHeight)];
        
    }
    return _selectMusicView;
}

- (EditViewRankVideoView *)rankVideoView
{
    if (!_rankVideoView) {
        _rankVideoView = [[EditViewRankVideoView alloc] initWithFrame:CGRectMake(0, 44, selfWidth, toolViewHeight)];
    }
    return _rankVideoView;
}

@end
