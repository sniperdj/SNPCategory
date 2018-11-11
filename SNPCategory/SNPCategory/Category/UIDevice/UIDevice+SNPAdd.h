//
//  UIDevice+SNPAdd.h
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (SNPAdd)

- (NSString *)getDeviceIP;

- (NSString *)getDeviceModel;

- (double)availableMemory;

- (double)usedMemory;

@end

NS_ASSUME_NONNULL_END
