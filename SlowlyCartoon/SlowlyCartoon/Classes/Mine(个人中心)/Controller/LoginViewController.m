//
//  LoginViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "LoginViewController.h"
//107 255 232 
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    切圆角
    [self cutRound];

    
    
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpAvator];
}
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

                [[NSUserDefaults standardUserDefaults]setValue:_userNameTextField.text forKey:@"userName"];
                [[NSUserDefaults standardUserDefaults]setValue:_passWordTextField.text forKey:@"passWord"];
                
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
