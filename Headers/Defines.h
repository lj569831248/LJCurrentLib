//
//  Defines.h
//  TimeDiary
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//

#ifndef Defines_h
#define Defines_h

#define SAFE_BLOCK(block,...) if(block){block(__VA_ARGS__);}  //宏定义
#define kWeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

#define L(key) NSLocalizedString(key, nil)

#define INFO_PLIST [[NSBundle mainBundle] infoDictionary]
#define ROOT_VC [[UIApplication sharedApplication] keyWindow].rootViewController

#endif /* Defines_h */
