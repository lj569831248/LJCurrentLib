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
FOUNDATION_EXPORT NSString* const QUERY_CONTAINS;

FOUNDATION_EXPORT NSString* const QUERY_LIKE;

@interface MyDBQuery : NSObject
@property (copy, nonatomic, readonly)NSString *tableName;
+ (MyDBQuery *)createByTableName:(NSString *)tableName;
- (MyDBQuery *)query:(NSString*)key opType:(NSString *)opType value:(id)value;
- (MyDBQuery *)AND:(NSString*)key opType:(NSString *)opType value:(id)value;
- (MyDBQuery *)OR:(NSString*)key opType:(NSString *)opType value:(id)value;

- (MyDBQuery *)orderBy:(NSArray *)keys;
- (MyDBQuery *)asc:(BOOL)asc;

- (MyDBQuery *)limit:(int)limit;
- (MyDBQuery *)offset:(int)offset;

- (NSString *)selectSQL;
- (NSString *)deleteSQL;
- (NSString *)updateSQL:(id)model;

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

/**
 创建表
 @param tableName 表名
 @param cls 用于创建表的 Model 类
 @return 结果
 */
- (BOOL)createTableIfNotExists:(NSString *)tableName model:(Class)cls;

/**
 删除表
 @param tableName 表名
 @return 结果
 */
- (BOOL)deleteTable:(NSString *)tableName;

/**
 数据库更新,为数据库表添加字段
 @param tableName 表名
 @param defaultModel 更新后的 Model, 如果想为新增字段添加默认值 请在 model 中赋值
 @return 结果
 */
- (BOOL)updateTable:(NSString *)tableName model:(id)defaultModel;


/**
 添加一条数据
 @param model 数据 model
 @param tableName  表名
 @return 结果
 */
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
 @param query 条件
 @param model 需要更新成这个model 的数据
 @return 结果
 */
- (BOOL)updateByQuery:(MyDBQuery *)query model:(id)model;


/**
 查询符合 query 添加的数据
 @param query 条件
 @param cls 用于接收数据的 model class
 @return  数据数组 cls 类型
 */
- (NSArray *)selectByQuery:(MyDBQuery *)query model:(Class)cls;

/**
 删除符合 query 的数据
 @param query 条件
 @return 结果
 */
- (BOOL)deleteByQuery:(MyDBQuery *)query;

- (BOOL)deleteModle:(id<MyDBModelDelegate>)model tableName:(NSString *)tableName;


+ (NSString *)userDataBasePath:(NSString *)option;
+ (NSString *)cachesDataBasePath:(NSString *)option;

@end


