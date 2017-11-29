//
//  NSString+Time.h
//  TimeDiary
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Time)


/**
 获取时间戳
 @return 13位 精确到毫秒
 */
+ (NSString *)getTimeStamp;

/**
 获取时间戳
 @return 10位 精确到秒
 */
+ (NSString *)getSecondTimestamp;

+ (NSString *)getFormatterDate:(NSString *)timeStamp;

- (NSString *)getFormatterDate;
@end
