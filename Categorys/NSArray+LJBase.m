//
//  NSArray+LJBase.m
//  HBLockTest
//
//  Created by Jon on 2018/10/8.
//  Copyright © 2018年 Jon. All rights reserved.
//

#import "NSArray+LJBase.h"
#import "NSDictionary+Base.h"
@implementation NSArray (LJBase)

- (NSString *)descriptionWithPostParam{
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"["];
    [self enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [strM appendString:@"\n"];
        if ([obj isKindOfClass:[NSString class]]) {
            [strM appendFormat:@" \"%@\",",obj];
        }else if ([obj isKindOfClass:[NSDictionary class]]){
            NSString *dictString = [obj descriptionWithPostParam];
            [strM appendFormat:@" %@",dictString];
        }else if ([obj isKindOfClass:[NSNumber class]]){
            [strM appendFormat:@" %@,",obj];
        }else if ([obj isKindOfClass:[NSArray class]]){
            NSString *arrayString = [obj descriptionWithPostParam];
            [strM appendFormat:@" %@",arrayString];
        }
//        NSString *className = NSStringFromClass([obj class]) ;
//        if ([className isEqualToString:@"__NSCFString"] | [className isEqualToString:@"__NSCFConstantString"] | [className isEqualToString:@"NSTaggedPointerString"]) {
//            [strM appendFormat:@" \"%@\",",obj];
//        }else if ([className isEqualToString:@"__NSCFDictionary"]){
//            NSString *dictString = [obj descriptionWithPostParam];
//            [strM appendFormat:@" %@",dictString];
//        }else if ([className isEqualToString:@"__NSCFNumber"]){
//            [strM appendFormat:@" %@,",obj];
//        }else if ([className isEqualToString:@"__NSSingleObjectArrayI"]||[className isEqualToString:@"__NSArrayI"]){
//            NSString *arrayString = [obj descriptionWithPostParam];
//            [strM appendFormat:@" %@",arrayString];
//        }
    }];
    [strM deleteCharactersInRange:NSMakeRange(strM.length - 1, 1)];
    [strM appendString:@"\n ]"];
    return strM;
}


- (BOOL)containsString:(NSString *)string{
    return YES;
}


@end
