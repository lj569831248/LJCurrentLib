//
//  LJDeviceTool.h
//  HBSkyeye
//
//  Created by Jon on 2019/4/22.
//  Copyright © 2019 jingyao. All rights reserved.
//
             
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LJDeviceTool : NSObject


/**
 强制改变屏幕方向
 @param orientation UIInterfaceOrientation
 */
+ (void)interfaceOrientation:(UIInterfaceOrientation) orientation;

@end

NS_ASSUME_NONNULL_END
