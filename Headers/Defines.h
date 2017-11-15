//
//  Defines.h
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

//safe 相关
#define SAFE_BLOCK(block,...) if(block){block(__VA_ARGS__);}  //宏定义
#define kWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//系统 相关
#define L(key) NSLocalizedString(key, nil)
#define INFO_PLIST [[NSBundle mainBundle] infoDictionary]

#define IOS_VERSION [[UIDevice currentDevice].systemVersion floatValue]
#define ROOT_VC [[UIApplication sharedApplication] keyWindow].rootViewController
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

#define URL(A) [NSURL URLWithString:A]
#define FILE_URL(A) [NSURL fileURLWithPath:A]
//color相关
#define kRandomColor [UIColor colorWithRed:(arc4random()% 255)/255.0 green:(arc4random()%255)/255.0 blue:(arc4random()%255)/255.0 alpha:1]
#define kColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >> 8))/255.0 blue:((s & 0xFF))/255.0 alpha:1.0]
#define kBaseColor kColorFromHex(0X1296db)
#define kColorFromHexA(s, a) [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s & 0xFF00) >> 8))/255.0 blue:((s & 0xFF))/255.0 alpha:a]
#define kColorFromRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#endif /* Defines_h */
