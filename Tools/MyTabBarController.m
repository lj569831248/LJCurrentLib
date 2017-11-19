//
//  MyTabBarController.m
//  TickeTemplate
//
//  Created by Jon on 2017/11/17.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "MyTabBarController.h"
#import "UIColor+Base.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    NSArray *settingInfo = [INFO_PLIST valueForKey:@"TabBarItems"];
    self.viewControllers = [self setupTabBarVC:settingInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSArray *)setupTabBarVC:(NSArray *)array{
    NSMutableArray *tabbarItmeArray = [[NSMutableArray alloc] init];
    for (NSDictionary *tabbarItmeDict in array) {
        NSString *title = [tabbarItmeDict valueForKey:@"title"];
        NSString *image = [tabbarItmeDict valueForKey:@"image"];
        NSString *selectedImage = [tabbarItmeDict valueForKey:@"selectedImage"];
        NSString *className = [tabbarItmeDict valueForKey:@"className"];
        NSString *color = [tabbarItmeDict valueForKey:@"color"];
        NSString *selectColor = [tabbarItmeDict valueForKey:@"selectColor"];
        UIViewController *vc = [[NSClassFromString(className) alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        vc.title = title;
        if (image) {
            UIImage *tabbarNormalImage = [UIImage imageNamed:image];
            tabbarNormalImage=[tabbarNormalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.image =tabbarNormalImage;
        }
        if (selectedImage) {
            UIImage *tabbarSelectedImage = [UIImage imageNamed:selectedImage];
            tabbarSelectedImage=[tabbarSelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
            nav.tabBarItem.selectedImage = tabbarSelectedImage;}
        if (color) {
            [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ColorFromHex:color]} forState:UIControlStateNormal];
        }
        if (selectColor) {
            [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ColorFromHex:selectColor]} forState:UIControlStateSelected];
        }

        [tabbarItmeArray addObject:nav];
    }
    return tabbarItmeArray;
}

- (void)setupNav{
    UIColor *baseColor = kColorFromRGBA(149, 0, 9, 1);
    [[UINavigationBar appearance] setBarTintColor:baseColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //全局隐藏返回按钮Title
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
}
@end
