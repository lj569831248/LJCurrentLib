//
//  UIViewController+Base.m
//  TimeDiary
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "UIViewController+Base.h"

@implementation UIViewController (Base)

//分类中重写dealloc方法可能会引起有些错误 原因是其他的子类中如果重写了dealloc
//- (void)dealloc{
//    NSLog(@"%@ delloc",[self.class description]);
//}

- (UIStatusBarStyle)preferredStatusBarStyle{
#ifdef USE_LIGHT_STATUS_BAR
    return UIStatusBarStyleLightContent;
#else
    return UIStatusBarStyleDefault;
#endif
}
@end
