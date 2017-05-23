//
//  CameraView.h
//  VUE
//
//  Created by admin on 17/2/27.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OIView;

@interface CameraView : UIView

/*!
 @property previewView
 @abstract 镜头画面的预览View。
 @discussion 主要供外部OIVideoCaptor渲染镜头画面，以及本类的子类修改界面时使用。
 */
@property (readonly, nonatomic) OIView *previewView;

/*!
 @property effectView
 @abstract 毛玻璃。
 @discussion 拍完视频后显示毛玻璃。
 */
@property (nonatomic, weak) UIVisualEffectView *effectView;

/*!
 @property baseView
 @abstract 放置基本控件的View。
 @discussion 主要为了录像时隐藏控件。
 */
@property (nonatomic, weak) UIView *baseView;

/*!
 @property moreBtn
 @abstract 更多按钮。
 @discussion 控制更多菜单的显示与隐藏。
 */
@property (nonatomic, weak)UIButton *moreBtn;

/*!
 @property changeCameraBtn
 @abstract 切换前后镜头按钮。
 @discussion 切换前后置镜头。
 */
@property (nonatomic, weak)UIButton *changeCameraBtn;

/*!
 @property changeFilterBtn
 @abstract 切换滤镜按钮。
 @discussion 切换滤镜。
 */
@property (nonatomic, weak)UIButton *changeFilterBtn;

/*!
 @property pickVideoBtn
 @abstract 从相册选择视频按钮。
 @discussion 从相册选择视频。
 */
@property (nonatomic, weak)UIButton *pickVideoBtn;

/*!
 @property deleteVideoBtn
 @abstract 删除视频按钮。
 @discussion 从选择的视频删除。
 */
@property (nonatomic, weak)UIButton *deleteVideoBtn;

/*!
 @property recordBtn
 @abstract 录制视频按钮。
 @discussion 录制视频。
 */
@property (nonatomic, weak)UIButton *recordBtn;

/*!
 @property recordNextImage
 @abstract 录制视频按钮上的imagview。
 @discussion 提示用户进行下一步操作。
 */
@property (nonatomic, weak)UIImageView *recordNextImage;


/*!
 @property progress
 @abstract 录制视频段数(0-3)。
 @discussion 进度提示。
 */
@property (nonatomic, assign)NSUInteger progress;

/*!
 @property progressBar
 @abstract 录制视频段数Bar。
 @discussion 进度条。
 */
@property (nonatomic, weak)UIView *progressBar;

/*!
 @property progressLayer
 @abstract 录制一段视频时的圆形进度条。
 @discussion 圆形进度条。
 */
@property (nonatomic, strong)CAShapeLayer *progressLayer;

/*!
 @property timeLabel
 @abstract 录制一段视频时的倒计时。
 @discussion 倒计时。
 */
@property (nonatomic, weak)UILabel *timeLabel;
@end
