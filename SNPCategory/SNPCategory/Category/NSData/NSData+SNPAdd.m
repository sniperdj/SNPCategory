//
//  NSData+SNPAdd.m
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "NSData+SNPAdd.h"

@implementation NSData (SNPAdd)

- (NSString * _Nonnull (^)(void))dataToStr {
    return ^() {
        return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    };
}

- (NSDictionary * _Nonnull (^)(void))dataToDict {
    return ^() {
        NSError *err = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:&err];
        if (err) {
            NSLog(@"data to dict err : %@", err);
        }
        return dict;
    };
}

@end
