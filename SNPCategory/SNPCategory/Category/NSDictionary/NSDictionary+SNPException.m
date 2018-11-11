//
//  NSDictionary+SNPException.m
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "NSDictionary+SNPException.h"
#import <objc/runtime.h>

@implementation NSDictionary (SNPException)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method methodSysSetObj = class_getInstanceMethod(objc_getClass("__NSDictionaryM"), @selector(setObject:forKey:));
        Method methodMySetObj = class_getInstanceMethod(objc_getClass("NSMutableDictionary"), @selector(znsetObject:forKey:));
        
        method_exchangeImplementations(methodSysSetObj, methodMySetObj);
    });
}

- (void)znsetObject:(id)anObject forKey:(id<NSCopying>)key {
    if (anObject && key) {
        [self znsetObject:anObject forKey:key];
    } else {
        @try {
            [self znsetObject:anObject forKey:key];
        } @catch (NSException *exception) {
            [self logExceptionInfo:exception];
        } @finally {
            
        }
    }
}

- (void)logExceptionInfo:(NSException *)exception {
    NSLog(@"--------%s It Will Crash Because Method %s --------", class_getName(self.class), __func__);
    NSLog(@"----%@----", [exception name]);
    NSLog(@"----%@----", [exception reason]);
    NSLog(@"----%@----", [exception callStackSymbols]);
    NSLog(@"----OVER----");
}

@end
