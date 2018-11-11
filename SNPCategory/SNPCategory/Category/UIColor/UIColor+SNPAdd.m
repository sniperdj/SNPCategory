//
//  UIColor+SNPAdd.m
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "UIColor+SNPAdd.h"

@implementation UIColor (SNPAdd)

+ (UIColor *)snp_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue alpha:(CGFloat)alpha {
    
    return [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
}

+ (UIColor *)snp_colorWithRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue {
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

+ (UIColor *)snp_colorWithHexIntValue:(unsigned int)value alpha:(CGFloat)alpha {
    NSUInteger red = (value & 0xFF0000) >> 16;
    NSUInteger green = (value & 0xFF00) >> 8;
    NSUInteger blue = value & 0xFF;
    return [UIColor snp_colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)snp_colorWithHexIntValue:(unsigned int)value {
    
    return [UIColor snp_colorWithHexIntValue:value alpha:1];
}

+ (UIColor *)snp_colorWithHexString:(NSString *)strHex alpha:(CGFloat)alpha {
    
    NSString *cString = [[strHex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor clearColor];
    
    // strip 0X if it appears
    BOOL hasPre = [cString hasPrefix:@"0X"] || [cString hasPrefix:@"0x"];
    if (hasPre) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor snp_colorWithRed:r green:g blue:b alpha:alpha];
}

+ (UIColor *)snp_colorWithHexString:(NSString *)strHex {
    
    return [UIColor snp_colorWithHexString:strHex alpha:1];
}

- (UIImage * _Nonnull (^)(CGSize))colorToImage {
    return ^(CGSize size) {
        CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(ctx, [self CGColor]);
        CGContextFillRect(ctx, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    };
}

@end
