//
//  MyDefaults.m
//  FastThree
//
//  Created by Jon on 2017/11/29.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "MyDefaults.h"

static MyDefaults *standardDefaults = nil;


@implementation MyDefaults

+(id)standardDefaults{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        standardDefaults = [[self alloc] init];
        standardDefaults.defaultDateFormat = kDefaultDateFormat;
    });
    return standardDefaults;
}


@end
