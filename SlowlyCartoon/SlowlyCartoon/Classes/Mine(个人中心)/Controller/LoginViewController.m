//
//  LoginViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "LoginViewController.h"
//107 255 232 
@interface LoginViewController ()<UITextFieldDelegate>


@property(nonatomic,strong)PersonManager * personManager;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = myWhiteColor;
    
    self.userNameTextField.font = Font_18;
    
    self.passWordTextField.font = Font_18;
    
    self.loginBtn.backgroundColor = myRedColor;
    
    self.loginBtn.titleLabel.font = Font_22;
    
    [self.registerBtn setTitleColor:myRedColor forState:(UIControlStateNormal)];
    
    self.registerBtn.titleLabel.font = Font_22;
    
   
    
    self.fastLogin.font = Font_16;
    
    self.fastLogin.textColor = myRedColor;
    
//    干掉之前的userName
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"avator"];
//    切圆角
    [self cutRound];
    
    
//    设置userNameTextField代理
    
    _userNameTextField.delegate = self;
    
    //leftItem
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"<个人中心" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftItemAction:)];
    
    
    
    [leftItem setTitleTextAttributes:@{NSFontAttributeName:Font_24} forState:(UIControlStateNormal)];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)leftItemAction:(UIBarButtonItem*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{

//    从数据空中查找该用户名下是否有avator 并展示在imagev
    
    
  NSArray * array = [[CoreDataManager shareCoreDataManager] selectPersonManager];
    
    for (PersonManager* person in array) {
        
        if ([person.userName isEqualToString:textField.text]) {
            
             _avatorImagev.image = [UIImage imageWithData:person.avator];
            
        }
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self setUpAvator];
}

#pragma mark- 头像
- (void)setUpAvator{
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults]valueForKey:@"avator"];
    if (imageData == nil) {
        
    }else{
        
        _avatorImagev.image = [UIImage imageWithData:imageData];
    }
}
//切圆角
- (void)cutRound{
    _userView.layer.masksToBounds = YES;
    _userView.layer.cornerRadius = 25;
    
    _passWordView.layer.masksToBounds = YES;
    
    _passWordView.layer.cornerRadius = 25;
    
    _avatorImagev.layer.masksToBounds = YES;
    _avatorImagev.layer.cornerRadius = 83;
    
    _loginBtn.layer.masksToBounds = YES;
    _loginBtn.layer.cornerRadius = 25;
    
    _registerBtn.layer.masksToBounds = YES;
    _registerBtn.layer.cornerRadius = 25;
}
#pragma mark-  登录
- (IBAction)LoginBtn:(UIButton *)sender {
    
    if (_userNameTextField.text.length != 0) {
        
        if (_passWordTextField.text.length != 0) {
            
            EMError *error = [[EMClient sharedClient] loginWithUsername:_userNameTextField.text password:_passWordTextField.text];
        
            if (!error) {
                
//                设置自动登录
                
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                
                [[NSUserDefaults standardUserDefaults]setValue:_userNameTextField.text forKey:@"userName"];
                
//                [[NSUserDefaults standardUserDefaults]setValue:_passWordTextField.text forKey:@"passWord"];
//把userName写入数据库
                
             NSArray* array = [[CoreDataManager shareCoreDataManager] selectPersonManager];
                
                for (PersonManager* person1 in array) {
                    
                    if ([person1.userName isEqualToString:_userNameTextField.text]) {
                        
                        _personManager = person1;
                    }
                }
        
//如果查询不到该用户 就存入数据库  能查询到 就说明注册的时候已经写入数据库
                if (_personManager.userName.length == 0) {
                    
                    NSData* imageData = UIImageJPEGRepresentation(_avatorImagev.image, 0.5);
                    
                    [[CoreDataManager shareCoreDataManager] addObjectContextWithUserName:_userNameTextField.text avator:imageData gender:@"未注册" bornYear:@"未注册" cityName:@"未注册" qqNumber:@"未注册" weChatNumber:@"未注册" weBoNumber:@"未注册" mailboxNumber:@"未注册" phoneNumber:@"未注册" dbName:dataBaseName];
                }
                
                [self.navigationController popToRootViewControllerAnimated:YES];
                NSLog(@"登录成功");
            }else{
                UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"漫漫提示您" message:@"账号或密码错误！" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"哦^………………" style:(UIAlertActionStyleCancel) handler:nil];
                [alertController addAction:confirmAction];
                [self presentViewController:alertController animated:YES completion:nil];
                NSLog(@"账号或密码错误！");
            }
            
        }else{
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"漫漫提示您" message:@"密码不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"哦^………………" style:(UIAlertActionStyleCancel) handler:nil];
            [alertController addAction:confirmAction];
            [self presentViewController:alertController animated:YES completion:nil];
            NSLog(@"密码不能为空！");
        }

      
        
    }else{
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"漫漫提示您" message:@"用户名不能为空！" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"哦^………………" style:(UIAlertActionStyleCancel) handler:nil];
        [alertController addAction:confirmAction];
        [self presentViewController:alertController animated:YES completion:nil];
        NSLog(@"用户名不能为空！");
    }
    
 
    
    
    
}

#pragma mark-  注册（MineStoryBorad 已经拖线）
- (IBAction)registerBtn:(UIButton *)sender {
    
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
