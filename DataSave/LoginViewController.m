//
//  Login.m
//  DataSave
//
//  Created by SJ on 16/7/29.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "LoginSuccessViewController.h"
#import "RegisterManager.h"
#import "RegisterModel.h"
#import "LoginModel.h"
#import "LoginManager.h"


@interface LoginViewController ()

//label
@property(nonatomic,strong)UILabel *name;
@property(nonatomic,strong)UILabel *password;
@property(nonatomic,strong)UILabel *warmingPassword;
@property(nonatomic,strong)UILabel *warmingName;


//textField
@property(nonatomic,strong)UITextField *nameTextField;
@property(nonatomic,strong)UITextField *passwordTextField;

//button
@property(nonatomic,strong)UIButton *registBtn;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *resetPassword;

//数据库管理类
@property(nonatomic,strong)RegisterManager *manager;
//@property(nonatomic,strong)LoginManager *loginManager;

//判断login数据库是否有数据,True为有，False为没
@property(nonatomic,assign)BOOL flag;

@property(nonatomic,strong)NSArray<LoginModel *> *loginArray;

@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
    [self initData];

}
- (void)viewDidAppear:(BOOL)animated{
//    [self checkIfLoggedBefore];
    [self checkIfLogged];

}

- (void)createUI{
    [self createButton];
    [self createLableAndTextfield];
    
}
- (void)initData{
    _manager = [RegisterManager shareManager];
//    _loginManager = [LoginManager shareManager];
    _flag = false;
}
/*
- (void)checkIfLoggedBefore{
    _loginArray = [_loginManager getDataModelCount];
    if(_loginArray.count == 0){
        _flag = false;
    }else if(_loginArray.count ==1){
        _flag = true;
        
        LoginSuccessViewController *successView = [[LoginSuccessViewController alloc]init];
        LoginModel *model = [[LoginModel alloc]init];
        model = _loginArray[0];
        successView.loginNameStr = model.lastLoginName;
        successView.loginNickNameStr = model.nickName;
        [self presentViewController:successView animated:YES completion:^{
            NSLog(@"跳转");
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi2" object:self userInfo:@{@"name":model.lastLoginName,@"name2":model.nickName}];
            
        }];
        
    }else{
        NSLog(@"数据库错误");
    }
    
}
 */
- (void)checkIfLogged{
    
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *flag = [user objectForKey:@"loginAuto"];
    
    if([flag isEqualToString:@"1"]){
    
//        _flag = true;
        
        
        LoginSuccessViewController *successView = [[LoginSuccessViewController alloc]init];
        
//        LoginModel *model = [[LoginModel alloc]init];
//        model = _loginArray[0];
        successView.loginNameStr = [user objectForKey:@"name"];
        successView.loginNickNameStr = [user objectForKey:@"nickName"];
        [self presentViewController:successView animated:YES completion:^{
            NSLog(@"跳转");
            
            //            [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi2" object:self userInfo:@{@"name":model.lastLoginName,@"name2":model.nickName}];
            
        }];
        
    }else{
        NSLog(@"不能自动登录");
    }
    
}


- (void)createLableAndTextfield{
//    UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(20, 100, 70, 50)];
    _name = [[UILabel alloc]init];
    _name.text = @"用户名";
    [self.view addSubview:_name];
    [_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.offset(100);
        make.width.offset(70);
        make.height.offset(50);
    }];
    
    _warmingName = [[UILabel alloc]init];
    _warmingName.text = @"用户不存在";
    _warmingName.textColor = [UIColor redColor];
    _warmingName.hidden = YES;
    [self.view addSubview:_warmingName];
    [_warmingName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(148);
        make.width.offset(200);
        make.height.offset(40);
    }];
    
//    UITextField *nameTextFiend = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 50)];
    _nameTextField = [[UITextField alloc]init];
    _nameTextField.placeholder = @"输入用户名";
    [_nameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    _nameTextField.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:_nameTextField];
    [_nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(100);
        make.width.offset(200);
        make.height.offset(50);
    }];
    
    
//    UILabel *password = [[UILabel alloc]initWithFrame:CGRectMake(20, 200, 70, 50)];
    _password = [[UILabel alloc]init];
    _password.text = @"密码";
    [self.view addSubview:_password];
    [_password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.top.offset(200);
        make.width.offset(70);
        make.height.offset(50);
    }];
    
    _warmingPassword = [[UILabel alloc]init];
    _warmingPassword.text = @"密码错误";
    _warmingPassword.textColor = [UIColor redColor];
    _warmingPassword.hidden = YES;
    [self.view addSubview:_warmingPassword];
    [_warmingPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(248);
        make.width.offset(200);
        make.height.offset(40);
    }];
    
    
