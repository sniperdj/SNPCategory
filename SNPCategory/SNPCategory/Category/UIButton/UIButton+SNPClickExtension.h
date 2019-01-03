//
//  UIButton+SNPClickExtension.h
//  SNPCategory
//
//  Created by Sniper on 2019/1/3.
//  Copyright © 2019 Sniper. All rights reserved.
//

#import <UIKit/UIKit.h>

#define btnTimeIntervalValue 0.5

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SNPClickExtension)

///** 点击次数 */
//@property (nonatomic, assign, readonly)NSUInteger clickCnt;
/** 按钮响应间隔 */
@property (nonatomic, assign)NSTimeInterval btnTimeInterval;

@end

NS_ASSUME_NONNULL_END
