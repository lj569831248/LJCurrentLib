//
//  UINavigationController+Base.m
//  ruhang
//
//  Created by Jon on 2016/11/23.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "UINavigationController+Base.h"
#import "NSObject+Base.h"

@implementation UINavigationController (Base)

+ (void)load{
    NSLog(@"UINavigationController(Base)---load 替换pushViewController 为 pushViewControllerAndHideBottomBar 用来push隐藏tabbar");
    [self replaceInstanceMethodWithOriginalSelector:@selector(pushViewController:animated:) swizzledSelector:@selector(pushViewControllerAndHideBottomBar:animated:)];
}


- (UIViewController *)childViewControllerForStatusBarStyle{
    return self.topViewController;
}

- (void)pushViewControllerAndHideBottomBar:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = YES;
    [self pushViewControllerAndHideBottomBar:viewController animated:animated];
}

@end
