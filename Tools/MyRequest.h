//
//  MyRequest.h
//  TimeDiary
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRequest : NSObject
//+ (void)requestGetWithUrl:(NSString *)urlString callback:(void (^)(NSURLResponse *response, id responseObject, NSError *error))callback;

+ (void)getRequestWithURL:(NSString *)URLString  delegate:(id <NSURLSessionDelegate>)delegate completionHandler:(void (^)(NSData * data, NSURLResponse *  response, NSError * error))completionHandler;

+ (void)postRequestWithURL:(NSString *)URLString param:(NSData *)paramData  delegate:( id <NSURLSessionDelegate>)delegate completionHandler:(void (^)(NSData *  data, NSURLResponse *  response, NSError *  error))completionHandler;
@end
