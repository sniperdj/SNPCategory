//
//  UIImage+SNPAdd.h
//  SNPCategory
//
//  Created by Sniper on 2018/11/11.
//  Copyright © 2018 Sniper. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SNPAdd)


/** 从gifData中分解出图片数组 */
+ (NSArray *)imagesFromGifData:(NSData *)gifData;
/** 从gif路径中中分解出图片数组 */
+ (NSArray *)imagesFromGifUrl:(NSURL *)gifUrl;
/** 将图片数组合成为gif  返回值:YES成功  NO失败 */
+ (BOOL)imageGifFromImages:(NSArray *)imgsArr atPath:(NSString *)gifFolderPath withName:(NSString *)gifName;

/** 将图片逆时针旋转x度  x / 180 * M_PI */
- (UIImage *)imageRotateWithAngle:(CGFloat)angle;

/** 将图片中cutRect部分剪切出来变成UIImage并返回 */
- (UIImage *)imageCutWithRect:(CGRect)cutRect;

/** 圆图 */
- (UIImage *)imageToCircle;
/** 设置图片圆角半径 */
- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

/** 将图片拉伸成大小为size的图片 */
- (UIImage *)imageWithSize:(CGSize)size;

/** 添加图片水印 */
- (UIImage *)imageWithWaterPrint:(UIImage *)waterPrintImg
                          inRect:(CGRect)rect;
/** 添加文字水印 */
- (UIImage *)imageWithWaterPrintStr:(NSString *)str
                            andFont:(UIFont *)font
                           andColor:(UIColor *)color
                             inRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
