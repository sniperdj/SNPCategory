//
//  NSDate+SNPAdd.h
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (SNPAdd)

- (NSString *(^)(NSString *))dateToStrWithFormat;

@end

NS_ASSUME_NONNULL_END
