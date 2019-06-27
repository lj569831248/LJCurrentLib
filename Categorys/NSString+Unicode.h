//
//  NSString+Unicode.h
//  FastThree
//
//  Created by liaojun on 2017/11/29.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Unicode)

/**
 *  MD5, 32位 小写
 */
+(NSString *)MD5ForLower32Bate:(NSString *)str;

/**
 *  MD5, 32位 大写
 */
+(NSString *)MD5ForUpper32Bate:(NSString *)str;

/**
 *  MD5, 16位 小写
 */
+(NSString *)MD5ForLower16Bate:(NSString *)str;

/**
 *  MD5, 16位 大写
 */
+(NSString *)MD5ForUpper16Bate:(NSString *)str;

- (NSString *)base64Encode;
- (NSString *)base64Decode;


+ (NSString *)formatDBString:(NSString *)sqlText;

- (NSString *)formatDBString;

@end
