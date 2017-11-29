//
//  MyDB.h
//  TickeTemplate
//
//  Created by Jon on 2017/11/21.
//  Copyright © 2017年 droi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
#import "MyDBModel.h"
FOUNDATION_EXPORT NSString* const QUERY_EQ;
FOUNDATION_EXPORT NSString* const QUERY_NEQ;

@interface MyDBQuery : NSObject
@property (copy, nonatomic, readonly)NSString *tableName;
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


/**
 更新某条数据
 @param model 一般这个数据是从数据库中查询下来之后需要做更新的数据,需要遵守MyDBModelDelegate,因为需要更加主键查询
 @param tableName 表名
 @return 结果
 */
- (BOOL)updateModel:(id<MyDBModelDelegate>)model toTable:(NSString *)tableName;

/**
 更新符合 query 添加的所有数据
 @param model 需要更新成这个model 的数据
 @param query 条件
 @return 结果
 */
- (BOOL)updateModel:(id)model byQuery:(MyDBQuery *)query;

- (NSArray *)selectByQuery:(MyDBQuery *)query model:(Class)cls;
- (BOOL)deleteByQuery:(MyDBQuery *)query;


+ (NSString *)userDataBasePath:(NSString *)option;
+ (NSString *)cachesDataBasePath:(NSString *)option;

@end


