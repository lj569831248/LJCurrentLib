//
//  UIColor+Base.h
//  ruhang
//
//  Created by Jon on 2016/11/24.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Base)

- (NSString *)getHexString;

- (NSDictionary *)getRGBDictionary;

+ (UIColor *)ColorFromHex:(NSString *)color;
@end
