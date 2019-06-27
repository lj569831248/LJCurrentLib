//
//  HUD.h
//  ruhang
//
//  Created by Jon on 2016/11/29.
//  Copyright © 2016年 Droi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface HUD : MBProgressHUD
+ (void)show;

+ (void)showText:(NSString *)text;
+ (void)showFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

+ (void)showText:(NSString *)text delay:(NSTimeInterval)delay;
+ (void)showFormatDelay:(NSTimeInterval)delay format:(NSString *)format, ... ;

+ (void)showTextThenDismiss:(NSString *)text;
+ (void)showFormatThenDismiss:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

+ (void)showTextThenDismiss:(NSString *)text completion:(MBProgressHUDCompletionBlock)completionBlock;
+ (void)showFormatThenDismiss:(MBProgressHUDCompletionBlock)completionBlock format:(NSString *)format, ...;


+ (void)showTextAndLoding:(NSString *)text;
+ (void)showFormatAndLoding:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

+ (void)showProgress:(CGFloat)progress;
+ (void)showProgress:(CGFloat)progress text:(NSString *)text;
+ (void)showProgress:(CGFloat)progress format:(NSString *)format, ... ;

+ (void)dismiss;
+ (void)dismissAfterDelay:(NSTimeInterval)delay;
+ (void)dismissAfterDelay:(NSTimeInterval)delay completion:(MBProgressHUDCompletionBlock)completionBlock;
+ (void)dismissCompletion:(MBProgressHUDCompletionBlock)completionBlock;
@end
