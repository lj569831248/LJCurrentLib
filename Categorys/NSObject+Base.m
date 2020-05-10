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

+ (void)replaceInstanceMethod:(Class)class1 originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
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


+ (void)replaceClassMethod:(Class)class1 originalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    Method originalMethod = class_getClassMethod(class1, originalSelector);
    Method swizzledMethod = class_getClassMethod(class1, swizzledSelector);
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


+ (void)replaceInstanceMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    [self replaceInstanceMethod:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
}

+ (void)replaceClassMethodWithOriginalSelector:(SEL)originalSelector swizzledSelector:(SEL)swizzledSelector{
    [self replaceClassMethod:[self class] originalSelector:originalSelector swizzledSelector:swizzledSelector];
}
/*
 原始为
 name = "_series";
 type = "@\"NSString\"";
 转换为
 name = series;
 type = NSString;
20190318更新 之前只获取了当前类的属性列表,现在会获取父类直到NSObject的属性列表
*/
+ (NSArray *)getIvarNamesAndTypes{
    unsigned int outCount = 0;
    NSMutableArray *mArray = [[NSMutableArray alloc] init];
    Class cls = [self class];
    while (cls!= [NSObject class]) {
    Ivar * ivars = class_copyIvarList(cls, &outCount);
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
        cls = class_getSuperclass(cls);

    }
    return [mArray copy];
}

/*
{name = boolT;type = B;},
{name = BOOLT;type = B;},
{name = BooleanT;type = C;},
{name = charT;type = c;},
{name = intT;type = i;},
{name = longT;type = q;},
{name = longlongT;type = q;},
{name = floatT;type = f;},
{name = NSIntegerT;type = q;},
{name = NSUIntegerT;type = Q;},
{name = doubleT;type = d;},
{name = CGFloatT;type = d;},
{name = NSStringT;type = NSString;},
{name = NSNumberT;type = NSNumber;}
 */
@end
