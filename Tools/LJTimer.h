//
//  LJTimer.h
//  HBLockTest
//
//  Created by Jon on 2018/9/19.
//  Copyright © 2018年 Jon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LJTimer : NSObject

+ (void)dispatchTimer:(id)target timeInterval:(double)timeInterval handler:(void(^)(dispatch_source_t timer))handler;

@end
