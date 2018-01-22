//
//  NSString+Unicode.m
//  FastThree
//
//  Created by liaojun on 2017/11/29.
//  Copyright © 2017年 droi. All rights reserved.
//
#import <CommonCrypto/CommonCrypto.h>
#import "NSString+Unicode.h"

@implementation NSString (Unicode)
+(NSString *)MD5ForLower32Bate:(NSString *)str{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    return [digest lowercaseString];
}

#pragma mark - 32位 大写
+(NSString *)MD5ForUpper32Bate:(NSString *)str{
    //要进行UTF8的转码
    const char* input = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    
    return [digest uppercaseString];
}

#pragma mark - 16位 大写
+(NSString *)MD5ForUpper16Bate:(NSString *)str{
    NSString *md5Str = [self MD5ForUpper32Bate:str];
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}


#pragma mark - 16位 小写
+(NSString *)MD5ForLower16Bate:(NSString *)str{
    NSString *md5Str = [self MD5ForLower32Bate:str];
    NSString  *string;
    for (int i=0; i<24; i++) {
        string=[md5Str substringWithRange:NSMakeRange(8, 16)];
    }
    return string;
}
- (NSString *)base64Encode{
    NSData *encodeData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [encodeData base64EncodedStringWithOptions:0];
    return base64String;
}
- (NSString *)base64Decode{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return decodedString;
}


+ (NSString *)formatDBString:(NSString *)sqlText{
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"[" withString:@"/["];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"]" withString:@"/]"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"%" withString:@"/%"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"&" withString:@"/&"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"_" withString:@"/_"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"(" withString:@"/("];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@")" withString:@"/)"];
    return sqlText;
}

- (NSString *)formatDBString{
    NSString *sqlText = self;
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"/" withString:@"//"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"[" withString:@"/["];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"]" withString:@"/]"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"%" withString:@"/%"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"&" withString:@"/&"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"_" withString:@"/_"];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@"(" withString:@"/("];
    sqlText = [sqlText stringByReplacingOccurrencesOfString:@")" withString:@"/)"];
    return sqlText;
}
@end
