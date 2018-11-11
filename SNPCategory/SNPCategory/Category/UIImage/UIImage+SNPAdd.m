//
//  UIImage+SNPAdd.m
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import "UIImage+SNPAdd.h"

// GIF
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>
// Rotate
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>

@implementation UIImage (SNPAdd)

/**
 * 主要步骤: context drawRect getImageFromContext
 */

#pragma mark - GIF
+ (NSArray *)imagesFromGifData:(NSData *)gifData {
    // TODO 判断不是gif的情况  判断分解失败的情况
    CFDataRef dataRef = (__bridge CFDataRef)gifData;
    CGImageSourceRef source = CGImageSourceCreateWithData(dataRef, NULL);
    
    return [self getImagesFromImgSrc:source];
}

+ (NSArray *)imagesFromGifUrl:(NSURL *)gifUrl {
    // TODO 判断不是gif的情况 判断分解失败的情况
    CFURLRef urlRef = (__bridge CFURLRef)gifUrl;
    CGImageSourceRef source = CGImageSourceCreateWithURL(urlRef, NULL);
    
    return [self getImagesFromImgSrc:source];
}

+ (NSArray *)getImagesFromImgSrc:(CGImageSourceRef)source {
    // gif图片是多少帧
    size_t gifImgCount = CGImageSourceGetCount(source);
    
    NSMutableArray *gifImgArr = [NSMutableArray arrayWithCapacity:gifImgCount];
    
    for (size_t i = 0; i < gifImgCount; i++) {
        CGImageRef imageref = CGImageSourceCreateImageAtIndex(source, i, NULL);
        //        UIImage *img = [UIImage imageWithCGImage:imageref];
        UIImage *img = [UIImage imageWithCGImage:imageref scale:1.0 orientation:UIImageOrientationUp];
        [gifImgArr addObject:img];
        CGImageRelease(imageref);
    }
    CFRelease(source);
    return gifImgArr;
}

+ (BOOL)gifFromImages:(NSArray *)imgsArr atPath:(NSString *)gifFolderPath withName:(NSString *)gifName {
//    BOOL result = NO;
    
    //    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    // TODO 判断路径参数是否为空 判断名字是否为空
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr createDirectoryAtPath:gifFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    // 完整路径 (不知道需不需要判断gifName 有没有.gif后缀)
    NSString *gifPath = [gifFolderPath stringByAppendingPathComponent:gifName];
    
    CFURLRef urlRef = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef)gifPath, kCFURLPOSIXPathStyle, false);
    // 参数: url 目标类型 多少帧
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL(urlRef, kUTTypeGIF, imgsArr.count, NULL);
    
    NSDictionary *frameDic = @{(NSString *)kCGImagePropertyGIFDelayTime : [NSNumber numberWithFloat:0.3]};
    // 字典容量 : 2
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:4];
    dict[(NSString *)kCGImagePropertyGIFHasGlobalColorMap] = [NSNumber numberWithBool:YES];
    dict[(NSString *)kCGImagePropertyColorModel] = (NSString *)kCGImagePropertyColorModelRGB;
    dict[(NSString *)kCGImagePropertyDepth] = @8;
    dict[(NSString *)kCGImagePropertyGIFLoopCount] = @0;
    
    NSDictionary *gifProperty = [NSDictionary dictionaryWithObject:dict forKey:(NSString *)kCGImagePropertyGIFDictionary];
    // 单帧添加到gif
    for (UIImage *img in imgsArr) {
        CGImageDestinationAddImage(destination, img.CGImage, (__bridge CFDictionaryRef)frameDic);
    }
    // TODO 👇这句话有警告:setProperties:1485: image destination cannot be changed once an image was added
    CGImageDestinationSetProperties(destination, (__bridge CFDictionaryRef)gifProperty);
    // 释放
    CGImageDestinationFinalize(destination);
    CFRelease(destination);
    // TODO 其实是要返回成功还是失败的
    return YES;
}

#pragma mark - Rotate
- (UIImage *)imageRotateWithAngle:(CGFloat)angle {
    
    size_t width = (size_t)self.size.width * self.scale;
    size_t height = (size_t)self.size.height * self.scale;
    // 每行图片多少字节
    size_t bytesPerRow = width * 4;
    // alpha通道
    CGImageAlphaInfo alphaInfo = kCGImageAlphaPremultipliedFirst;
    // NULL, 宽度, 高度, 2的8次幂的颜色(0-255), 设备RGB的颜色空间, BitmapByte排列方式;
    CGContextRef ctx = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, CGColorSpaceCreateDeviceRGB(), kCGBitmapByteOrderDefault | alphaInfo);
    if (!ctx) {
        return nil;
    } else {
        CGContextDrawImage(ctx, CGRectMake(0, 0, width, height), self.CGImage);
        UInt8 *data = CGBitmapContextGetData(ctx);
        vImage_Buffer src = {data, height, width, bytesPerRow};
        vImage_Buffer dest = {data, height, width, bytesPerRow};
        Pixel_8888 bgColor ={0, 0, 0, 0}; // Red Green Blue Alpha
        // 旋转
        // 1.旋转的源图片, 2.旋转之后的图片, 3.NULL 4.旋转角度, 5.背景颜色, 6.填充颜色
        vImageRotate_ARGB8888(&src, &dest, NULL, angle, bgColor, kvImageBackgroundColorFill);
        
        // context -> UIImage
        CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
        UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:UIImageOrientationUp];
        
        CGImageRelease(imageRef);
        CFRelease(ctx);
        
        return image;
    }
}

#pragma mark - Cut
- (UIImage *)imageCutWithRect:(CGRect)cutRect {
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, cutRect);
    CGRect subRect = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    UIGraphicsBeginImageContext(subRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextDrawImage(ctx, subRect, subImageRef);
    UIImage *img = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    CGImageRelease(subImageRef);
    
    return img;
}

#pragma mark - CornerRadios
- (UIImage *)circleImage {
    // NO 代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    // 裁剪
    CGContextClip(ctx);
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage *)imageWithCornerRadius:(CGFloat)radius {
    
    // NO 代表透明
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 添加一个椭圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    
    // 裁剪
    [bezierPath addClip];
    // 将图片画上去
    [self drawInRect:rect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

#pragma mark - 拉伸
- (UIImage *)imageWithSize:(CGSize)size {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
    
}

#pragma mark - Screenshot
//- (UIImage *)imageWithScreenshot {
//    return nil;
//}

#pragma mark - WaterPrint
- (UIImage *)imageWithWaterPrint:(UIImage *)waterPrintImg
                          inRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 原始图片渲染
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    // 水印图片渲染
    [waterPrintImg drawInRect:rect];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

- (UIImage *)imageWithWaterPrintStr:(NSString *)str
                            andFont:(UIFont *)font
                           andColor:(UIColor *)color
                             inRect:(CGRect)rect {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    // 原始图片渲染
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    NSDictionary *waterPrintStrAttr = @{NSFontAttributeName : font, NSForegroundColorAttributeName : color};
    if (CGRectIsEmpty(rect)) {
        rect = [str boundingRectWithSize:self.size options:NSStringDrawingUsesLineFragmentOrigin attributes:waterPrintStrAttr context:nil];
    }
    // 水印文字渲染
    [str drawInRect:rect withAttributes:waterPrintStrAttr];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

@end
