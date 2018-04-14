//
//  Register.m
//  DataSave
//
//  Created by SJ on 16/7/29.
//  Copyright © 2016年 SJ. All rights reserved.
//
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Masonry.h"
#import "RegisterManager.h"

@interface RegisterViewController ()

//appdelegate
@property(nonatomic,strong)AppDelegate *app;
//按钮
@property(nonatomic,strong)UIButton *regist;
@property(nonatomic,strong)UIButton *back;
//label
@property(nonatomic,strong)UILabel *birth;
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *password;
@property(nonatomic,strong)UILabel *password2;
@property(nonatomic,strong)UILabel *nickName;
@property(nonatomic,strong)UILabel *waringName;
@property(nonatomic,strong)UILabel *waringPassword;
@property(nonatomic,strong)UILabel *waringNickName;
@property(nonatomic,strong)UILabel *registerSuccess;
@property(nonatomic,strong)UILabel *waringNameCount;
@property(nonatomic,strong)UILabel *waringPassword1Count;
@property(nonatomic,strong)UILabel *waringPassword2Count;
@property(nonatomic,strong)UILabel *waringNickNameCount;
//textField
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *passwordTextField;
@property(nonatomic,strong)UITextField *passwordTextField2;
@property(nonatomic,strong)UITextField *nickNameTextField;
//datePicker
@property(nonatomic,strong)UIDatePicker *datePicker;
@property(nonatomic,strong)NSDateFormatter *formatter;
//count所有
@property(nonatomic,assign)NSInteger countName;
//数据库管理类
@property(nonatomic,strong)RegisterManager *manager;
//数据
@property(nonatomic,strong)NSMutableArray <RegisterModel *> *dataArray;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self initdata];
    [self createUI];
    
}

- (void)initdata{
    _manager = [RegisterManager shareManager];
    _dataArray = [NSMutableArray arrayWithArray:[_manager getAllData]];
}
#pragma mark 创建UI
- (void)createUI{
    [self createButton];
    [self createLabelAndTextField];
    [self createDatePick];
}


- (void)createButton{
//    _regist = [[UIButton alloc]initWithFrame:CGRectMake(50, 500, 100, 100)];
    _regist = [[UIButton alloc]init];
    [_regist setTitle:@"注册" forState:UIControlStateNormal];
    [_regist setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _regist.backgroundColor = [UIColor whiteColor];
    _regist.tag = 1001;
    [self.view addSubview:_regist];
    [_regist addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    [_regist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.top.offset(500);
        make.width.offset(100);
        make.height.offset(100);
    }];
    
//    _back = [[UIButton alloc]initWithFrame:CGRectMake(200, 500, 100, 100)];
    _back = [[UIButton alloc]init];
    [_back setTitle:@"返回" forState:UIControlStateNormal];
    [_back setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _back.backgroundColor = [UIColor whiteColor];
    _back.tag = 1002;
    [self.view addSubview:_back];
    [_back addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(200);
        make.top.offset(500);
        make.width.offset(100);
        make.height.offset(100);
        
    }];
    
}
- (void)createDatePick{
//    _birth = [[UILabel alloc]initWithFrame:CGRectMake(20, 400, 70, 50)];
    _birth = [[UILabel alloc]init];
    _birth.text = @"生日";
    [self.view addSubview:_birth];
    
    _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(50, 350, kScreenWidth-60, 150)];
    [_datePicker setDate:[NSDate date] animated:YES];
    [_datePicker setMaximumDate:[NSDate date]];
    [_datePicker setMinimumDate:[self.formatter dateFromString:@"1900-01-01"]];
    
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.view addSubview:_datePicker];
    [_birth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.offset(400);
        make.width.offset(70);
        make.height.offset(50);
    }];
}

- (void)createLabelAndTextField{
//    _name = [[UILabel alloc]initWithFrame:CGRectMake(20, 40, 70, 50)];
    _name = [[UILabel alloc]init];
    _name.text = @"用户名";
    [self.view addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.offset(40);
        make.width.offset(70);
        make.height.offset(50);
    }];
    
    _waringNameCount = [[UILabel alloc]init];
    _waringNameCount.text = @"用户名长度8-16";
    _waringNameCount.textColor = [UIColor redColor];
    _waringNameCount.hidden = YES;
    [self.view addSubview:_waringNameCount];
    [_waringNameCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(83);
        make.width.offset(200);
        make.height.offset(40);
    }];
    
    _waringName = [[UILabel alloc]init];
    _waringName.text = @"该用户名已经存在";
    _waringName.textColor = [UIColor redColor];
    _waringName.hidden = YES;
    [self.view addSubview:_waringName];
    [_waringName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(83);
        make.width.offset(200);
        make.height.offset(40);
    }];
    
