//
//  MyCustomPresentationController.h
//  LJAnimation
//
//  Created by Jon on 2017/3/13.
//  Copyright © 2017年 Droi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCustomPresentationController : UIPresentationController<UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIView *backgroudView;

@end
