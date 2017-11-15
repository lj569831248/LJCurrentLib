//
//  MyRequest.h
//  TimeDiary
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRequest : NSObject
+ (void)requestGetWithUrl:(NSString *)urlString callback:(void (^)(NSURLResponse *response, id responseObject, NSError *error))callback;
@end
