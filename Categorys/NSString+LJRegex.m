//
//  NSString+LJRegex.m
//  HBLockTest
//
//  Created by Jon on 2018/10/10.
//  Copyright © 2018年 Jon. All rights reserved.
//

#import "NSString+LJRegex.h"
static NSString *const kPhoneNumberRegex = @"^1+[3578]+\\d{9}";
static NSString *const kPasswordRegex = @"^[\\w.]{6,16}$";
static NSString *const kUserNameRegex = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
static NSString *const kIdCardRegex = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
static NSString *const kURLRegex = @"^[0-9A-Za-z]{1,50}";
static NSString *const kVerificationCodeRegex =  @"^[0-9]{4}$";
static NSString *const kEmailRegex =  @"^[a-z0-9]+([._\\-]*[a-z0-9])*@([a-z0-9]+[-a-z0-9]*[a-z0-9]+.){1,63}[a-z0-9]+$";

@implementation NSString (LJRegex)

+ (BOOL)checkMatch:(NSString *)string regex:(NSString *)regex{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

+ (BOOL)checkTelNumber:(NSString *) telNumber{
    return [self checkMatch:telNumber regex:kPhoneNumberRegex];
}

+ (BOOL)checkPassword:(NSString *) password{
    return [self checkMatch:password regex:kPasswordRegex];
}

+ (BOOL)checkUserName : (NSString *) userName{
    return [self checkMatch:userName regex:kUserNameRegex];
}

+ (BOOL)checkIdCard: (NSString *) idCard{
    return [self checkMatch:idCard regex:kIdCardRegex];
}

+ (BOOL)checkURL : (NSString *) url{
    return [self checkMatch:url regex:kURLRegex];
}

+ (BOOL)checkEmail:(NSString *)email{
    return [self checkMatch:email regex:kEmailRegex];
}

// 验证码
+ (BOOL)checkVerificationCode:(NSString *)verificationCode{
    return [self checkMatch:verificationCode regex:kVerificationCodeRegex];
}

- (BOOL)isMatchRegex:(NSString *)regex{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

// 正则匹配手机号
- (BOOL)isTelNumber{
    return [self isMatchRegex:kPhoneNumberRegex];
}
// 正则匹配用户密码6-18位数字或字母组合
- (BOOL)isPassword{
    
    return [self isMatchRegex:kPasswordRegex];
}
//  正则匹配用户姓名,20位的中文或英文
- (BOOL)isUserName{
    return [self isMatchRegex:kUserNameRegex];
}
// 正则匹配用户身份证号
- (BOOL)isIdCard{
    return [self isMatchRegex:kIdCardRegex];
}

// 正则匹配URL
- (BOOL)isURL{
    return [self isMatchRegex:kURLRegex];
}

- (BOOL)isVerificationCode{
    return [self isMatchRegex:kVerificationCodeRegex];
}

- (BOOL)isEmail{
    return [self isMatchRegex:kEmailRegex];
}

@end
