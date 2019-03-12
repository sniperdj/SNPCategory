//
//  SNPDispatchUtils.h
//  SNPCategory
//
//  Created by Sniper on 2019/3/12.
//  Copyright © 2019 Sniper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNPDispatchUtils : NSObject

/**
 *  主线程执行
 *  @param block 代码块
 */
void doInMain(dispatch_block_t block);
void doInMainAfter(NSTimeInterval sec, dispatch_block_t block);

/**
 *  全局队列：异步、串行、顺序执行、速度慢
 *  @param block 代码块
 */
void doInSerial(dispatch_block_t block);
void doInSerialAfter(NSTimeInterval sec, dispatch_block_t block);

/**
 *  全局队列：异步、并发、没有顺序、速度快
 *  @param block 代码块
 */
void doInConcurrent(dispatch_block_t block);
void doInConCurrentAfter(NSTimeInterval sec, dispatch_block_t block);

@end

NS_ASSUME_NONNULL_END
