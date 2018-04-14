//
//  LoginSuccess.m
//  DataSave
//
//  Created by SJ on 16/7/29.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "LoginSuccessViewController.h"
#import "RegisterManager.h"
#import "SearchCell.h"
#import "RegisterModel.h"
#import "LoginViewController.h"
#import "LoginModel.h"
#import "LoginManager.h"

@interface LoginSuccessViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

//label
@property(nonatomic,strong)UILabel *successLabel;
@property(nonatomic,strong)UILabel *modifyPasswordSuccessedLabel;
@property(nonatomic,strong)UILabel *passwordLabel1;
@property(nonatomic,strong)UILabel *passwordLabel2;
@property(nonatomic,strong)UILabel *waringPasswordLabel;
@property(nonatomic,strong)UILabel *waringPassword1CountLabel;
@property(nonatomic,strong)UILabel *waringPassword2CountLabel;
//textfield
@property(nonatomic,strong)UITextField *passwordTextField1;
@property(nonatomic,strong)UITextField *passwordTextField2;
//searchbar
@property(nonatomic,strong)UISearchBar *searchBar;
//搜索结果数组
@property(nonatomic,strong)NSMutableArray<RegisterModel *> *searchResultArray;
//数据库管理类
@property(nonatomic,strong)RegisterManager *manager;
@property(nonatomic,strong)LoginManager *loginManager;
//tableview
@property(nonatomic,strong)UITableView *tableView;

//修改密码按钮
@property(nonatomic,strong)UIButton *modifyPasswordBtn;
//注销btn
@property(nonatomic,strong)UIButton *logoutBtn;

@end

static NSString *Cell = @"Cell";


@implementation LoginSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self initData];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLabelText:) name:@"tongzhi" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLabelText2:) name:@"tongzhi2" object:nil];
    [self setLableStr];
    [self performSelector:@selector(hideSuccessLoginLabel) withObject:nil afterDelay:3];
    
  
}
//- (void)dealloc{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
//}


- (void)initData{
    _manager = [RegisterManager shareManager];
    _loginManager = [LoginManager shareManager];
    _searchResultArray = [NSMutableArray array];
    
}

- (void)createUI{
    [self create];
    [self createTableView];
    [self createButton];
    [self createTextField];
    [self createLabel];
}

- (void)createButton{
    _modifyPasswordBtn = [[UIButton alloc]init];
    [_modifyPasswordBtn setTitle:@"修改密码" forState:UIControlStateNormal];
    [_modifyPasswordBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _modifyPasswordBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_modifyPasswordBtn];
    [_modifyPasswordBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(600);
        make.left.equalTo(self.view).offset(20);
        make.width.offset(100);
        make.height.offset(50);
    }];
    [_modifyPasswordBtn addTarget:self action:@selector(modifyPassword) forControlEvents:UIControlEventTouchUpInside];

    
    _logoutBtn = [[UIButton alloc]init];
    [_logoutBtn setTitle:@"注销" forState:UIControlStateNormal];
    [_logoutBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _logoutBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_logoutBtn];
    [_logoutBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(600);
        make.left.equalTo(self.view).offset(230);
        make.width.offset(100);
        make.height.offset(50);
    }];
    [_logoutBtn addTarget:self action:@selector(logoutAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)createLabel{
    _passwordLabel1 = [[UILabel alloc]init];
    _passwordLabel1.text = @"密码";
    [self.view addSubview:_passwordLabel1];
    [_passwordLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.offset(400);
        make.width.offset(70);
        make.height.offset(50);
    }];
    
    _passwordLabel2 = [[UILabel alloc]init];
    _passwordLabel2.text = @"确认密码";
    [self.view addSubview:_passwordLabel2];
    [_passwordLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.offset(500);
        make.width.offset(70);
        make.height.offset(50);
    }];
    
    _waringPassword1CountLabel = [[UILabel alloc]init];
    _waringPassword1CountLabel.text = @"密码长度在8-16位";
    _waringPassword1CountLabel.textColor = [UIColor redColor];
    _waringPassword1CountLabel.hidden = YES;
    [self.view addSubview:_waringPassword1CountLabel];
    [_waringPassword1CountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(443);
        make.width.offset(200);
        make.height.offset(40);
    }];
    
    _waringPassword2CountLabel = [[UILabel alloc]init];
    _waringPassword2CountLabel.text = @"密码长度在8-16位";
    _waringPassword2CountLabel.textColor = [UIColor redColor];
    _waringPassword2CountLabel.hidden = YES;
    [self.view addSubview:_waringPassword2CountLabel];
    [_waringPassword2CountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(543);
        make.width.offset(200);
        make.height.offset(40);
    }];
    
    _waringPasswordLabel = [[UILabel alloc]init];
    _waringPasswordLabel.text = @"两次密码输入不同";
    _waringPasswordLabel.textColor = [UIColor redColor];
    _waringPasswordLabel.hidden = YES;
    [self.view addSubview:_waringPasswordLabel];
    [_waringPasswordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(543);
        make.width.offset(200);
        make.height.offset(40);
    }];
    
    
}

