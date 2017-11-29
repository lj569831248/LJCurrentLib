//
//  MyDB.h
//  TickeTemplate
//
//  Created by Jon on 2017/11/21.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
FOUNDATION_EXPORT NSString* const QUERY_EQ;
FOUNDATION_EXPORT NSString* const QUERY_NEQ;

@interface MyDBQuery : NSObject

+ (MyDBQuery *)createByTableName:(NSString *)tableName;
- (MyDBQuery *)query:(NSString*)key opType:(NSString *)opType value:(NSString*)value;
- (MyDBQuery *)orderBy:(NSArray *)keys;
- (MyDBQuery *)asc:(BOOL)asc;

- (MyDBQuery *)limit:(int)limit;
- (MyDBQuery *)offset:(int)offset;

- (NSString *)selectSQL;
- (NSString *)deleteSQL;
@end

@interface MyDB : FMDatabase
/**
 用户数据库,存放在 Documents/DB
 */
+ (instancetype)standardUserDataBase;

/**
 缓存数据库,存放在 Library/Caches/DB
 */
+ (instancetype)standardCachesDataBase;

- (BOOL)createTableIfNotExists:(NSString *)tableName model:(Class)cls;
- (BOOL)deleteTable:(NSString *)tableName;
- (BOOL)updateTable:(NSString *)tableName model:(id)defaultModel;

- (BOOL)addModel:(id)model toTable:(NSString *)tableName;
- (NSArray *)selectByQuery:(MyDBQuery *)query model:(Class)cls;
- (BOOL)deleteByQuery:(MyDBQuery *)query;


+ (NSString *)userDataBasePath:(NSString *)option;
+ (NSString *)cachesDataBasePath:(NSString *)option;

@end


