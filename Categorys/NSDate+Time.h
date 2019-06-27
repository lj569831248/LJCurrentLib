//
//  NSDate+Time.h
//  FastThree
//
//  Created by Jon on 2018/1/3.
//  Copyright © 2018年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Time)

- (NSString *)timeStamp;
- (NSString *)secondTimestamp;

- (NSString *)formatterDate;
+ (NSDate *)dateWithTimeStamp:(NSString *)timeStamp;

+ (NSDate *)dateFromFormatterDateString:(NSString *)formatterDate;
+ (NSDate *)dateFromFormatterDateString:(NSString *)formatterDate formatter:(NSString *)formatter;


@end
