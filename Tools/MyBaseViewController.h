//
//  MyBaseViewController.h
//  FastThree
//
//  Created by Jon on 2017/12/1.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyBaseViewController : UIViewController
/**
 显示、隐藏网络错误页面
 @param errorMessage 如果需要自己的 errorMessage 请加上
 */
- (void)showNetworkErrorView:(NSString *)errorMessage;
- (void)dismissNetworkErrorView:(void (^)())callback;

- (void)showErrorImage:(UIImage *)image;
- (void)dismissAllErrorView:(void (^)())callback;

- (void)retryLoding;
@end
