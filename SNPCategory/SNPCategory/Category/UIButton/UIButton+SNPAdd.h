//
//  UIButton+SNPAdd.h
//  SNPCategory
//
//  Created by Sniper on 2019/1/2.
//  Copyright © 2019 Sniper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SNPAdd)

- (void)btnOfAreaWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

- (void)btnOfEdge:(CGFloat)edge;

@end

NS_ASSUME_NONNULL_END
