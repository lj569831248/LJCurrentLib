//
//  MyBaseViewController.m
//  FastThree
//
//  Created by Jon on 2017/12/1.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "MyBaseViewController.h"

@interface MyBaseViewController ()
@property (nonatomic,weak) UIView *networkErrorView;
@property (nonatomic,weak) UIView *errorImageView;
@property (nonatomic,weak) UIView *errorBackgroudView;
@end

@implementation MyBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIView *)createErrorBackgroundView{
    if (self.errorBackgroudView) {
        [self.errorBackgroudView removeFromSuperview];
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    self.errorBackgroudView = view;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    return view;
}

- (void)showErrorImage:(UIImage *)image{
    UIView *errorBackgroudView = [self createErrorBackgroundView];
    UIImageView *errorImageView = [[UIImageView alloc] init];
    [errorBackgroudView addSubview:errorImageView];
    self.errorImageView = errorImageView;

    errorImageView.image = image;
    errorImageView.backgroundColor = self.view.backgroundColor;
    if(!image){}
    [errorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(errorBackgroudView);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    NSLog(@"%@",self.errorBackgroudView);
}

- (void)showNetworkErrorView:(NSString *)errorMessage{
    UIView *errorBackgroudView = [self createErrorBackgroundView];
    UIView *networkErrorView = [[UIView alloc] init];
    networkErrorView.backgroundColor = self.view.backgroundColor;
    UILabel *errorMessageLabel = [UILabel new];
    errorMessageLabel.text = @"网络发生错误...";
    if(errorMessage){errorMessageLabel.text = errorMessage;}
    
    UIButton *retryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [retryButton setTitle:@"重新加载" forState:UIControlStateNormal];
    [retryButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    retryButton.layer.borderWidth = 1.0;
    retryButton.layer.borderColor = [UIColor blackColor].CGColor;
    [retryButton addTarget:self action:@selector(retryLoding) forControlEvents:UIControlEventTouchUpInside];
    
    [networkErrorView addSubview:retryButton];
    [networkErrorView addSubview: errorMessageLabel];
    [errorBackgroudView addSubview:networkErrorView];
    self.networkErrorView = networkErrorView;
    
    [networkErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [retryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(networkErrorView);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(80);
    }];
    [errorMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(networkErrorView);
        make.bottom.equalTo(retryButton.mas_top).offset(-40);
    }];
    
}

- (void)dismissNetworkErrorView:(void (^)())callback{
    [self.networkErrorView removeFromSuperview];
    SAFE_BLOCK(callback);
}
- (void)dismissErrorImageView:(void (^)())callback{
    [self.errorImageView removeFromSuperview];
    SAFE_BLOCK(callback);
}

- (void)dismissAllErrorView:(void (^)())callback{
    NSLog(@"%@",self.errorBackgroudView);
    [self.errorBackgroudView removeFromSuperview];
    SAFE_BLOCK(callback);
}

- (void)retryLoding{
    NSLog(@"BaseVC Retry");
}

#pragma mark - override

#pragma mark - getter / setter

#pragma mark - notification

#pragma mark - delegate dataSource protocol

#pragma mark - private


@end