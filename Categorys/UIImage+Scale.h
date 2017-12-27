//
//  UIImage+Scale.h
//  FastThree
//
//  Created by Jon on 2017/12/27.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)

/**
 缩放图片
 @param img 原图
 @param newsize 新尺寸
 @return 处理过后的图片
 */
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)newsize;

@end
