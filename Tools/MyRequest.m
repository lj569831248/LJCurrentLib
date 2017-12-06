//
//  MyRequest.m
//  TimeDiary
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "MyRequest.h"
#import <AFNetworking/AFNetworking.h>
@implementation MyRequest
+ (void)requestGetWithUrl:(NSString *)urlString callback:(void (^)(NSURLResponse *response, id responseObject, NSError *error))callback{
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSMutableURLRequest *request  = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:nil error:nil];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:callback];
    [dataTask resume];
     
}
@end
