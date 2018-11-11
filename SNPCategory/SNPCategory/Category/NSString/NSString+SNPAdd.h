//
//  NSString+SNPAdd.h
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (SNPAdd)

- (NSInteger (^)(void))strToInteger;

- (int (^)(void))strToInt;

- (double (^)(void))strToDouble;

- (float (^)(void))strToFloat;

- (NSData *(^)(void))strToData;

- (NSDictionary *(^)(void))strToDict;

@end

NS_ASSUME_NONNULL_END
