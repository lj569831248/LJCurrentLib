//
//  MyDBModel.m
//  FastThree
//
//  Created by Jon on 2017/11/29.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "MyDBModel.h"
#import "NSString+Unicode.h"
#import "NSString+Time.h"


@implementation MyDBModel

- (id)init{
    if (self = [super init]) {
        NSString *uuid = [[NSUUID UUID] UUIDString];
        _objectId =[NSString MD5ForLower32Bate:[NSString stringWithFormat:@"%@%@",[NSString getTimeStamp],uuid]];
    }
    return self;
}

+ (NSString *)primaryKey{
    return @"objectId";
}

@end
