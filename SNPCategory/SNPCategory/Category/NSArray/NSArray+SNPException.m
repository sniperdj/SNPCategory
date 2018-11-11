//
//  NSArray+SNPException.m
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "NSArray+SNPException.h"
#import <objc/runtime.h>

@implementation NSArray (SNPException)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method methodSysObjAtIdx2 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
        Method methodMyObjAtIdx = class_getInstanceMethod(objc_getClass("NSArray"), @selector(snpobjectAtIndex:));
        method_exchangeImplementations(methodSysObjAtIdx2, methodMyObjAtIdx);
        
        Method methodSysObjAtIdx3 = class_getInstanceMethod(objc_getClass("__NSArrayM"), @selector(objectAtIndexedSubscript:));
        Method methodMyObjAtIdx4 = class_getInstanceMethod(objc_getClass("NSArray"), @selector(snpobjectAtIndexedSubscript:));
        method_exchangeImplementations(methodSysObjAtIdx3, methodMyObjAtIdx4);
    });
}

// 防止数组下标越界
- (id)snpobjectAtIndex:(NSInteger)index {
    id obj = nil;
    @try {
        obj = [self snpobjectAtIndex:index];
    } @catch (NSException *exception) {
        NSLog(@"--------%s Exception %s --------", class_getName(self.class), __func__);
        NSLog(@"----Name : %@----", [exception name]);
        NSLog(@"----Reason : %@----", [exception reason]);
        NSLog(@"----CallStackSymbols : %@----", [exception callStackSymbols]);
    } @finally {
        return obj;
    }
}

- (id)snpobjectAtIndexedSubscript:(NSInteger)index {
    id obj = nil;
    @try {
        obj = [self snpobjectAtIndexedSubscript:index];
    } @catch (NSException *exception) {
        NSLog(@"--------%s Exception %s --------", class_getName(self.class), __func__);
        NSLog(@"----Name : %@----", [exception name]);
        NSLog(@"----Reason : %@----", [exception reason]);
        NSLog(@"----CallStackSymbols : %@----", [exception callStackSymbols]);
    } @finally {
        return obj;
    }
}

@end
