//
//  MyTabBarController.m
//  TickeTemplate
//
//  Created by Jon on 2017/11/17.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "MyTabBarController.h"
#import "UIColor+Base.h"
#import "MyTabBar.h"
@interface MyTabBarController ()
@property (assign, nonatomic)MyTabBarStyle style;
@end

@implementation MyTabBarController

- (id)initWithStyle:(MyTabBarStyle)style{
    if(self = [super init]){
        _style = style;
        if (_style == MyTabBarStyleCenterBtn) {
            MyTabBar *tabBar = [[MyTabBar alloc] init];
            [tabBar.centerBtn addTarget:self action:@selector(clickCenterBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self setValue:tabBar forKey:@"tabBar"];
        }
        NSArray *settingInfo = [INFO_PLIST valueForKey:@"TabBarItems"];
        self.viewControllers = [self setupTabBarVC:settingInfo];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        vc.title = L(title);
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

- (void)clickCenterBtn:(id)sender{
    if (self.tabDelegate && [self.tabDelegate respondsToSelector:@selector(didChickCenterButton:)]) {
        [self.tabDelegate didChickCenterButton:sender];
    }
}


@end
