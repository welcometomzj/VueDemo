//
//  EditViewRankVideoView.m
//  VUE
//
//  Created by admin on 17/3/10.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "EditViewRankVideoView.h"
#import "UIButton+ImageTitleSpacing.h"
#import "VideoCell.h"

@interface EditViewRankVideoView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak)UIButton *moveNextBtn;
@property (nonatomic, weak)UIButton *movePrevBtn;
@property (nonatomic, weak)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation EditViewRankVideoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self initData];
    }
    return self;
}

- (void)initData
{
    _dataArray = [[NSMutableArray alloc] initWithArray:@[@"0", @"1", @"2"]];
    [_collectionView reloadData];
    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
    [_collectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self cheakBtnState];
}

- (void)setupUI
{
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat itemWidth = 72;
    CGFloat horizontalSpace = (width - itemWidth *3) / 4;
    
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
    fl.itemSize = CGSizeMake(itemWidth, 32);
    fl.minimumLineSpacing = horizontalSpace;
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 22, width, 32) collectionViewLayout:fl];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:@"rankVideo"];
    collectionView.contentInset = UIEdgeInsetsMake(0, horizontalSpace, 0, 0);
    collectionView.backgroundColor = [UIColor colorWithRed:16/255.0 green:16/255.0 blue:16/255.0 alpha:1];
    [self addSubview:collectionView];
    _collectionView = collectionView;
    
    UILabel *rankTitle = [[UILabel alloc] initWithFrame:CGRectMake(14, 129, 60, 22)];
    [self addSubview:rankTitle];
    rankTitle.text = @"排序";
    rankTitle.font = [UIFont systemFontOfSize:15];
    rankTitle.textColor = [UIColor colorWithWhite:1 alpha:0.6];
    
    CGFloat moveBtnWidth = 21;
    UIButton *moveNextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moveNextBtn setFrame:CGRectMake(width - moveBtnWidth - 20, CGRectGetMinY(rankTitle.frame), moveBtnWidth, 22)];
    [moveNextBtn setImage:[UIImage imageNamed:@"icon_edit_shotEdit_move_next"] forState:UIControlStateNormal];
    [moveNextBtn addTarget:self action:@selector(moveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:moveNextBtn];
    
    UIButton *movePrevBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [movePrevBtn setFrame:CGRectMake(CGRectGetMinX(moveNextBtn.frame) - 20 -moveBtnWidth, CGRectGetMinY(rankTitle.frame), moveBtnWidth, 22)];
    [movePrevBtn setImage:[UIImage imageNamed:@"icon_edit_shotEdit_move_prev"] forState:UIControlStateNormal];
    [movePrevBtn addTarget:self action:@selector(moveBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:movePrevBtn];
    
    self.moveNextBtn = moveNextBtn;
    self.movePrevBtn = movePrevBtn;
}

- (void)moveBtnAction:(UIButton *)sender
{
    NSIndexPath *indexPath = [[_collectionView indexPathsForSelectedItems] lastObject];
    NSUInteger selectIndex = indexPath.row;
    NSUInteger toIndex;
    if (sender == _movePrevBtn) {
        toIndex = selectIndex - 1;
    }else if (sender == _moveNextBtn){
        toIndex = selectIndex +1;
    }else{
        return;
    }
    [_dataArray exchangeObjectAtIndex:selectIndex withObjectAtIndex:toIndex];
    [_collectionView reloadData];
    NSIndexPath *path = [NSIndexPath indexPathForItem:toIndex inSection:0];
    [_collectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self cheakBtnState];

}

- (void)cheakBtnState
{
    NSIndexPath *indexPath = [[_collectionView indexPathsForSelectedItems] lastObject];
    [self checkBtnStateWithIndex:indexPath.row];
}

- (void)checkBtnStateWithIndex:(NSUInteger)index
{
    if (index == 0) {
        _movePrevBtn.enabled = NO;
        _moveNextBtn.enabled = YES;
    }else if (index == _dataArray.count - 1)
    {
        _moveNextBtn.enabled = NO;
        _movePrevBtn.enabled = YES;
    }else{
        _moveNextBtn.enabled = YES;
        _movePrevBtn.enabled = YES;
    }

}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoCell *cell = (VideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"rankVideo" forIndexPath:indexPath];
    NSString *title = _dataArray[indexPath.row];
    cell.cellTitle = title;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self checkBtnStateWithIndex:indexPath.row];
}

- (NSArray *)getOrder
{
    return _dataArray;
}

@end
