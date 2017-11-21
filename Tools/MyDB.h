//
//  MyDB.h
//  TickeTemplate
//
//  Created by Jon on 2017/11/21.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
@interface MyDB : FMDatabase

/**
 用户数据库,存放在 Documents/DB
 */
+ (instancetype)standardUserDataBase;

/**
 缓存数据库,存放在 Library/Caches/DB
 */
+ (instancetype)standardCatchsDataBase;

+ (NSString *)userDataBasePath:(NSString *)option;
+ (NSString *)catchsDataBasePath:(NSString *)option;

@end
