//
//  NSString+SNPAdd.m
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "NSString+SNPAdd.h"

@implementation NSString (SNPAdd)

- (NSInteger (^)(void))strToInteger {
    return ^() {
        return [self integerValue];
    };
}

- (int (^)(void))strToInt {
    return ^() {
        return [self intValue];
    };
}

- (double (^)(void))strToDouble {
    return ^() {
        return [self doubleValue];
    };
}

- (float (^)(void))strToFloat {
    return ^() {
        return [self floatValue];
    };
}

- (NSData * _Nonnull (^)(void))strToData {
    return ^() {
        NSData *strData = [self dataUsingEncoding:NSUTF8StringEncoding];
        return strData;
    };
}

- (NSDictionary * _Nonnull (^)(void))strToDict {
    return ^() {
        NSError *err = nil;
        NSData *strData = self.strToData();
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:strData options:NSJSONReadingMutableContainers error:&err];
        if (err) {
            NSLog(@"str To Dict Error : %@", err);
        }
        return dict;
    };
}

@end
