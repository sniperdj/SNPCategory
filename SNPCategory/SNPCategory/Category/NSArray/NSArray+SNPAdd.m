//
//  NSArray+SNPAdd.m
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "NSArray+SNPAdd.h"

@implementation NSArray (SNPAdd)

- (NSData * _Nonnull (^)(void))arrToData {
    return ^() {
        NSError *err = nil;
        NSData *arrData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&err];
        if (err) {
            NSLog(@"arr to data err : %@", err);
        }
        return arrData;
    };
}

- (NSString * _Nonnull (^)(void))arrToStrJSON {
    return ^() {
        NSData *arrData = self.arrToData();
        NSString *strJSON = [[NSString alloc] initWithData:arrData encoding:NSUTF8StringEncoding];
        return strJSON;
    };
}

- (id)copyDeeply {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id item = obj;
        if ([item respondsToSelector:@selector(copyDeeply)]) {
            item = [item copyDeeply];
        } else {
            [item copy];
        }
        if (item) {
            [array addObject:item];
        }
    }];
    return [NSArray arrayWithArray:array];
}

- (id)mutableCopyDeeply {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        id item = obj;
        if ([item respondsToSelector:@selector(mutableCopyDeeply)]) {
            item = [item mutableCopyDeeply];
        } else if ([item respondsToSelector:@selector(copyDeeply)]) {
            item = [item mutableCopy];
        } else {
            item = [item copy];
        }
        if (item) {
            [array addObject:item];
        }
    }];
    return array;
}

@end
