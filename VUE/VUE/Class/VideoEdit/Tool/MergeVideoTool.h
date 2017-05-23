//
//  MergeVideoTool.h
//  VUE
//
//  Created by admin on 17/3/10.
//  Copyright © 2017年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MergeVideoTool : NSObject

/**
 *  多个视频合成为一个视频输出到指定路径
 *
 *  @param tArray       视频文件NSURL地址
 *  @param musicName    音乐文件名字
 *  @param storePath    沙盒目录下的文件夹
 *  @param storeName    合成的文件名字
 *  @param successBlock 成功block
 *  @param failureBlcok 失败block
 */
+ (void)mergeVideoToOneVideo:(NSArray *)tArray musicName:(NSString *)musicName toStorePath:(NSString *)storePath WithStoreName:(NSString *)storeName success:(void (^)(NSURL *outputUrl))successBlock failure:(void (^)(void))failureBlcok;

@end
