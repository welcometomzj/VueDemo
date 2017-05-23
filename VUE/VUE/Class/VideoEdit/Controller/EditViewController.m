//
//  EditViewController.m
//  VUE
//
//  Created by admin on 17/3/6.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "EditViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MergeVideoTool.h"

@interface EditViewController ()
@property (nonatomic, weak)AVPlayer *avPlayer;
@property (nonatomic, copy)NSString *musicName;
@end

@implementation EditViewController
@dynamic view;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repeatPlay) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didSelectedMusic:) name:@"didSelectedMusic" object:nil];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view.completeBtn addTarget:self action:@selector(saveVideoToAlbum) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loadView
{
    EditView *editView = [EditView new];
    editView.delegate = self;
    self.view = editView;
}

- (EditView *)view
{
    return (EditView *)super.view;
}


- (void)backAction
{
    [self.avPlayer pause];
    [self.navigationController popViewControllerAnimated:YES];
}

//保存视频到本地相册
- (void)saveVideoToAlbum
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *storePath = [documentPath stringByAppendingPathComponent:@"MergeVideos/mergeVideo.mp4"];
    UISaveVideoAtPathToSavedPhotosAlbum(storePath, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
}

//保存视频到相册回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != nil) {
        return;
    }
    UIAlertController *alrtVc = [UIAlertController alertControllerWithTitle:nil message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alrtVc addAction:cancelAction];
    [self presentViewController:alrtVc animated:YES completion:nil];
}

- (void)setPaths:(NSArray *)paths
{
    _paths = paths;
    if (!paths.count) {
        return;
    }
    else if (paths.count == 1){
        [self playWithUrl:paths[0]];
    }
    else{
        //合成
        __weak typeof(self) weakSelf = self;
        [MergeVideoTool mergeVideoToOneVideo:paths musicName:nil toStorePath:@"MergeVideos" WithStoreName:@"mergeVideo" success:^(NSURL *outputUrl) {
            //回到主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf playWithUrl:outputUrl];
            });
        } failure:nil];
    }
}

- (void)setDidExitVideo:(BOOL)didExitVideo
{
    if (!didExitVideo) {
        return;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *storePath = [documentPath stringByAppendingPathComponent:@"MergeVideos/mergeVideo.mp4"];
    NSURL *url = [NSURL fileURLWithPath:storePath];
    [self playWithUrl:url];
}

- (void)didSelectedMusic:(NSNotification *)notification
{
    //合成音乐
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *storePath = [documentPath stringByAppendingPathComponent:@"MergeVideos/mergeVideo.mp4"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:storePath]) {
        return;
    }
    _musicName = notification.object;
    [self mergeVideoWithMusic:_musicName videoUrls:@[[NSURL fileURLWithPath:storePath]]];
}

/** 播放方法 */
- (void)playWithUrl:(NSURL *)url{
    // 传入地址
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    // 播放器
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    // 播放器layer
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.frame = self.view.playView.bounds;
    // 视频填充模式
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    // 添加到imageview的layer上
    [self.view.playView.layer addSublayer:playerLayer];
    [player play];
    self.avPlayer = player;
}

- (void)repeatPlay {
    [self.avPlayer seekToTime:CMTimeMake(0, 1)];
    [self.avPlayer play];
}

#pragma mark - 

- (void)rankVideoOrder:(NSArray *)orderArray
{
    NSMutableArray *mArray = [NSMutableArray new];
    for (NSString *indexStr in orderArray) {
        NSInteger index = [indexStr integerValue];
        [mArray addObject:[_paths objectAtIndex:index]];
    }
    [self mergeVideoWithMusic:_musicName videoUrls:mArray];
}

- (void)mergeVideoWithMusic:(NSString *)musicName videoUrls:(NSArray *)urls
{
    __weak typeof(self) weakSelf = self;
    [MergeVideoTool mergeVideoToOneVideo:urls musicName:musicName toStorePath:@"MergeVideos" WithStoreName:@"mergeVideo" success:^(NSURL *outputUrl) {
        //回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:outputUrl];
            [weakSelf.avPlayer replaceCurrentItemWithPlayerItem:playerItem];
        });
    } failure:nil];
}

@end
