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
NSString *const QUERY_LIKE      = @"LIKE";
NSString *const QUERY_CONTAINS  = @"CONTAINS";

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
        NSString *primaryKey = nil;
        //遵守了MyDBModelDelegate协议 且实现了方法,可以为其添加主键
        if ([cls conformsToProtocol:@protocol(MyDBModelDelegate)] && [cls respondsToSelector:@selector(primaryKey)]) {
            primaryKey = [cls primaryKey];
        }
        NSArray *ivarNamesAndTypes = [cls getIvarNamesAndTypes];
        NSMutableString *keyValueStr = [[NSMutableString alloc] init];
        for (NSDictionary *dict in ivarNamesAndTypes) {
            NSString *type = [dict valueForKey:@"type"];
            NSString *name = [dict valueForKey:@"name"];
            [keyValueStr appendString:name];
            // 目前 NSNumber 基础数据类型 类型也用 TEXT, 后期再添加不同类型
            if ([type isEqualToString:@"NSString"]) {
                [keyValueStr appendFormat:@" TEXT"];
            }else if ([type isEqualToString:@"NSNumber"]){
                [keyValueStr appendFormat:@" TEXT"];
            }else{
                [keyValueStr appendFormat:@" TEXT"];
            }
            if (primaryKey && [primaryKey isEqualToString:name]) {
                [keyValueStr appendFormat:@" PRIMARY KEY NOT NULL"];
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

- (BOOL)updateTable:(NSString *)tableName model:(id)defaultModel{
    if ([self open] && defaultModel) {
        Class modelClass = [defaultModel class];
        //如果表不存在就直接创建表
        if (![self tableExists:tableName]) {
            return [self createTableIfNotExists:tableName model:modelClass];
        }
        NSArray *ivarNamesAndTypes = [modelClass getIvarNamesAndTypes];
        //获取表中原先的所有的字段名 新的数据表中数据是否在老数据表中有 如果没有就添加
        NSString *sqlStr = [NSString stringWithFormat:@"SELECT * FROM %@",tableName];
        FMResultSet *result = [self executeQuery:sqlStr];
        NSArray *oldNameArray = [[result columnNameToIndexMap] allKeys];
        for (NSDictionary *dict in ivarNamesAndTypes) {
            NSString *name = [dict valueForKey:@"name"];
            if (![oldNameArray containsObject:[name lowercaseString]]) {
                NSLog(@"新增字段:%@",name);
                NSMutableString *sqlStr = [[NSMutableString alloc] init];
                [sqlStr appendFormat:@"ALTER TABLE %@ ADD COLUMN %@ TEXT",tableName,name];
                id value = [defaultModel valueForKey:name];
                if (value) {
                    [sqlStr appendFormat:@" DEFAULT '%@'",value];
                }
                BOOL alterResult = [self executeUpdate:sqlStr];
                if (!alterResult) {
                    NSLog(@"%@ 添加失败",name);
                    return alterResult;
                }
            }

        }
        return YES;
    }
    return NO;
}

- (BOOL)deleteTable:(NSString *)tableName{
    if ([self open]) {
        NSString *sqlStr = [NSString stringWithFormat:@"DROP TABLE %@",tableName];
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

- (BOOL)updateModel:(id<MyDBModelDelegate>)model toTable:(NSString *)tableName{
    if (model && [model conformsToProtocol:@protocol(MyDBModelDelegate)]) {
        NSString *primaryKey = [model.class primaryKey];
        id value = [(id)model valueForKey:primaryKey];
        MyDBQuery *query = [MyDBQuery createByTableName:tableName];
        [query query:primaryKey opType:QUERY_EQ value:[NSString stringWithFormat:@"%@",value]];
        return [self updateByQuery:query model:model];
    }
    return NO;
}

- (BOOL)updateByQuery:(MyDBQuery *)query model:(id)model{
    if ([self open] && model && model) {
        BOOL result = [self executeUpdate:[query updateSQL:model]];
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

- (BOOL)deleteModle:(id<MyDBModelDelegate>)model tableName:(NSString *)tableName{
    if (model && [model conformsToProtocol:@protocol(MyDBModelDelegate)]) {
        NSString *primaryKey = [model.class primaryKey];
        id value = [(id)model valueForKey:primaryKey];
        MyDBQuery *query = [MyDBQuery createByTableName:tableName];
        [query query:primaryKey opType:QUERY_EQ value:[NSString stringWithFormat:@"%@",value]];
        return [self deleteByQuery:query];
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
                if ([type isEqualToString:@"NSString"]) {
                    [keyValueDict setValue:dbValue forKey:name];
                }else{
                    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
                    NSNumber *numberValue = [f numberFromString:dbValue];
                    [keyValueDict setValue:numberValue forKey:name];
                }
//                //对不同的数据类型做处理 目前我们只有做了字符串类型
//                //统一的存进去都为字符串,取出来的时候再通过字符串转换值 bool 类型 int uint 或 NSInteger NSUInteger
//                if ([type isEqualToString:@"NSNumber"] || [type isEqualToString:@"B"] || [type isEqualToString:@"i"] ||[type isEqualToString:@"I"] || [type isEqualToString:@"q"] || [type isEqualToString:@"Q"]) {
//                    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
//                    NSNumber *numberValue = [f numberFromString:dbValue];
//                    [keyValueDict setValue:numberValue forKey:name];
//                }
//                else{
//                    [keyValueDict setValue:dbValue forKey:name];
//                }
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
@property (strong, nonatomic)NSMutableArray *statement;
@property (strong, nonatomic)NSMutableArray *orderArray;
@property (assign, nonatomic)BOOL isAsc;
@property (assign, nonatomic)int limit;
@property (assign, nonatomic)int offset;

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

- (void)setTableName:(NSString *)tableName{
    if (_tableName != tableName) {
        _tableName = tableName;
    }
}

- (NSMutableArray *)statement{
    if (_statement == nil) {
        _statement = [[NSMutableArray alloc] init];
    }
    return _statement;
}

- (NSMutableArray *)orderArray{
    if (_orderArray == nil) {
        _orderArray = [[NSMutableArray alloc] init];
    }
    return _orderArray;
}

- (MyDBQuery *)query:(NSString*)key opType:(NSString *)opType value:(id)value{
    NSString *condition = [self condition:key opType:opType value:value];
    [self.statement addObject:condition];
    return self;
}

- (MyDBQuery *)AND:(NSString*)key opType:(NSString *)opType value:(id)value{
    NSString *condition = [self condition:key opType:opType value:value];
    if (self.statement.count > 0) {
        condition = [NSString stringWithFormat:@"AND %@",condition];
    }
    [self.statement addObject:condition];
    return self;
}

- (MyDBQuery *)OR:(NSString*)key opType:(NSString *)opType value:(id)value{
    NSString *condition = [self condition:key opType:opType value:value];
    if (self.statement.count > 0) {
        condition = [NSString stringWithFormat:@"OR %@",condition];
    }
    [self.statement addObject:condition];
    return self;
}

- (MyDBQuery *)orderBy:(NSArray *)keys{
    [self.orderArray addObjectsFromArray:keys];
    return self;
}

- (MyDBQuery *)asc:(BOOL)asc{
    self.isAsc = asc;
    return self;
}

- (MyDBQuery *)limit:(int)limit{
    self.limit = limit;
    return self;

}
- (MyDBQuery *)offset:(int)offset{
    self.offset = offset;
    return self;
}

- (NSString *)updateSQL:(id)model{
    if (model) {
        NSMutableString *sqlStr = [[NSMutableString alloc] initWithFormat:@"UPDATE %@ SET",self.tableName];
        NSArray *ivarNamesAndTypes = [[model class] getIvarNamesAndTypes];
        for (NSDictionary *dict in ivarNamesAndTypes) {
            NSString *name = [dict valueForKey:@"name"];
            id value = [model valueForKey:name];
            if (value) {
                [sqlStr appendFormat:@" %@ = '%@',",name,value];
            }else{
                [sqlStr appendFormat:@" %@ = NULL,",name];
            }
        }
        [sqlStr deleteCharactersInRange:NSMakeRange(sqlStr.length - 1, 1)];
        [sqlStr appendString:[self statementStr]];
        return [sqlStr copy];
    }
    return nil;
}

- (NSString *)selectSQL{
    NSMutableString *sqlStr = [[NSMutableString alloc] initWithFormat:@"SELECT * FROM %@",self.tableName];
    if ([self statementStr].length > 0) {
        [sqlStr appendString:[self statementStr]];
    }
    NSLog(@"sql:%@",sqlStr);
    return [sqlStr copy];
}

- (NSString *)deleteSQL{
    NSMutableString *sqlStr = [[NSMutableString alloc] initWithFormat:@"DELETE FROM %@",self.tableName];
    if ([self statementStr].length > 0) {
        [sqlStr appendString:[self statementStr]];
    }
    return [sqlStr copy];
}

- (NSString *)condition:(NSString*)key opType:(NSString *)opType value:(id)value{
    NSString *condition;
    if ([opType isEqualToString:QUERY_CONTAINS]) {
        condition = [NSString stringWithFormat:@"%@ %@ '%%%@%%'",key,QUERY_LIKE,value];
    }else{
        condition = [NSString stringWithFormat:@"%@ %@ '%@'",key,opType,value];
    }
    return condition;
}

- (NSString *)statementStr{
    NSMutableString *sqlStr = [[NSMutableString alloc] init];
    if (self.statement.count > 0) {
        [sqlStr appendString:@" WHERE"];
        for (NSString *statementStr in self.statement) {
            [sqlStr appendString:@" "];
            [sqlStr appendString:statementStr];
        }
    }
    if (self.orderArray.count > 0) {
        [sqlStr appendString:@" ORDER BY "];
        for (NSString *orderStr in self.orderArray) {
            [sqlStr appendString:orderStr];
            [sqlStr appendString:@","];
        }
        [sqlStr deleteCharactersInRange:NSMakeRange(sqlStr.length - 1, 1)];
        self.isAsc?[sqlStr appendString:@" ASC"]:[sqlStr appendString:@" DESC"];
        }
    if (self.limit > 0) {
        [sqlStr appendFormat:@" LIMIT %ld",(long)self.limit];
    }
    if (self.offset > 0) {
        [sqlStr appendFormat:@" OFFSET %ld",(long)self.offset];
    }
    return [sqlStr copy];
}

@end
