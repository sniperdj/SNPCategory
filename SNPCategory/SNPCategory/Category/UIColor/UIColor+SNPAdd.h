//
//  UIColor+SNPAdd.h
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (SNPAdd)

+ (UIColor *)snp_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha;

+ (UIColor *)snp_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;

+ (UIColor *)snp_colorWithHexIntValue:(unsigned int)value alpha:(CGFloat)alpha;

+ (UIColor *)snp_colorWithHexIntValue:(unsigned int)value;

+ (UIColor *)snp_colorWithHexString:(NSString *)strHex alpha:(CGFloat)alpha;

+ (UIColor *)snp_colorWithHexString:(NSString *)strHex;

- (UIImage *(^)(CGSize size))colorToImage;

@end

NS_ASSUME_NONNULL_END
