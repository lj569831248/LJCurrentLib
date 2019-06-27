//
//  NSString+LJRegex.h
//  HBLockTest
//
//  Created by Jon on 2018/10/10.
//  Copyright © 2018年 Jon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LJRegex)

#pragma mark 正则相关
+ (BOOL)checkMatch:(NSString *)string regex:(NSString *)regex;
// 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
// 正则匹配用户密码6-16位数字或字母组合
+ (BOOL)checkPassword:(NSString *) password;
//  正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName:(NSString *) userName;
// 正则匹配用户身份证号
+ (BOOL)checkIdCard:(NSString *) idCard;
// 正则匹配URL
+ (BOOL)checkURL:(NSString *) url;
// 匹配 Email
+ (BOOL)checkEmail:(NSString *)email;

// 验证码
+ (BOOL)checkVerificationCode:(NSString *)verificationCode;


- (BOOL)isMatchRegex:(NSString *)regex;

// 正则匹配手机号
- (BOOL)isTelNumber;
// 正则匹配用户密码6-16位数字或字母组合
- (BOOL)isPassword;
//  正则匹配用户姓名,20位的中文或英文
- (BOOL)isUserName;
// 正则匹配用户身份证号
- (BOOL)isIdCard;
// 正则匹配URL
- (BOOL)isURL;

//4位数字验证码
- (BOOL)isVerificationCode;
- (BOOL)isEmail;

@end
