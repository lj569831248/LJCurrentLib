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
        NSString *className = NSStringFromClass([obj class]) ;
        if ([className isEqualToString:@"__NSCFString"] | [className isEqualToString:@"__NSCFConstantString"] | [className isEqualToString:@"NSTaggedPointerString"]) {
            [strM appendFormat:@" \"%@\",",obj];
        }else if ([className isEqualToString:@"__NSCFDictionary"]){
            NSString *dictString = [obj descriptionWithPostParam];
            [strM appendFormat:@" %@",dictString];
        }else if ([className isEqualToString:@"__NSCFNumber"]){
            [strM appendFormat:@" %@,",obj];
        }else if ([className isEqualToString:@"__NSSingleObjectArrayI"]||[className isEqualToString:@"__NSArrayI"]){
            NSString *arrayString = [obj descriptionWithPostParam];
            [strM appendFormat:@" %@",arrayString];
        }
    }];
    [strM deleteCharactersInRange:NSMakeRange(strM.length - 1, 1)];
    [strM appendString:@"\n ]"];
    return strM;
}

@end
