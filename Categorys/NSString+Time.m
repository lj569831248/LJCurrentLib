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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp integerValue] / 1000];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}
@end
