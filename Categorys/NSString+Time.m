//
//  NSString+Time.m
//  TimeDiary
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//
#import "Defines.h"
#import "MyDefaults.h"
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

+ (NSString*)getWeekDay:(NSString*)currentStr{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc]init];//实例化一个NSDateFormatter对象
    [dateFormat setDateFormat:@"yyyy-MM-dd"];//设定时间格式,要注意跟下面的dateString匹配，否则日起将无效
    NSDate*date =[dateFormat dateFromString:currentStr];
    NSArray*weekdays = [NSArray arrayWithObjects: [NSNull null],L(@"星期日"),L(@"星期一"),L(@"星期二"),L(@"星期三"),L(@"星期四"),L(@"星期五"),L(@"星期六"),nil];
    NSCalendar*calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone*timeZone = [NSTimeZone localTimeZone];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit =NSCalendarUnitWeekday;
    NSDateComponents*theComponents = [calendar components:calendarUnit fromDate:date];
    return[weekdays objectAtIndex:theComponents.weekday];
}

@end
