//
//  MyDB.m
//  TickeTemplate
//
//  Created by Jon on 2017/11/21.
//  Copyright © 2017年 droi. All rights reserved.
//  数据库相关 没有用到就删掉

#import "MyDB.h"
@implementation MyDB

static NSString *userDBName   = @"UserDB.db";
static NSString *catchsDBName = @"CatchsDB.db";

static MyDB *userDataBase   = nil;
static MyDB *catchsDataBase = nil;

+ (instancetype)standardUserDataBase{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dbPath = [self userDataBasePath:userDBName];
        NSLog(@"UserDBPath:%@",dbPath);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:dbPath]){
            [fileManager createFileAtPath:dbPath contents:nil attributes:nil];
        }
        userDataBase = (MyDB *)[FMDatabase databaseWithPath:dbPath];
        if ([userDataBase open]){
            [userDataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS MyTable(Key text,Value text)"];
            [userDataBase commit];
        }
    });
    return userDataBase;
}

+ (instancetype)standardCatchsDataBase{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dbPath = [self catchsDataBasePath:catchsDBName];
        NSLog(@"CatchsDBPath:%@",dbPath);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:dbPath]){
            [fileManager createFileAtPath:dbPath contents:nil attributes:nil];
        }
        userDataBase = (MyDB *)[FMDatabase databaseWithPath:dbPath];
    });
    return userDataBase;
}

- (void)createTableIfNotExists:(NSString *)tableName model:(Class)class{
    
}

+ (NSString *)userDataBasePath:(NSString *)option{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [documentsPath stringByAppendingPathComponent:@"DB"];
    if (option) {
        dbPath = [dbPath stringByAppendingPathComponent:option];
    }
    return dbPath;
}

+ (NSString *)catchsDataBasePath:(NSString *)option{
    NSString *cachesPath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [cachesPath stringByAppendingPathComponent:@"DB"];
    if (option) {
        dbPath = [dbPath stringByAppendingPathComponent:option];
    }
    return dbPath;
}

@end
