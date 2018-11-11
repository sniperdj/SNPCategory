//
//  NSDictionary+SNPAdd.m
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "NSDictionary+SNPAdd.h"

@implementation NSDictionary (SNPAdd)

- (NSData * _Nonnull (^)(void))dictToData {
    return ^() {
        NSError *err = nil;
        NSData *dictData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&err];
        if (err) {
            NSLog(@"dict to data err : %@", dictData);
        }
        return dictData;
    };
}

- (NSString *(^)(void))dictToStringJSON {
    return ^() {
        NSData *dictData = self.dictToData();
        NSString *strJSON = [[NSString alloc] initWithData:dictData encoding:NSUTF8StringEncoding];
        return strJSON;
    };
}

@end
