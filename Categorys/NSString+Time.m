//
//  NSString+Time.m
//  TimeDiary
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "NSString+Time.h"

@implementation NSString (Time)

+ (NSString *)getTimeStamp{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)(time * 1000 );
    return [NSString stringWithFormat:@"%lld",date];
}

+ (NSString *)getSecondTimestamp{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    return [NSString stringWithFormat:@"%lld",date];
}

+ (NSString *)getFormatterDate:(NSString *)timeStamp{
    return [self getFormatterDate:timeStamp with:[MY_DEFAULTS defaultDateFormat]];
}

+ (NSString *)getFormatterDate:(NSString *)timeStamp with:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue] / 1000];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}

- (NSString *)getFormatterDate{
    return [NSString getFormatterDate:self];
}

- (NSString *)getFormatterDate:(NSString *)formatter{
    if (formatter == nil) {
        return [self getFormatterDate];
    }else{
        return [NSString getFormatterDate:self with:formatter];
    }
}
@end