//    _passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 200, 200, 50)];
    _passwordTextField = [[UITextField alloc]init];
    _passwordTextField.placeholder = @"输入密码";
    [_passwordTextField setBorderStyle:UITextBorderStyleRoundedRect];
    _passwordTextField.clearButtonMode = UITextFieldViewModeAlways;
    _passwordTextField.secureTextEntry = YES;
    [self.view addSubview:_passwordTextField];
    [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.top.offset(200);
        make.width.offset(200);
        make.height.offset(50);
    }];
    
    


}

- (void)createButton{
//    UIButton *regist = [[UIButton alloc]initWithFrame:CGRectMake(50, 300, 100, 100)];
    _registBtn = [[UIButton alloc]init];
    [_registBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_registBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _registBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_registBtn];
    [_registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.top.offset(300);
        make.width.offset(100);
        make.height.offset(100);
    }];
    [_registBtn addTarget:self action:@selector(showRegistView) forControlEvents:UIControlEventTouchUpInside];
    
//    UIButton *login = [[UIButton alloc]initWithFrame:CGRectMake(200, 300, 100, 100)];
    _loginBtn = [[UIButton alloc]init];
    [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _loginBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_loginBtn];
    [_loginBtn addTarget:self action:@selector(Login) forControlEvents:UIControlEventTouchUpInside];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(200);
        make.top.offset(300);
        make.width.offset(100);
        make.height.offset(100);
    }];
    
    _resetPassword = [[UIButton alloc]init];
    [_resetPassword setTitle:@"重置密码" forState:UIControlStateNormal];
    [_resetPassword setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _resetPassword.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_resetPassword];
    [_resetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(50);
        make.top.offset(400);
        make.width.offset(100);
        make.height.offset(100);
    }];
    [_resetPassword addTarget:self action:@selector(resetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    

}

- (void)resetPasswordAction{
    BOOL ret = [_manager updateAllPassword];
    if(ret){
        NSLog(@"重置完成");
    }
    
}

- (void)showRegistView{
    RegisterViewController *view = [[RegisterViewController alloc]init];
    
    [self presentViewController:view animated:YES completion:^{
        NSLog(@"跳转");
    }];
}

- (void)Login{
    RegisterModel * model = [[RegisterModel alloc]init];
    model = [_manager searchDataModelWithName:_nameTextField.text];
    NSLog(@"name->%@, model.password->%@, password->%@",_nameTextField.text,model.password,_passwordTextField.text);
    if(![_manager searchIfExistWithName:_nameTextField.text]){
        NSLog(@"用户名不存在");
        _warmingName.hidden = NO;
        [self performSelector:@selector(hideWaringName) withObject:nil afterDelay:2];
    }else if(![model.password isEqualToString:_passwordTextField.text]){
        _warmingPassword.hidden = NO;
        [self performSelector:@selector(hideWaringPassword) withObject:nil afterDelay:2];
        NSLog(@"密码错");
    }else{
        /*
        if(_flag){
            [_loginManager updateNameWithName:_nameTextField.text nickName:[_manager searchDataModelWithName:_nameTextField.text].nickName ];
            NSLog(@"更新lastname");
        }else{
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:_nameTextField.text forKey:@"name"];
            [user setObject:[_manager searchDataModelWithName:_nameTextField.text].nickName forKey:@"nickName"];
            [user setBool:YES forKey:@"loginAuto"];
            
            [_loginManager addDataWithName:_nameTextField.text nickName:[_manager searchDataModelWithName:_nameTextField.text].nickName];
            NSLog(@"添加lastname");
        }
         */
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:_nameTextField.text forKey:@"name"];
        [user setObject:[_manager searchDataModelWithName:_nameTextField.text].nickName forKey:@"nickName"];
        [user setObject:@"1" forKey:@"loginAuto"];

        
        
        LoginSuccessViewController *successView = [[LoginSuccessViewController alloc]init];
        successView.loginNameStr = model.name;
        successView.loginNickNameStr = model.nickName;
        NSLog(@"loginViewController nickname= %@",model.nickName);

        [self presentViewController:successView animated:YES completion:^{
            NSLog(@"跳转");
            RegisterModel *model = [[RegisterModel alloc]init];
           model = [_manager searchDataModelWithName:_nameTextField.text];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"tongzhi" object:self userInfo:@{@"name":model.nickName,@"name2":model.name}];
                    }];
    }
    
    
}


- (void)hideWaringPassword{
    _warmingPassword.hidden = YES;
}

- (void)hideWaringName{
    _warmingName.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_nameTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
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
