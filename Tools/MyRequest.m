//
//  MyRequest.m
//  TimeDiary
//
//  Created by Jon on 2017/11/15.
//  Copyright © 2017年 droi. All rights reserved.
//
#import "Defines.h"
#import "MyRequest.h"
//#import <AFNetworking/AFNetworking.h>
@implementation MyRequest
//+ (void)requestGetWithUrl:(NSString *)urlString callback:(void (^)(NSURLResponse *response, id responseObject, NSError *error))callback{
//    
////    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
////    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    NSMutableURLRequest *request  = [[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:urlString parameters:nil error:nil];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
//    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:callback];
//    [dataTask resume];
//}

//Post 请求
+ (void)postRequestWithURL:(NSString *)URLString param:(NSData *)paramData  delegate:( id <NSURLSessionDelegate>)delegate completionHandler:(void (^)(NSData *  data, NSURLResponse *  response, NSError *  error))completionHandler{
    NSURL *url = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:paramData];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:delegate delegateQueue:queue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            SAFE_BLOCK(completionHandler,data,response,error);
            [session finishTasksAndInvalidate];
        });
    }];
    [dataTask resume];
}

//Get 请求
+ (void)getRequestWithURL:(NSString *)URLString  delegate:(id <NSURLSessionDelegate>)delegate completionHandler:(void (^)(NSData * data, NSURLResponse *  response, NSError * error))completionHandler{
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:delegate delegateQueue:queue];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            SAFE_BLOCK(completionHandler,data,response,error);
            [session finishTasksAndInvalidate];
        });
    }];
    [dataTask resume];
}
@end
