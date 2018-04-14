//
//  LoginManager.h
//  DataSave
//
//  Created by SJ on 16/7/31.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"

@interface LoginManager : NSObject


+ (LoginManager *)shareManager;

- (NSArray *)getDataModelCount;

- (BOOL)updateNameWithName:(NSString *)name nickName:(NSString *)nickName;

- (BOOL)addDataWithName:(NSString *)name nickName:(NSString *)nickName;

- (BOOL)deleteDataWithName:(NSString *)name;
@end
