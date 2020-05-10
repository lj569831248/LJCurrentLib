//
//  UIViewController+Base.m
//  TimeDiary
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "UIViewController+Base.h"

@implementation UIViewController (Base)

+ (void)load{
    NSLog(@"UIViewController(Base)---load 替换presentViewController 为 hb_presentViewController 用来全屏present");
    [self replaceInstanceMethodWithOriginalSelector:@selector(presentViewController:animated:completion:) swizzledSelector:@selector(hb_presentViewController:animated:completion:)];
}

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


//iOS13 的present默认不是全屏覆盖样式 通过方法替换将样式统一为全屏覆盖
- (void)hb_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion{
    viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
    [self hb_presentViewController:viewControllerToPresent animated:flag completion:completion];
}



@end
