//
//  MergeVideoTool.m
//  VUE
//
//  Created by admin on 17/3/10.
//  Copyright © 2017年 admin. All rights reserved.
//

#import "MergeVideoTool.h"
#import <AVFoundation/AVFoundation.h>

@implementation MergeVideoTool

+ (void)mergeVideoToOneVideo:(NSArray *)tArray musicName:(NSString *)musicName toStorePath:(NSString *)storePath WithStoreName:(NSString *)storeName success:(void (^)(NSURL *outputUrl))successBlock failure:(void (^)(void))failureBlcok;
{
    MergeVideoTool *tool = [[MergeVideoTool alloc] init];
    [tool mergeVideoToOneVideo:tArray musicName:musicName toStorePath:storePath WithStoreName:storeName success:successBlock failure:failureBlcok];
}

- (void)mergeVideoToOneVideo:(NSArray *)tArray musicName:(NSString *)musicName toStorePath:(NSString *)storePath WithStoreName:(NSString *)storeName success:(void (^)(NSURL *outputUrl))successBlock failure:(void (^)(void))failureBlcok;
{
    AVMutableComposition *mixComposition = [self mergeVideostoOnevideo:tArray musicName:musicName];
    NSURL *outputFileUrl = [self joinStorePaht:storePath togetherStoreName:storeName];
    
    [self storeAVMutableComposition:mixComposition withStoreUrl:outputFileUrl andVideoUrl:[tArray objectAtIndex:0] WihtName:storeName success:successBlock failure:failureBlcok];
}


//AVMutableComposition

- (AVMutableComposition *)mergeVideostoOnevideo:(NSArray*)array musicName:(NSString *)musicName
{
    AVMutableComposition* mixComposition = [AVMutableComposition composition];
    AVMutableCompositionTrack *a_compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    Float64 tmpDuration =0.0f;
    
    for (int i = 0; i<array.count; i++)
    {
        AVURLAsset *videoAsset = [[AVURLAsset alloc]initWithURL:array[i] options:nil];
        CMTimeRange video_timeRange = CMTimeRangeMake(kCMTimeZero,videoAsset.duration);
        
        /**
         *  依次加入每个asset
         *
         *  TimeRange 加入的asset持续时间
         *  Track     加入的asset类型,这里都是video
         *  Time      从哪个时间点加入asset,这里用了CMTime下面的CMTimeMakeWithSeconds(tmpDuration, 0),timesacle为0
         *
         */
        NSError *error;
        BOOL tbool = [a_compositionVideoTrack insertTimeRange:video_timeRange ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:CMTimeMakeWithSeconds(tmpDuration, 0) error:&error]; 
        if (tbool) {
        }
        tmpDuration += CMTimeGetSeconds(videoAsset.duration);
    }
    
    if (musicName && musicName.length) {
        NSURL *audioInputUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:musicName ofType:@"mp3"]];
        AVURLAsset *audioAsset = [[AVURLAsset alloc] initWithURL:audioInputUrl options:nil];
        CMTime cmDuration = CMTimeMake(tmpDuration, 1);
        CMTimeRange audioTimeRange = CMTimeRangeMake(kCMTimeZero, cmDuration);;
        AVMutableCompositionTrack *audioTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
        AVAssetTrack *audioAssetTrack2 = [[audioAsset tracksWithMediaType:AVMediaTypeAudio] firstObject];
        [audioTrack insertTimeRange:audioTimeRange ofTrack:audioAssetTrack2 atTime:kCMTimeZero error:nil];
    }
    return mixComposition;
}

/**
 *  拼接url地址
 *
 *  @param sPath 沙盒文件夹名
 *  @param sName 文件名称
 *
 *  @return 返回拼接好的url地址
 */
- (NSURL *)joinStorePaht:(NSString *)sPath togetherStoreName:(NSString *)sName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *storePath = [documentPath stringByAppendingPathComponent:sPath];
    BOOL isExist = [fileManager fileExistsAtPath:storePath];
    if(!isExist){
        [fileManager createDirectoryAtPath:storePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *realName = [NSString stringWithFormat:@"%@.mp4", sName];
    storePath = [storePath stringByAppendingPathComponent:realName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:storePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:storePath error:nil];
    }
    NSURL *outputFileUrl = [NSURL fileURLWithPath:storePath];
    return outputFileUrl;
}

//导出视频
- (void)storeAVMutableComposition:(AVMutableComposition*)mixComposition withStoreUrl:(NSURL *)storeUrl andVideoUrl:(NSURL *)videoUrl WihtName:(NSString *)aName success:(void (^)(NSURL *outputUrl))successBlock failure:(void (^)(void))failureBlcok
{
    AVAssetExportSession *assetExport = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetHighestQuality];
    assetExport.outputFileType = AVFileTypeQuickTimeMovie;
    assetExport.outputURL = storeUrl;
    [assetExport exportAsynchronouslyWithCompletionHandler:^{
        if (assetExport.status == 3) {
            successBlock(storeUrl);
        }
    }];
}
@end
