//
//  NSDictionary+Base.m
//  Inker
//
//  Created by Jon on 2016/12/7.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "NSDictionary+Base.h"
#import "NSArray+LJBase.h"
#import <objc/runtime.h>

@implementation NSDictionary (Base)

//+ (void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        SEL selA = @selector(description);
//        SEL selB = @selector(my_description);
//        Method methodA =   class_getInstanceMethod(self,selA);
//        Method methodB = class_getInstanceMethod(self, selB);
//        //将 methodB的实现 添加到系统方法中 也就是说 将 methodA方法指针添加成 方法methodB的  返回值表示是否添加成功
//        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
//        //添加成功了 说明 本类中不存在methodB 所以此时必须将方法b的实现指针换成方法A的，否则 b方法将没有实现。
//        if (isAdd) {
//            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
//        }else{
//            //添加失败了 说明本类中 有methodB的实现，此时只需要将 methodA和methodB的IMP互换一下即可。
//            method_exchangeImplementations(methodA, methodB);
//        }
//    });
//}

//解决中文打印 Unicode 编码
- (NSString *)my_description{
    NSString *desc = [self my_description];
    desc = [NSString stringWithCString:[desc cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
    return desc;
}

//这里面中文打印有点问题 当含有
/*
 {
 code = 0;
 data =     {
 ChannelCode = a00099991;
 CurrentVersion = "1.1.1";
 Description = "1.\U6dfb\U52a0\U81ea\U66f4\U65b0\U652f\U6301\n2.\U4f18\U5316iPhone X\U9875\U9762\U9002\U914d";
 FileSize = "2.63";
 NeedRemind = 1;
 RequiredVersion = "1.1.1";
 SystemCode = 101;
 UpdateLink = "https://cdn.51downapp.cn/bpc/app/ios/a00099991-1.1.1.html";
 VersionEnvironment = 0;
 };
 msg = "\U6210\U529f";
 }
这个返回的为Null 有空看下
 */
- (NSString *)descriptionWithNo_Unicode{
    return [NSString stringWithCString:[[self description] cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
}

- (void)descriptionWithModelStyle{
    NSMutableString *strM = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        //  NSLog(@"%@,%@",key,[obj class]);
        NSString *className = NSStringFromClass([obj class]) ;
        if ([className isEqualToString:@"__NSCFString"] | [className isEqualToString:@"__NSCFConstantString"] | [className isEqualToString:@"NSTaggedPointerString"]) {
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFArray"] |
                  [className isEqualToString:@"__NSArray0"] |
                  [className isEqualToString:@"__NSArrayI"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSArray *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFDictionary"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSDictionary *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFNumber"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSNumber *%@;\n",key];
        }else if ([className isEqualToString:@"__NSCFBoolean"]){
            [strM appendFormat:@"@property (nonatomic, assign) BOOL   %@;\n",key];
        }else if ([className isEqualToString:@"NSDecimalNumber"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
        else if ([className isEqualToString:@"NSNull"]){
            [strM appendFormat:@"@property (nonatomic, copy) NSString *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }else if ([className isEqualToString:@"__NSArrayM"]){
            [strM appendFormat:@"@property (nonatomic, strong) NSMutableArray *%@;\n",[NSString stringWithFormat:@"%@",key]];
        }
    }];
    NSLog(@"%@",strM);
}

- (NSString *)descriptionWithPostParam{
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"{"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendString:@"\n"];
        NSString *className = NSStringFromClass([obj class]) ;
        if ([className isEqualToString:@"__NSCFString"] | [className isEqualToString:@"__NSCFConstantString"] | [className isEqualToString:@"NSTaggedPointerString"]) {
            [strM appendFormat:@" \"%@\":\"%@\",",key,obj];
        }else if ([className isEqualToString:@"__NSCFDictionary"]){
            NSString *dictString = [obj descriptionWithPostParam];
            [strM appendFormat:@" %@",dictString];
        }else if ([className isEqualToString:@"__NSCFNumber"]){
            [strM appendFormat:@" \"%@\":%@,",key,obj];
        }else if ([className isEqualToString:@"__NSSingleObjectArrayI"]||[className isEqualToString:@"__NSArrayI"]){
            NSString *arrayString = [obj descriptionWithPostParam];
            [strM appendFormat:@" %@",arrayString];

        }
    }];
    [strM deleteCharactersInRange:NSMakeRange(strM.length - 1, 1)];
    [strM appendString:@"\n}"];
    return strM;
}
@end
