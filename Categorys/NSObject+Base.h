//
//  NSObject+Base.h
//  ruhang
//
//  Created by Jon on 2016/11/24.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Base)

///  利用 runtime 替换对象方法
/// @param class1 需要替换的类
/// @param originalSelector 原方法
/// @param swizzledSelector 新方法
+ (void)replaceInstanceMethod:(Class)class1 originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

///  利用 runtime 替换当前对象方法
/// @param originalSelector 原对象方法
/// @param swizzledSelector 新对象方法
+ (void)replaceInstanceMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

///  利用 runtime 替换类方法
/// @param class1 需要替换的类的元类 Class aClass = object_getClass((id)self);
/// @param originalSelector 原方法
/// @param swizzledSelector 新方法
+ (void)replaceClassMethod:(Class)class1 originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

///  利用 runtime 替换当前类方法
/// @param originalSelector 原对象方法
/// @param swizzledSelector 新对象方法
+ (void)replaceClassMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector;

/**
 获取成员变量名与类型 数组
 @return [{变量名:类型},{变量名:类型}]
 */
+ (NSArray *)getIvarNamesAndTypes;
@end
