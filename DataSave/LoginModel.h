//
//  LoginModel.h
//  DataSave
//
//  Created by SJ on 16/7/31.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

//上次登录的名字
@property(nonatomic,strong)NSString *lastLoginName;
//nickName
@property(nonatomic,strong)NSString *nickName;
@end
