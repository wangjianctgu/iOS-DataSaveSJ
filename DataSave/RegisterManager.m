//
//  RegisterManager.m
//  DataSave
//
//  Created by SJ on 16/7/29.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "RegisterManager.h"
#import "FMDataBase.h"

@implementation RegisterManager
{
    FMDatabase *_database;
}

+ (RegisterManager *)shareManager{
    static RegisterManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RegisterManager alloc]init];
    });
    
    return manager;
}

- (instancetype)init{
    if(self = [super init]){
        [self createDatabase];
    }
    return self;
}

- (void)createDatabase{
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/register.sqlite"];
    NSLog(@"%@",path);
//    _database = [FMDatabase databaseWithPath:path];
    _database = [[FMDatabase alloc]initWithPath:path];
    BOOL isOpen = [_database open];
    if(isOpen){
        NSString *createSql = @"create table if not exists register (number integer primary key autoincrement, name text, password text, nickName text, birthdate text, code text)";
        
        BOOL ret = [_database executeUpdate:createSql];
        if(!ret){
            NSLog(@"数据库创建失败");
            NSLog(@"%@",_database.lastErrorMessage);
        }
    }
    

}

//添加
- (BOOL)addDataModel:(RegisterModel *)model{
    NSString *addSql = @"insert into register (name, password, nickName, birthdate, code) values(?,?,?,?,?)";
    BOOL ret = [_database executeUpdate:addSql, model.name, model.password, model.nickName, model.birthdate, model.code];
    NSLog(@"addSQL---->%@",addSql);
    if(!ret){
        NSLog(@"添加数据失败");
        NSLog(@"%@",_database.lastErrorMessage);
    }
    return ret;

}

//查询
/*
- (BOOL)searchDataModel:(RegisterModel *)model{
    NSString *searchNameSql =[NSString stringWithFormat: @"select * from register where name = '%@'",model.name];
    FMResultSet *rs = [_database executeQuery:searchNameSql];
    if([rs next]){
        return YES;
    }else{
        return NO;
    }
    
}
 */

- (BOOL)searchDataWithNickName:(NSString *)nickName{
    NSString *searchNameSql =[NSString stringWithFormat: @"select * from register where nickName = '%@'",nickName];
    FMResultSet *rs = [_database executeQuery:searchNameSql];
    if([rs next]){
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)searchIfExistWithName:(NSString *)name{
    NSString *searchNameSql = [NSString stringWithFormat:@"select * from register where name = '%@'",name];
    
    FMResultSet *rs = [_database executeQuery:searchNameSql];
    if([rs next]){
        return  YES;
    }else{
        return NO;
    }
    
}

- (NSMutableArray *)searchDataWithNickNameOrBirthdate:(NSString *)text{
    NSMutableArray *array = [NSMutableArray array];
    if(![text isEqualToString:@""]){
    NSString *searchSql = [NSString stringWithFormat:
                           @"select * from register where nickName like '%%%@%%' or birthdate = '%@'",text,text];
    FMResultSet *rs = [_database executeQuery:searchSql];
        NSLog(@"searchSQL ====%@",searchSql);

    while ([rs next]) {
        RegisterModel *model = [[RegisterModel alloc]init];
        model.name = [rs stringForColumn:@"name"];
        model.password = [rs stringForColumn:@"password"];
        model.nickName = [rs stringForColumn:@"nickName"];
        model.birthdate = [rs stringForColumn:@"birthdate"];
        model.code = [rs stringForColumn:@"code"];
        [array addObject:model];

    }
    }
    return  array;
}

- (RegisterModel *)searchDataModelWithName:(NSString *)name{
    NSString *searchNameSql = [NSString stringWithFormat:@"select * from register where name = '%@'",name];
    NSLog(@"name ==== %@",name);
    FMResultSet *rs = [_database executeQuery:searchNameSql];
    if([rs next]){
        RegisterModel *model = [[RegisterModel alloc]init];
        model.name = [rs stringForColumn:@"name"];
        model.password = [rs stringForColumn:@"password"];
        model.nickName = [rs stringForColumn:@"nickName"];
        model.birthdate = [rs stringForColumn:@"birthdate"];
        model.code = [rs stringForColumn:@"code"];
        return model;
    }else{
        NSLog(@"没有查到%@数据",name);
        return nil;
    }
}

//修改
- (BOOL)updateAllPassword{
    NSString *sql = [NSString stringWithFormat:@"update register set password = '%@'",@"00000000"];
    BOOL ret = [_database executeUpdate:sql];
    if(!ret){
        NSLog(@"数据更新失败");
    }
    return ret;
}

- (BOOL)updatePasswordWithNewPassword:(NSString *)newPassword name:(NSString *)name{
    NSString *sql = [NSString stringWithFormat:@"update register set password = '%@' where name = '%@' ",newPassword,name];
    BOOL ret = [_database executeUpdate:sql];
    if(!ret){
        NSLog(@"密码更新失败");
    }
    return  ret;


}

//删除
- (BOOL)removeDataModelWithCode:(NSString *)code{
    NSString *sql = [NSString stringWithFormat:@"delete from register where code = '%@'",code];
    BOOL ret = [_database executeUpdate:sql];
    if(!ret){
        NSLog(@"删除失败");
        NSLog(@"%@",_database.lastErrorMessage);
    }
    return ret;

}

//获取所有数据
- (NSArray *)getAllData{

    NSString *serchAllSql = @"select * from register";
    FMResultSet *rs = [_database executeQuery:serchAllSql];
    
    NSMutableArray *array = [NSMutableArray array];
    while ([rs next]) {
        RegisterModel *model = [[RegisterModel alloc]init];
        model.name = [rs stringForColumn:@"name"];
        model.password = [rs stringForColumn:@"password"];
        model.nickName = [rs stringForColumn:@"nickName"];
        model.birthdate = [rs stringForColumn:@"birthdate"];
        model.code = [rs stringForColumn:@"code"];
        [array addObject:model];
    }
    return array;
}

@end