//    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 40, 200, 50)];
    _nameTextField = [[UITextField alloc]init];
    [_nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    _nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_nameTextField];
    
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(40);
        make.width.offset(200);
        make.height.offset(50);
        
    }];
    
//    _password = [[UILabel alloc]initWithFrame:CGRectMake(20, 120, 70, 50)];
    _password = [[UILabel alloc]init];
    _password.text = @"密码";
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(120);
        make.left.equalTo(self.view).offset(20);
        make.width.offset(70);
        make.height.offset(50);
    }];
    
    _waringPassword1Count = [[UILabel alloc]init];
    _waringPassword1Count.text = @"密码长度在8-16位";
    _waringPassword1Count.textColor = [UIColor redColor];
    _waringPassword1Count.hidden = YES;
    [self.view addSubview:_waringPassword1Count];
    [_waringPassword1Count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(163);
        make.width.offset(200);
        make.height.offset(40);
    }];
    
//    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 120, 200, 50)];
    _passwordTextField = [[UITextField alloc]init];
    [_passwordTextField setBorderStyle:UITextBorderStyleRoundedRect];
    _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTextField.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(120);
        make.width.offset(200);
        make.height.offset(50);
    }];
    
//    _password2 = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, 70, 50)];
    _password2 = [[UILabel alloc]init];
    _password2.text = @"确认密码";
    [self.view addSubview:_password2];
    [_password2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.offset(200);
        make.width.offset(70);
        make.height.offset(50);
    }];
    
    _waringPassword2Count = [[UILabel alloc]init];
    _waringPassword2Count.text = @"密码长度在8-16位";
    _waringPassword2Count.textColor = [UIColor redColor];
    _waringPassword2Count.hidden = YES;
    [self.view addSubview:_waringPassword2Count];
    [_waringPassword2Count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(243);
        make.width.offset(200);
        make.height.offset(40);
    }];
    
    _waringPassword = [[UILabel alloc]init];
    _waringPassword.text = @"两次输入的密码不同";
    _waringPassword.textColor = [UIColor redColor];
    _waringPassword.hidden = YES;
    [self.view addSubview:_waringPassword];
    [_waringPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(243);
        make.width.offset(200);
        make.height.offset(40);
    }];
    
//    _passwordTextField2 = [[UITextField alloc]initWithFrame:CGRectMake(100, 200, 200, 50)];
    _passwordTextField2 = [[UITextField alloc]init];
    [_passwordTextField2 setBorderStyle:UITextBorderStyleRoundedRect];
    _passwordTextField2.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTextField2.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField2];
    [_passwordTextField2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(200);
        make.width.offset(200);
        make.height.offset(50);
    }];
    
//    _nickName = [[UILabel alloc]initWithFrame:CGRectMake(20, 280, 70, 50)];
    _nickName = [[UILabel alloc]init];
    _nickName.text = @"昵称";
    [self.view addSubview:_nickName];
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.offset(280);
        make.width.offset(70);
        make.height.offset(50);
    }];
    
    _waringNickName = [[UILabel alloc]init];
    _waringNickName.text = @"昵称已经存在";
    _waringNickName.textColor = [UIColor redColor];
    _waringNickName.hidden = YES;
    [self.view addSubview:_waringNickName];
    [_waringNickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(323);
        make.width.offset(200);
        make.height.offset(40);
    }];
    
    _waringNickNameCount = [[UILabel alloc]init];
    _waringNickNameCount.text = @"昵称要1-12位";
    _waringNickNameCount.textColor = [UIColor redColor];
    _waringNickNameCount.hidden = YES;
    [self.view addSubview:_waringNickNameCount];
    [_waringNickNameCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(323);
        make.width.offset(200);
        make.height.offset(40);
    }];

    
