//
//  NSObject+Base.h
//  ruhang
//
//  Created by Jon on 2016/11/24.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Base)

/**
 利用 runtime 替换方法
 @param class 类
 @param originalSelector 原方法
 @param swizzledSelector 新方法
 */
+ (void)replaceMethod:(Class)class originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

@end
