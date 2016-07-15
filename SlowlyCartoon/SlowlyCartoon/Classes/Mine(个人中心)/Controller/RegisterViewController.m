//
//  RegisterViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    切圆角

    _userView.layer.cornerRadius = 25;
    _userView.layer.masksToBounds = YES;
    
    _passWordVIew.layer.cornerRadius = 25;
    _passWordVIew.layer.masksToBounds = YES;
    
    _avatorImageV.layer.cornerRadius = 83;
    _avatorImageV.layer.masksToBounds = YES;
    
    _backToLoginBtn.layer.masksToBounds = YES;
    _backToLoginBtn.layer.cornerRadius = 25;
    
    _confirmBtn.layer.masksToBounds = YES;
    _confirmBtn.layer.cornerRadius = 25;
    
    
}
- (IBAction)comfirmRegister:(UIButton *)sender {
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:_usernNameTextField.text password:_passWordTextfield.text];
    if (error == nil) {
        NSLog(@"注册=== 成功");
        
        NSString * log = [NSString stringWithFormat:@"%@,恭喜您注册成功！",_passWordTextfield.text];
        UIAlertController *  alertController = [UIAlertController alertControllerWithTitle:@"漫漫提示您" message:log preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"继续注册" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction * backToLoginAction = [UIAlertAction actionWithTitle:@"返回登录" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        
        [alertController addAction:confirmAction];
        [alertController addAction:backToLoginAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        
        UIAlertController *  alertController = [UIAlertController alertControllerWithTitle:@"漫漫提示您" message:@"该账号已被注册！"preferredStyle:(UIAlertControllerStyleAlert)];
        
        UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"继续注册" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction * backToLoginAction = [UIAlertAction actionWithTitle:@"返回登录" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
//            返回登录界面
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        
        
        [alertController addAction:confirmAction];
        [alertController addAction:backToLoginAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
        NSLog(@"注册=====%@",error);
    }
    
}
- (IBAction)backToLogin:(UIButton *)sender {
//    返回登录界面
    [self.navigationController popViewControllerAnimated:YES];
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
