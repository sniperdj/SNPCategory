//
//  UIButton+SNPAdd.m
//  SNPCategory
//
//  Created by Sniper on 2019/1/2.
//  Copyright © 2019 Sniper. All rights reserved.
//

#import "UIButton+SNPAdd.h"
#import <objc/runtime.h>

static NSString *const kTop     = @"top";
static NSString *const kLeft    = @"left";
static NSString *const kBottom  = @"bottom";
static NSString *const kRight   = @"right";

@implementation UIButton (SNPAdd)

- (void)btnOfAreaWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right {
    objc_setAssociatedObject(self, &kTop, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &kLeft, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &kBottom, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &kRight, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)btnOfEdge:(CGFloat)edge {
    objc_setAssociatedObject(self, &kTop, [NSNumber numberWithFloat:edge], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &kLeft, [NSNumber numberWithFloat:edge], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &kBottom, [NSNumber numberWithFloat:edge], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &kRight, [NSNumber numberWithFloat:edge], OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CGRect)actionRect {
    NSNumber *numTop = objc_getAssociatedObject(self, &kTop);
    NSNumber *numLeft = objc_getAssociatedObject(self, &kLeft);
    NSNumber *numBottom = objc_getAssociatedObject(self, &kBottom);
    NSNumber *numRight = objc_getAssociatedObject(self, &kRight);
    
    CGFloat top = [numTop floatValue];
    CGFloat left = [numLeft floatValue];
    CGFloat bottom = [numBottom floatValue];
    CGFloat right = [numRight floatValue];
    
    CGRect area = CGRectMake(self.bounds.origin.x - left, self.bounds.origin.y - top, self.bounds.size.width + left + right, self.bounds.size.height + top + bottom);
    return area;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    CGRect actionArea = [self actionRect];
    if (CGRectEqualToRect(actionArea, self.bounds)) {
        return [super hitTest:point withEvent:event];
    }
    return CGRectContainsPoint(actionArea, point) ? self : nil;
}

@end
