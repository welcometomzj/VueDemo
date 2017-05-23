//
//  EditViewToolView.h
//  VUE
//
//  Created by admin on 17/3/9.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  发送消息类型
 */
typedef NS_ENUM(NSUInteger, EditViewToolViewType) {
    /**
     * 细节编辑
     */
    EditViewToolViewTypeDetail = 0,
    /**
     *  分段编辑
     */
    EditViewToolViewTypeShot,
    /**
     *  添加音乐
     */
    EditViewToolViewTypeMusic,
    /**
     *  添加贴纸
     */
    EditViewToolViewTypeSticker
};

typedef void(^CompleteEditBlock)(NSArray *orderArray);

@interface EditViewToolView : UIView

@property (nonatomic, copy)CompleteEditBlock completeBlock;

- (instancetype)initWithType:(EditViewToolViewType)toolViewType frame:(CGRect)frame;
@end
