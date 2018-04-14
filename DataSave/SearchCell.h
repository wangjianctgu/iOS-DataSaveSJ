//
//  SearchCell.h
//  DataSave
//
//  Created by SJ on 16/7/30.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterModel.h"
@interface SearchCell : UITableViewCell

@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *birthdate;
@property(nonatomic,strong)RegisterModel *model;

@end
