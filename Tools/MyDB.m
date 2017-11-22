//
//  MyDB.m
//  TickeTemplate
//
//  Created by Jon on 2017/11/21.
//  Copyright © 2017年 droi. All rights reserved.
//  数据库相关 没有用到就删掉

#import "MyDB.h"
@implementation MyDB
NSString *const QUERY_EQ        = @"=";
NSString *const QUERY_NEQ       = @"!=";

static NSString *userDBName   = @"UserDB.db";
static NSString *cachesDBName = @"CachesDB.db";

static MyDB *userDataBase   = nil;
static MyDB *cachesDataBase = nil;

+ (instancetype)standardUserDataBase{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dbPath = [self userDataBasePath:userDBName];
        NSLog(@"UserDBPath:%@",dbPath);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:dbPath]){
            [fileManager createFileAtPath:dbPath contents:nil attributes:nil];
        }
        userDataBase = [self databaseWithPath:dbPath];
    });
    return userDataBase;
}

+ (instancetype)standardCachesDataBase{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dbPath = [self cachesDataBasePath:cachesDBName];
        NSLog(@"cachesDBPath:%@",dbPath);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if(![fileManager fileExistsAtPath:dbPath]){
            [fileManager createFileAtPath:dbPath contents:nil attributes:nil];
        }
        userDataBase = [self databaseWithPath:dbPath];
    });
    return userDataBase;
}

- (BOOL)createTableIfNotExists:(NSString *)tableName model:(Class)cls{
    if ([self open] && cls) {
        NSArray *ivarNamesAndTypes = [cls getIvarNamesAndTypes];
        NSMutableString *keyValueStr = [[NSMutableString alloc] init];
        for (NSDictionary *dict in ivarNamesAndTypes) {
            NSString *type = [dict valueForKey:@"type"];
            NSString *name = [dict valueForKey:@"name"];
            [keyValueStr appendString:name];
            // 目前 NSNumber 类型也用 TEXT, 后期再添加不同类型
            if ([type isEqualToString:@"NSString"]) {
                [keyValueStr appendFormat:@" TEXT"];
            }else if ([type isEqualToString:@"NSNumber"]){
                [keyValueStr appendFormat:@" TEXT"];
            }else{
                [keyValueStr appendFormat:@" TEXT"];
            }
            [keyValueStr appendString:@","];
        }
        [keyValueStr deleteCharactersInRange:NSMakeRange(keyValueStr.length - 1, 1)];
        NSString *sqlStr = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@(%@)",tableName,keyValueStr];
        NSLog(@"sql:%@",sqlStr);
        BOOL result = [self executeUpdate:sqlStr];
        return result;
    }
        return NO;
}

- (BOOL)addModel:(id)model toTable:(NSString *)tableName{
    if ([self open] && model) {
        NSArray *ivarNamesAndTypes = [[model class] getIvarNamesAndTypes];
        NSMutableString *nameStr = [[NSMutableString alloc] init];
        NSMutableString *valueStr = [[NSMutableString alloc] init];
        for (NSDictionary *dict in ivarNamesAndTypes) {
            NSString *name = [dict valueForKey:@"name"];
            [nameStr appendFormat:@"%@,",name];
            id value = [model valueForKey:name];
            if (value) {
                [valueStr appendFormat:@"'%@',",value];
            }else{
                [valueStr appendFormat:@"NULL,"];
            }
        }
        [nameStr deleteCharactersInRange:NSMakeRange(nameStr.length - 1, 1)];
        [valueStr deleteCharactersInRange:NSMakeRange(valueStr.length - 1, 1)];
        NSString *sqlStr = [NSString stringWithFormat:@"INSERT INTO %@ (%@) VALUES (%@)",tableName,nameStr,valueStr];
        BOOL result = [self executeUpdate:sqlStr];
        return result;
    }
    return NO;
}

- (BOOL)deleteByQuery:(MyDBQuery *)query{
    if ([self open] && query){
        BOOL result = [self executeUpdate:query.deleteSQL];
        return result;
    }
    return NO;
}

- (NSArray *)selectByQuery:(MyDBQuery *)query model:(Class)cls{
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    if ([self open] && cls && query) {
        FMResultSet * resultSet = [self executeQuery:query.selectSQL];
        NSArray *ivarNamesAndTypes = [cls getIvarNamesAndTypes];
        while ([resultSet next]) {
            id model = [[cls alloc] init];
            NSMutableDictionary *keyValueDict = [[NSMutableDictionary alloc] init];
            for (NSDictionary *dict in ivarNamesAndTypes) {
                NSString *type = [dict valueForKey:@"type"];
                NSString *name = [dict valueForKey:@"name"];
                
                NSString *dbValue = [resultSet stringForColumn:name];
                
                //对不同的数据类型做处理 目前我们只有做了字符串类型
                //统一的存进去都为字符串,取出来的时候再通过字符串转换值
                if ([type isEqualToString:@"NSNumber"]) {
                    
                }
                
                [keyValueDict setValue:dbValue forKey:name];
            }
            [model setValuesForKeysWithDictionary:keyValueDict];
            [resultArray addObject:model];
        }
    }
    return resultArray;
}

+ (NSString *)userDataBasePath:(NSString *)option{
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [documentsPath stringByAppendingPathComponent:@""];
    if (option) {
        dbPath = [dbPath stringByAppendingPathComponent:option];
    }
    return dbPath;
}

+ (NSString *)cachesDataBasePath:(NSString *)option{
    NSString *cachesPath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    NSString *dbPath = [cachesPath stringByAppendingPathComponent:@""];
    if (option) {
        dbPath = [dbPath stringByAppendingPathComponent:option];
    }
    return dbPath;
}

@end

@interface MyDBQuery ()
@property (copy, nonatomic)NSString *tableName;
@property (copy, nonatomic)NSMutableArray *statement;

@end

@implementation MyDBQuery

+ (MyDBQuery *)createByTableName:(NSString *)tableName{
    if (tableName == nil) {
        return nil;
    }
    MyDBQuery *query = [[MyDBQuery alloc] init];
    query.tableName = tableName;
    return query;
}

- (NSMutableArray *)statement{
    if (_statement == nil) {
        _statement = [[NSMutableArray alloc] init];
    }
    return _statement;
}

- (MyDBQuery *)query:(NSString*)key opType:(NSString *)opType value:(NSString*)value{
    NSString *statement = [NSString stringWithFormat:@"%@ %@ '%@'",key,opType,value];
    [self.statement addObject:statement];
    return self;
}

- (NSString *)selectSQL{
    NSMutableString *sqlStr = [[NSMutableString alloc] initWithFormat:@"SELECT * FROM %@",self.tableName];
    if (self.statement.count > 0) {
        [sqlStr appendString:@" WHERE"];
        for (NSString *statementStr in self.statement) {
            [sqlStr appendString:@" "];
            [sqlStr appendString:statementStr];
        }
    }
    return [sqlStr copy];
}

- (NSString *)deleteSQL{
    NSMutableString *sqlStr = [[NSMutableString alloc] initWithFormat:@"DELETE FROM %@",self.tableName];
    if (self.statement.count > 0) {
        [sqlStr appendString:@" WHERE"];
        for (NSString *statementStr in self.statement) {
            [sqlStr appendString:@" "];
            [sqlStr appendString:statementStr];
        }
    }
    return [sqlStr copy];
}

@end