//    _nickNameTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 280, 200, 50)];
    _nickNameTextField = [[UITextField alloc]init];
    [_nickNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    _nickNameTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_nickNameTextField];
    [_nickNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(280);
        make.width.offset(200);
        make.height.offset(50);
    }];
    
    
    _registerSuccess = [[UILabel alloc]init];
    _registerSuccess.text = @"注册成功";
    _registerSuccess.backgroundColor = [UIColor blackColor];
    _registerSuccess.textColor = [UIColor redColor];
    _registerSuccess.alpha = 0.6;
    _registerSuccess.textAlignment = NSTextAlignmentCenter;
    _registerSuccess.hidden = YES;
    [self.view addSubview:_registerSuccess];
    [_registerSuccess mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.offset(200);
        make.height.offset(100);
    }];


}

#pragma mark 按钮方法
- (void)registAction{
    NSString *s = [_formatter stringFromDate:_datePicker.date];
    NSLog(@"%@",s);
    
    RegisterModel *model = [RegisterModel new];
    model.name = _nameTextField.text;
    model.password = _passwordTextField.text;
    model.nickName = _nickNameTextField.text;
    model.birthdate = s;
    model.code = [NSString stringWithFormat:@"%ld",_dataArray.lastObject.code.integerValue+1];
    NSLog(@"%ld",(long)model.name.length);
    
    if(model.name.length > 16 || model.name.length < 8){
        _waringNameCount.hidden = NO;
        [self performSelector:@selector(hideWaringNameCount) withObject:nil afterDelay:2];
    }else if(model.password.length > 16 || model.password.length < 8){
        _waringPassword1Count.hidden = NO;
        [self performSelector:@selector(hideWaringPassword1Count) withObject:nil afterDelay:2];
    }else if(_passwordTextField2.text.length > 16 || _passwordTextField2.text.length < 8){
        _waringPassword2Count.hidden = NO;
        [self performSelector:@selector(hideWaringPassword2Count) withObject:nil afterDelay:2];
    }else if(model.nickName.length < 1 || model.nickName.length > 12){
        _waringNickNameCount.hidden = NO;
        [self performSelector:@selector(hideWaringNickNameCount) withObject:nil afterDelay:2];
    }else if([_manager searchDataModelWithName:model.name]){
        NSLog(@"已经存在name");
        _waringName.hidden = NO;
        [self performSelector:@selector(hideWaringName) withObject:nil afterDelay:2];
    }else if(![_passwordTextField.text isEqualToString:_passwordTextField2.text]){
        NSLog(@"密码不一样");
        _waringPassword.hidden = NO;
        [self performSelector:@selector(hideWaringPassword) withObject:nil afterDelay:2];
    }else if([_manager searchDataWithNickName:model.nickName]){
        NSLog(@"已经存在nickName");
        _waringNickName.hidden = NO;
        [self performSelector:@selector(hideWaringNickName) withObject:nil afterDelay:2];
    }else{
            if([_manager addDataModel:model]){
                NSLog(@"添加成功");
                _registerSuccess.hidden = NO;
                [self performSelector:@selector(hideRegisterSuccess) withObject:nil afterDelay:2];
            }
        }
    
    
}
- (void)backAction{
    LoginViewController *loginView = [[LoginViewController alloc]init];
    [self presentViewController:loginView animated:YES completion:^{
        NSLog(@"返回登录");
    }];
    
}

#pragma mark 来延时消失label
- (void)hideWaringName{
    _waringName.hidden = YES;
}
- (void)hideWaringPassword{
    _waringPassword.hidden = YES;
}
- (void)hideWaringNickName{
    _waringNickName.hidden = YES;
}

- (void)hideWaringNameCount{
    _waringNameCount.hidden = YES;
}

- (void)hideWaringPassword1Count{
    _waringPassword1Count.hidden = YES;
}
- (void)hideWaringPassword2Count{
    _waringPassword2Count.hidden = YES;
}
- (void)hideWaringNickNameCount{
    _waringNickNameCount.hidden = YES;
}


- (void)hideRegisterSuccess{
    _registerSuccess.hidden = YES;
    LoginViewController *loginView = [[LoginViewController alloc]init];
    [self presentViewController:loginView animated:YES completion:^{
        NSLog(@"跳转");
    }];
}

//取消键盘响应
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_nameTextField resignFirstResponder];
    [_nickNameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
    [_passwordTextField2 resignFirstResponder];
}


//修改格式
-(NSDateFormatter *)formatter{
    if(_formatter){
        return _formatter;
    }
    _formatter = [[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    return _formatter;
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
