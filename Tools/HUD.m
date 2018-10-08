//
//  HUD.m
//  ruhang
//
//  Created by Jon on 2016/11/29.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import "HUD.h"
#import "UIApplication+Visible.h"
@interface HUD ()

@end
@implementation HUD

static const NSTimeInterval kHUDDefaultDelayTime = 1.5;
static HUD *_instance = nil;

+ (void)instance{
    if (_instance == nil) {
        _instance = [self showHUDAddedTo:[UIApplication sharedApplication].visibleViewController.view animated:YES];
        _instance.bezelView.backgroundColor = [UIColor blackColor];
        _instance.bezelView.alpha = 0.8f;
        _instance.contentColor = [UIColor whiteColor];//将转圈和文字设置成白色
    }
}

+ (void)show{
    [self instance];
}

+ (void)showText:(NSString *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self instance];
        _instance.mode = MBProgressHUDModeText;
        _instance.animationType = MBProgressHUDAnimationZoom;
        _instance.label.text = text;
        _instance.label.numberOfLines = 0;
    });
}

+ (void)showFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2){
    va_list args;
    va_start(args, format);
    NSString *text = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self showText:text];
}

+ (void)showText:(NSString *)text delay:(NSTimeInterval)delay{
    [self showText:text];
    [self dismissAfterDelay:delay];
}

+ (void)showFormatDelay:(NSTimeInterval)delay format:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *text = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self showText:text delay:delay];
}

+ (void)showTextAndLoding:(NSString *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
    [self instance];
    _instance.mode = MBProgressHUDModeIndeterminate;
    _instance.animationType = MBProgressHUDAnimationZoom;
    _instance.label.text = text;
    _instance.label.numberOfLines = 0;
    });

}

+ (void)showFormatAndLoding:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2){
    va_list args;
    va_start(args, format);
    NSString *text = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self showTextAndLoding:text];
}

+ (void)showTextThenDismiss:(NSString *)text{
    [self showText:text delay:kHUDDefaultDelayTime];
}

+ (void)showFormatThenDismiss:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2){
    va_list args;
    va_start(args, format);
    NSString *text = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self showTextThenDismiss:text];
}

+ (void)showProgress:(CGFloat)progress{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self instance];
        _instance.mode = MBProgressHUDModeDeterminate;
        _instance.progress = progress;
    });
}

+ (void)showProgress:(CGFloat)progress text:(NSString *)text{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self instance];
        _instance.mode = MBProgressHUDModeDeterminate;
        _instance.progress = progress;
        _instance.label.text = text;
        _instance.label.numberOfLines = 0;
    });
}

+ (void)showProgress:(CGFloat)progress format:(NSString *)format, ... {
    va_list args;
    va_start(args, format);
    NSString *text = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self showProgress:progress text:text];
}

+ (void)dismissAfterDelay:(NSTimeInterval)delay completion:(MBProgressHUDCompletionBlock)completionBlock{
    dispatch_async(dispatch_get_main_queue(), ^{
    if (_instance) {
        _instance.completionBlock = completionBlock;
        [_instance hideAnimated:YES afterDelay:delay];
        _instance = nil;
    }
    });
}

+ (void)dismissAfterDelay:(NSTimeInterval)delay {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_instance) {
            [_instance hideAnimated:YES afterDelay:delay];
            _instance = nil;
        }
    });
}

+ (void)dismissCompletion:(MBProgressHUDCompletionBlock)completionBlock{
    [self dismissAfterDelay:kHUDDefaultDelayTime completion:completionBlock];
}

+ (void)dismiss{
    [self dismissAfterDelay:kHUDDefaultDelayTime];
}

+ (void)showTextThenDismiss:(NSString *)text completion:(MBProgressHUDCompletionBlock)completionBlock{
    [self showText:text];
    [self dismissCompletion:completionBlock];
}

+ (void)showFormatThenDismiss:(MBProgressHUDCompletionBlock)completionBlock format:(NSString *)format, ...{
    va_list args;
    va_start(args, format);
    NSString *text = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    [self showText:text];
    [self dismissCompletion:completionBlock];
}


@end
