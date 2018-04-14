//
//  SearchCell.m
//  DataSave
//
//  Created by SJ on 16/7/30.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "SearchCell.h"

@interface SearchCell()


@end

@implementation SearchCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        UILabel *nickLabel = [[UILabel alloc]init];
        nickLabel.text = @"昵称";
        nickLabel.backgroundColor = [UIColor whiteColor];
        nickLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:nickLabel];
        [nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(16);
            make.left.equalTo(self.contentView).offset(16);
            make.width.offset(40);
            make.height.offset(40);
        }];
        
        if(!_nickName){
            _nickName = [[UILabel alloc]init];
        }
        _nickName.text = _model.nickName;
        _nickName.textColor = [UIColor redColor];
        _nickName.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_nickName];
        [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(16);
            make.left.equalTo(self.contentView).offset(66);
            make.width.offset(100);
            make.height.offset(40);
        }];
        
        UILabel *birthLabel = [[UILabel alloc]init];
        birthLabel.text = @"生日";
        birthLabel.backgroundColor = [UIColor whiteColor];
        birthLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:birthLabel];
        [birthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(16);
            make.left.equalTo(self.contentView).offset(196);
            make.width.offset(40);
            make.height.offset(40);
        }];
        
        if(!_birthdate){
            _birthdate = [[UILabel alloc]init];
        }
        _birthdate.text = _model.birthdate;
        _birthdate.textColor = [UIColor redColor];
        _birthdate.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_birthdate];
        [_birthdate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(16);
            make.left.equalTo(self.contentView).offset(246);
            make.width.offset(100);
            make.height.offset(40);
        }];
        
    }
    return self;
}

@end
