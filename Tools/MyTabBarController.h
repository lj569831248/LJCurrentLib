//
//  MyTabBarController.h
//  TickeTemplate
//
//  Created by Jon on 2017/11/17.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MyTabBarStyle) {
    MyTabBarStyleDefault,
    MyTabBarStyleCenterBtn,
};

@protocol MyTabBarDelegate <NSObject>
@required
- (void)didChickCenterButton:(UIButton *)button;
@end

@interface MyTabBarController : UITabBarController
@property (weak, nonatomic)id<MyTabBarDelegate> tabDelegate;

- (id)initWithStyle:(MyTabBarStyle)style;

@end
