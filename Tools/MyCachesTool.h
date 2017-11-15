//
//  MyCachesTool.h
//  WeeXTemplate
//
//  Created by Jon on 2017/11/2.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCachesTool : NSObject

+ (float)getCacheSize;
+ (void)clearCaches:(void (^)(BOOL))callback;
+ (NSString *)getCachePath;

+ (long long) fileSizeAtPath:(NSString*) filePath;
+ (float) folderSizeAtPath:(NSString*) folderPath;
+(BOOL)clearCache:(NSString *)path;



@end
