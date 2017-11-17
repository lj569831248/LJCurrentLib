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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTabBarVC:(NSArray *)array{
    UIColor *baseColor = kColorFromRGBA(149, 0, 9, 1);
    [[UINavigationBar appearance] setBarTintColor:baseColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //全局隐藏返回按钮Title
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
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
        if (image) { nav.tabBarItem.image = IMAGE(image);}
        if (selectedImage) { nav.tabBarItem.selectedImage = IMAGE(selectedImage);}
        if (color) {
            [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ColorFromHex:color]} forState:UIControlStateNormal];
        }
        if (selectColor) {
            [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor ColorFromHex:selectColor]} forState:UIControlStateSelected];
        }
        [tabbarItmeArray addObject:nav];
    }
}

@end
