//
//  NSDateFormatter+SNPAdd.m
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "NSDateFormatter+SNPAdd.h"

@implementation NSDateFormatter (SNPAdd)

+ (instancetype)dateFormatter {
    static NSDateFormatter *dateFmter = nil;
    if (!dateFmter) {
        dateFmter = [NSDateFormatter new];
    }
    return dateFmter;
}

- (NSDateFormatter * _Nonnull (^)(NSString * _Nonnull))formattDateWithStrFmt {
    return ^(NSString *fmt) {
        if (fmt) {
            self.dateFormat = fmt;
        }
        return self;
    };
}

@end
