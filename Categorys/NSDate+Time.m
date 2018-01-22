//
//  NSDate+Time.m
//  FastThree
//
//  Created by Jon on 2018/1/3.
//  Copyright © 2018年 droi. All rights reserved.
//

#import "NSDate+Time.h"
#import "Defines.h"
#import "MyDefaults.h"
@implementation NSDate (Time)

- (NSString *)timeStamp{
    NSTimeInterval time = [self timeIntervalSince1970];
    long long int date = (long long int)(time * 1000 );
    return [NSString stringWithFormat:@"%lld",date];
}
- (NSString *)secondTimestamp{
    NSTimeInterval time = [self timeIntervalSince1970];
    long long int date = (long long int)time;
    return [NSString stringWithFormat:@"%lld",date];
}

+ (NSDate *)dateWithTimeStamp:(NSString *)timeStamp{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp.longLongValue / 1000];
    return date;
}

+ (NSDate *)dateFromFormatterDateString:(NSString *)formatterDate{
    return [self dateFromFormatterDateString:formatterDate formatter:[MY_DEFAULTS defaultDateFormat]];
}


+ (NSDate *)dateFromFormatterDateString:(NSString *)formatterDate formatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    return [dateFormatter dateFromString:formatterDate];
}


@end