- (void)createTextField{
    _passwordTextField1 = [[UITextField alloc]init];
    [_passwordTextField1 setBorderStyle:UITextBorderStyleRoundedRect];
    _passwordTextField1.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTextField1.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField1];
    [_passwordTextField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(400);
        make.width.offset(200);
        make.height.offset(50);
    }];
    
    _passwordTextField2 = [[UITextField alloc]init];
    [_passwordTextField2 setBorderStyle:UITextBorderStyleRoundedRect];
    _passwordTextField2.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTextField2.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField2];
    [_passwordTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(500);
        make.width.offset(200);
        make.height.offset(50);
    }];
    
}

- (void)createTableView{
    _tableView = [[UITableView alloc]init];
    [_tableView registerClass:[SearchCell class] forCellReuseIdentifier:Cell];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = [UIView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(70);
        make.left.equalTo(self.view);
        make.height.offset(kScreenHeight-400);
        make.width.offset(kScreenWidth);
    }];
    
}

- (void)create{
    _successLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 550, 200, 50)];
//    _successLabel.text = @"登录成功";
    _successLabel.textAlignment = NSTextAlignmentCenter;
    _successLabel.backgroundColor = [UIColor blackColor];
    _successLabel.alpha = 0.5;
    _successLabel.textColor = [UIColor redColor];
    [self.view addSubview:_successLabel];
    
    
    _modifyPasswordSuccessedLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 550, 200, 50)];
    _modifyPasswordSuccessedLabel.text = @"修改成功";
    _modifyPasswordSuccessedLabel.textAlignment = NSTextAlignmentCenter;
    _modifyPasswordSuccessedLabel.backgroundColor = [UIColor blackColor];
    _modifyPasswordSuccessedLabel.alpha = 0.5;
    _modifyPasswordSuccessedLabel.hidden = YES;
    _modifyPasswordSuccessedLabel.textColor = [UIColor redColor];
    [self.view addSubview:_modifyPasswordSuccessedLabel];
    
    
    _searchBar = [[UISearchBar alloc]init];
    _searchBar.placeholder = @"请输入您想搜索的内容";
    [_searchBar setShowsCancelButton:YES animated:YES];
    _searchBar.delegate = self;
    
    
    [self.view addSubview:_searchBar];
    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.offset(20);
        make.width.offset(kScreenWidth);
        make.height.offset(50);
    }];
    
    
}

#pragma mark 修改方法
//修改密码方法
- (void)modifyPassword{
    if(_passwordTextField1.text.length > 16 || _passwordTextField1.text.length < 8){
        _waringPassword1CountLabel.hidden = NO;
        [self performSelector:@selector(hideWaringPassword1Count) withObject:nil afterDelay:2];
    }else if(_passwordTextField2.text.length > 16 || _passwordTextField2.text.length < 8){
        _waringPassword2CountLabel.hidden = NO;
        [self performSelector:@selector(hideWaringPassword2Count) withObject:nil afterDelay:2];
    }else if(![_passwordTextField1.text isEqualToString:_passwordTextField2.text]){
        _waringPasswordLabel.hidden = NO;
        [self performSelector:@selector(hideWaringPassword) withObject:nil afterDelay:2];
    }else{
        if([_manager updatePasswordWithNewPassword:_passwordTextField1.text name:_loginNameStr]){
            NSLog(@"修改密码成功");
            _modifyPasswordSuccessedLabel.hidden = NO;
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:@"0" forKey:@"loginAuto"];

            
            [self performSelector:@selector(hideModifySuccessedLabel) withObject:nil afterDelay:2];
        }
    }
}
- (void)hideWaringPassword1Count{
    _waringPassword1CountLabel.hidden = YES;
}

