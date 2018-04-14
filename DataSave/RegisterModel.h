//
//  RegisterModel.h
//  DataSave
//
//  Created by SJ on 16/7/29.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject

//用户名
@property(nonatomic,strong)NSString *name;
//密码
@property(nonatomic,strong)NSString *password;
//昵称
@property(nonatomic,strong)NSString *nickName;
//生日
@property(nonatomic,strong)NSString *birthdate;
//唯一标识码
@property (nonatomic, strong) NSString *code;

@end
