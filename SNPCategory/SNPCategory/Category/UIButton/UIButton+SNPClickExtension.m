//
//  UIButton+SNPClickExtension.m
//  SNPCategory
//
//  Created by Sniper on 2019/1/3.
//  Copyright © 2019 Sniper. All rights reserved.
//

#import "UIButton+SNPClickExtension.h"
#import <objc/runtime.h>

// 时间间隔
static NSString *const kIgnoreTimeIntervalKey     = @"ignoreTimeIntervalKey";
static NSString *const kIgnoreEventKey            = @"ignoreEventKey";

@implementation UIButton (SNPClickExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method methodSendAction = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
        Method myMethodSendAction = class_getInstanceMethod(self, @selector(snp_sendAction:to:forEvent:));
        method_exchangeImplementations(methodSendAction, myMethodSendAction);
    });
}

- (void)snp_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    self.btnTimeInterval = self.btnTimeInterval == 0 ? btnTimeIntervalValue : self.btnTimeInterval;
    
    if ([self isBtnIgnoreActionIng]) { // 时间间隔中 不响应事件
        return;
    }
    // 开始不响应时间
    [self setBtnIgnoreAction:YES];
    // 把收到的event处理了
    [self snp_sendAction:action to:target forEvent:event];
    // 时间间隔之后开始响应事件
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.btnTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self sendActionFromNow];
    });
    
}

- (void)sendActionFromNow {
    objc_setAssociatedObject(self, &kIgnoreEventKey, @NO, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - 响应间隔
- (void)setBtnTimeInterval:(NSTimeInterval)btnTimeInterval {
    NSNumber *interval = [NSNumber numberWithDouble:btnTimeInterval];
    objc_setAssociatedObject(self, &kIgnoreTimeIntervalKey, interval, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTimeInterval)btnTimeInterval {
    NSNumber *interval = objc_getAssociatedObject(self, &kIgnoreTimeIntervalKey);
    return [interval doubleValue];
}

#pragma mark - 是否忽略本次响应
- (void)setBtnIgnoreAction:(BOOL)ignore {
    NSNumber *ignoreValue = [NSNumber numberWithBool:ignore];
    objc_setAssociatedObject(self, &kIgnoreEventKey, ignoreValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)isBtnIgnoreActionIng {
    NSNumber *ignoreValue = objc_getAssociatedObject(self, &kIgnoreEventKey);
    return [ignoreValue boolValue];
}



@end
