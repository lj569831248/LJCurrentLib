//
//  MyTabBar.m
//  FastThree
//
//  Created by Jon on 2017/11/27.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "MyTabBar.h"

@interface MyTabBar ()

@end

@implementation MyTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加中间按钮到tabBar上
        [self addSubview:self.centerBtn];
    }
    return self;
}

- (UIButton *)centerBtn{
    if (_centerBtn == nil) {
        _centerBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        [_centerBtn setImage:[UIImage imageNamed:@"CenterIcon"] forState:UIControlStateNormal];
    }
    return _centerBtn;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    // 把 tabBarButton 取出来（把 tabBar 的 subViews 打印出来就明白了）
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    CGFloat centerBtnWidth = CGRectGetWidth(self.centerBtn.frame);
    CGFloat centerBtnHeight = CGRectGetHeight(self.centerBtn.frame);
    // 设置中间按钮的位置，居中，凸起一丢丢
    if (kDevice_Is_iPhoneX) {
        self.centerBtn.center = CGPointMake(barWidth / 2, barHeight - centerBtnHeight/2 - 40);

    }else{
        self.centerBtn.center = CGPointMake(barWidth / 2, barHeight - centerBtnHeight/2 - 5);
    }
    // 重新布局其他 tabBarItem
    // 平均分配其他 tabBarItem 的宽度
    CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarButtonArray.count;
    // 逐个布局 tabBarItem，修改 UITabBarButton 的 frame
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = view.frame;
        if (idx >= tabBarButtonArray.count / 2) {
            // 重新设置 x 坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = idx * barItemWidth + centerBtnWidth;
        } else {
            frame.origin.x = idx * barItemWidth;
        }
        // 重新设置宽度
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
    // 把中间按钮带到视图最前面
    [self bringSubviewToFront:self.centerBtn];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在 tabbar 里面直接返回
    if (result) {
        return result;
    }
    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
    for (UIView *subview in self.subviews) {
        // 把这个坐标从tabbar的坐标系转为 subview 的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在 subView 里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}

@end
