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
    
    // Do any additional setup after loading the view.
}
- (IBAction)LoginBtn:(UIButton *)sender {
    
}
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
