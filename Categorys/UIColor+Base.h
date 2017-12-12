//
//  UIColor+Base.h
//  ruhang
//
//  Created by Jon on 2016/11/24.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Base)

/**
 获取图片 Alpha 值
 */
- (CGFloat)alphaNumber;

/**
 判断颜色深浅
 */
- (BOOL)isDarkColor;

/**
 获取颜色的 RGBA
 @return {@"R":@255,@"G":255,@"B":@255,@"A":@1}
 */
- (NSDictionary *)getRGBDictionary;

/**
 获取颜色的16进制值
 @return 16进制的字符串 例如#bfbfbf
 */
- (NSString *)getHexString;

/**
 根据 16进制值获取颜色
 @param color 16进制颜色 例如:#bfbfbf
 @return Color
 */
+ (UIColor *)ColorFromHex:(NSString *)color;
@end