- (void)hideWaringPassword2Count{
    _waringPassword2CountLabel.hidden = YES;
}

- (void)hideWaringPassword{
    _waringPasswordLabel.hidden = YES;
}

- (void)hideModifySuccessedLabel{
    _modifyPasswordSuccessedLabel.hidden = YES;
//    Login *loginView = [[Login alloc]init];
//    [self presentViewController:loginView animated:YES completion:^{
//        NSLog(@"跳转回login");
//    }];

        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"跳转回login");
        }];

}

- (void)hideSuccessLoginLabel{
    _successLabel.hidden = YES;
}

- (void)logoutAction{
//   BOOL flag = [_loginManager deleteDataWithName:_loginNameStr];
//    if(flag){
//    [self dismissViewControllerAnimated:YES completion:^{
//        NSLog(@"注销");
//    }];
//    }
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:@"0" forKey:@"loginAuto"];
    
    NSString *flag = [user objectForKey:@"loginAuto"];
    
    if([flag isEqualToString:@"0"]){
    [self dismissViewControllerAnimated:YES completion:^{
                NSLog(@"注销");
            }];
    }
    else{
        NSLog(@"loginAuto修改失败");
    }
}


#pragma mark 消息方法

- (void)changeLabelText:(NSNotification *)notification{
    NSLog(@"消息");
    NSDictionary *nameDic = [notification userInfo];
    _successLabel.text = [NSString stringWithFormat:@"%@登录成功",[nameDic objectForKey:@"name"]];
    _loginNameStr = [nameDic objectForKey:@"name2"];
    NSLog(@"%@",_loginNameStr);
}

- (void)changeLabelText2:(NSNotification *)notification{
    NSLog(@"消息");
    NSDictionary *nameDic = [notification userInfo];
    _successLabel.text = [NSString stringWithFormat:@"%@登录成功",[nameDic objectForKey:@"name2"]];
    _loginNameStr = [nameDic objectForKey:@"name"];
    NSLog(@"%@",_loginNameStr);
}


#pragma mark UISearchBarDelegate方法
//点击搜索框
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"点击搜索框");
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [_searchBar setShowsCancelButton:YES animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    return YES;
}

//实时搜索
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"textDidChange：%@", searchText);
    _searchResultArray = [_manager searchDataWithNickNameOrBirthdate:searchText];
    NSLog(@"%ld",(long)_searchResultArray.count);
    [_tableView reloadData];
}

//点击搜索按钮(这是点击搜索按钮之后再搜索)

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar

{
    
    NSLog(@"搜索按钮点击....");
    
    NSLog(@"----%@", searchBar.text);
    
    
    [_searchBar resignFirstResponder];
    
}

//点击取消按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"点击取消按钮");
    [_searchBar resignFirstResponder];
    [_searchBar setShowsCancelButton:NO animated:YES];
    [_searchResultArray removeAllObjects];
    [_tableView reloadData];
}


#pragma mark tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _searchResultArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    RegisterModel *mod = _searchResultArray[indexPath.row];
    cell.model = mod;
    cell.nickName.text = mod.nickName;
    cell.birthdate.text = mod.birthdate;
    return cell;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_passwordTextField1 resignFirstResponder];
    [_passwordTextField2 resignFirstResponder];
}

- (void)setLableStr{
    _successLabel.text = [NSString stringWithFormat:@"%@登录成功",_loginNickNameStr];
    NSLog(@"%@",_loginNameStr);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
