//
//  RegisterManager.h
//  DataSave
//
//  Created by SJ on 16/7/29.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegisterModel.h"

@interface RegisterManager : NSObject

//获取单例方法，保证每次取得的对象是同一个
+ (RegisterManager *)shareManager;
//添加数据
- (BOOL)addDataModel:(RegisterModel *)model;
//通过code移除数据
- (BOOL)removeDataModelWithCode:(NSString *)code;
//搜索数据 实质就是搜索name 下面有
//- (BOOL)searchDataModel:(RegisterModel *)model;
//搜索带NickName的数据
- (BOOL)searchDataWithNickName:(NSString *)nickName;
//搜索带name的数据
- (BOOL)searchIfExistWithName:(NSString *)name;
//更新所有的密码
- (BOOL)updateAllPassword;
//修改密码
- (BOOL)updatePasswordWithNewPassword:(NSString *)newPassword name:(NSString *)name;
//搜索带有name的Model
- (RegisterModel *)searchDataModelWithName:(NSString *)name;
//搜索带有名字或者生日的数据，返回数可变组
- (NSMutableArray *)searchDataWithNickNameOrBirthdate:(NSString *)text;
//获取所有Data，返回数组
- (NSArray *)getAllData;

@end
