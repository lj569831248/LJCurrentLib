
//
//  MyDefaults.h
//  FastThree
//
//  Created by Jon on 2017/11/29.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyDefaults : NSObject
@property (copy, nonatomic)NSString *defaultDateFormat;

+(id)standardDefaults;

@end
