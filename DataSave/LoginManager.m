//
//  LoginManager.m
//  DataSave
//
//  Created by SJ on 16/7/31.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "LoginManager.h"
#import "FMDataBase.h"

@implementation LoginManager
{
    FMDatabase *_database;
}

+ (LoginManager *)shareManager{
    static LoginManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LoginManager alloc]init];
    });
    
    return manager;
}

- (instancetype)init{
    if (self = [super init]){
        [self createDataBase];
    }
    return self;
    
}

- (void)createDataBase{
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/login.sqlite"];
    NSLog(@"login.sqlite-->%@",path);
    _database = [[FMDatabase alloc]initWithPath:path];
    BOOL isOpen = [_database open];
    if(isOpen){
        NSString *sql = @"create table if not exists login (number integer primary key autoincrement , lastName text, nickName text)";
        BOOL ret = [_database executeUpdate:sql];
        if(!ret){
            NSLog(@"数据库创建失败");
             NSLog(@"%@",_database.lastErrorMessage);
        }
        
    }
    
}

- (BOOL)addDataWithName:(NSString *)name nickName:(NSString *)nickName{
    NSString *sql = [NSString stringWithFormat:@"insert into login (lastName,nickName) values(?,?) "];
    BOOL ret = [_database executeUpdate:sql,name,nickName];
    NSLog(@"LoginAddSQL----%@",sql);
    if(!ret){
        NSLog(@"添加失败");
        NSLog(@"%@",_database.lastErrorMessage);

    }
    return ret;
}

- (NSArray *)getDataModelCount{
    NSString *sql = @"select * from login";
    FMResultSet *rs = [_database executeQuery:sql];
    NSMutableArray *array=[NSMutableArray array];
    while ([rs next]) {
        LoginModel *model = [[LoginModel alloc]init];
        model.lastLoginName = [rs objectForColumnName:@"lastName"];
        model.nickName = [rs objectForColumnName:@"nickName"];
        [array addObject:model];
    }
    return array;
    
}
- (BOOL)deleteDataWithName:(NSString *)name{
    NSString *sql = [NSString stringWithFormat:@"delete from login where lastName = '%@'",name];
    NSLog(@"%@",sql);
    BOOL ret = [_database executeUpdate:sql];
    if(!ret){
        NSLog(@"删除错误");
        NSLog(@"%@",_database.lastErrorMessage);
        
    }
    return ret;
}

- (BOOL)updateNameWithName:(NSString *)name nickName:(NSString *)nickName{
    NSString *sql = [NSString stringWithFormat:@"update login set lastName = '%@' , set nickName = '%@'",name,nickName];
    
    BOOL ret = [_database executeUpdate:sql];
    if(!ret){
        NSLog(@"数据更新失败，错误信息：%@",_database.lastErrorMessage);
    }
    return ret;
    
}


@end
