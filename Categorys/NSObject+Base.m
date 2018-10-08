//
//  NSObject+Base.m
//  ruhang
//
//  Created by Jon on 2016/11/24.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "NSObject+Base.h"
#import <objc/runtime.h>
@implementation NSObject (Base)

+ (void)replaceMethod:(Class)class1 originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    Method originalMethod = class_getInstanceMethod(class1, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class1, swizzledSelector);
    if (!originalMethod || !swizzledMethod) {
        return;
    }
    IMP originalIMP = method_getImplementation(originalMethod);
    IMP swizzledIMP = method_getImplementation(swizzledMethod);
    const char *originalType = method_getTypeEncoding(originalMethod);
    const char *swizzledType = method_getTypeEncoding(swizzledMethod);
    
    class_replaceMethod(class1,originalSelector,swizzledIMP,swizzledType);
    class_replaceMethod(class1,swizzledSelector,originalIMP,originalType);
}

/*
 原始为
 name = "_series";
 type = "@\"NSString\"";
 转换为
 name = series;
 type = NSString;
*/
+ (NSArray *)getIvarNamesAndTypes{
    unsigned int outCount = 0;
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        const char * type = ivar_getTypeEncoding(ivar);
        NSString *typeS = [[NSString alloc] initWithCString:type encoding:NSUTF8StringEncoding];
        NSString *nameS = [[NSString alloc] initWithCString:name encoding:NSUTF8StringEncoding];
        typeS = [typeS stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        typeS = [typeS stringByReplacingOccurrencesOfString:@"@" withString:@""];
        nameS = [nameS substringFromIndex:1];
        NSDictionary *dict = @{@"name":nameS,@"type":typeS};
        [mArray addObject:dict];
    }
    free(ivars);
    return [mArray copy];
}
@end
