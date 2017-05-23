//
//  EditViewSelectMusicView.m
//  VUE
//
//  Created by admin on 17/3/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "EditViewSelectMusicView.h"
#import "MusicCell.h"

@interface EditViewSelectMusicView ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation EditViewSelectMusicView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initData];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat collectionViewHeight = 92;
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
    fl.itemSize = CGSizeMake(collectionViewHeight, collectionViewHeight);
    fl.minimumInteritemSpacing = 25;
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, width, collectionViewHeight) collectionViewLayout:fl];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[MusicCell class] forCellWithReuseIdentifier:@"musicItem"];
    [self addSubview:collectionView];
    _collectionView = collectionView;
}

- (void)initData
{
    _dataArray = @[@"其实", @"made you look", @"same team", @"lean on", @"五环之歌", @"team"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MusicCell *cell = (MusicCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"musicItem" forIndexPath:indexPath];
    cell.musicName = _dataArray[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didSelectedMusic" object:_dataArray[indexPath.row]];
}

@end
