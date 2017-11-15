//
//  HUD.m
//  ruhang
//
//  Created by Jon on 2016/11/29.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "HUD.h"

@interface HUD ()

@end
@implementation HUD

static HUD *_instance = nil;

+ (void)instance{
    if (_instance == nil) {
        _instance = [self showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        _instance.bezelView.backgroundColor = [UIColor blackColor];
        _instance.bezelView.alpha = 0.8f;
        _instance.contentColor = [UIColor whiteColor];//将转圈和文字设置成白色
    }
}

+ (void)show{
    [self instance];
}

+ (void)showText:(NSString *)text{
    [self instance];
    _instance.mode = MBProgressHUDModeIndeterminate;
    _instance.label.text = text;
    _instance.label.numberOfLines = 0;
}

+ (void)showProgress:(CGFloat)progress{
    [self instance];
    dispatch_async(dispatch_get_main_queue(), ^{
        _instance.mode = MBProgressHUDModeDeterminate;
        _instance.progress = progress;
    });
}

+ (void)showProgress:(CGFloat)progress text:(NSString *)text{
    [self instance];
    dispatch_async(dispatch_get_main_queue(), ^{
        _instance.mode = MBProgressHUDModeDeterminate;
        _instance.progress = progress;
        _instance.label.text = text;
        _instance.label.numberOfLines = 0;
    });
}

+ (void)dismissAfterDelay:(NSTimeInterval)delay completion:(MBProgressHUDCompletionBlock)completionBlock{
    if (_instance) {
        _instance.completionBlock = completionBlock;
        [_instance hideAnimated:YES afterDelay:delay];
        _instance = nil;
    }
}

+ (void)dismissAfterDelay:(NSTimeInterval)delay {
    if (_instance) {
        [_instance hideAnimated:YES afterDelay:delay];
        _instance = nil;
    }
}

+ (void)dismissCompletion:(MBProgressHUDCompletionBlock)completionBlock{
    [self dismissAfterDelay:0.8 completion:completionBlock];
}

+ (void)dismiss{
    [self dismissAfterDelay:0.8];
}

@end
