//
//  MyCachesTool.m
//  WeeXTemplate
//
//  Created by Jon on 2017/11/2.
//  Copyright © 2017年 droi. All rights reserved.
//

#import "MyCachesTool.h"
#import "MySandboxPath.h"
@implementation MyCachesTool

+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil]  fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager   defaultManager];
    if (![manager  fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

#pragma mark - 清除缓存的方法
+(BOOL)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            if(![fileManager removeItemAtPath:absolutePath error:nil]){
                return NO;
            }
        }
    }
    return YES;
}

+ (void)clearCaches:(void (^)(BOOL))callback{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        BOOL result = [self clearCache:[MySandboxPath cachesPath:nil]];
        dispatch_async(dispatch_get_main_queue(), ^{
            SAFE_BLOCK(callback,result);
        });
    });
}

+ (float)getCacheSize{
   return  [self folderSizeAtPath:[MySandboxPath cachesPath:nil]];
}

@end
