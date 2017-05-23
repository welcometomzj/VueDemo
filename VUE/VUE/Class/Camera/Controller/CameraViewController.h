//
//  CameraViewController.h
//  VUE
//
//  Created by admin on 17/2/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraView.h"
#import "FCHCamera.h"

@interface CameraViewController : UIViewController<FCHCameraDelegate, OIAudioVideoWriterDelegate>
{
    FCHCamera *camera_; //镜头模块
    BOOL videoRecording_; //记录当前是否在拍摄视频期间的标志。
    OIAudioVideoWriter *videoWriter_; //将视频流写入磁盘的工具
    OIFilter *writerAdaptor_; //将镜头画面分辨率转换成目标视频文件分辨率的转换器
}
@property (null_resettable, nonatomic, strong)CameraView *view;
@end
