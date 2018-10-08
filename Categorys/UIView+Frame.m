//
//  UIView+Frame.m
//  TimeDiary
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)originX {
    return self.frame.origin.x;
}

- (void)setOriginX:(CGFloat)originX {
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
    return;
}

- (CGFloat)originY {
    return self.frame.origin.y;
}

- (void)setOriginY:(CGFloat)originY {
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
    return;
}

- (CGFloat)rightX {
    return [self originX] + [self width];
}

- (void)setRightX:(CGFloat)rightX {
    CGRect frame = self.frame;
    frame.origin.x = rightX - [self width];
    self.frame = frame;
    return;
}

- (CGFloat)bottomY {
    return [self originY] + [self height];
}

- (void)setBottomY:(CGFloat)bottomY {
    CGRect frame = self.frame;
    frame.origin.y = bottomY - [self height];
    self.frame = frame;
    return;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
    return;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
    return;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    return;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    return;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
    return;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    return;
}

///< 移除此view上的所有子视图
- (void)removeAllSubviews {
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    while (self.subviews.count) {
        [self.subviews.lastObject removeFromSuperview];
    }
}
@end
