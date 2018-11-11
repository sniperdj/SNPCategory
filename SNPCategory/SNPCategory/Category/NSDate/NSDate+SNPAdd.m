//
//  NSDate+SNPAdd.m
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "NSDate+SNPAdd.h"
#import "NSDateFormatter+SNPAdd.h"

@implementation NSDate (SNPAdd)

- (NSString * _Nonnull (^)(NSString * _Nonnull))dateToStrWithFormat {
    return ^(NSString *fmt) {
        NSDateFormatter *dateFmt = [NSDateFormatter dateFormatter];
        dateFmt.formattDateWithStrFmt(fmt);
        return [dateFmt stringFromDate:self];
    };
}

@end
