//
//  LoginViewController.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *fastLogin;
@property (strong, nonatomic) IBOutlet UIImageView *avatorImagev;
@property (strong, nonatomic) IBOutlet UIImageView *userBGImage;
@property (strong, nonatomic) IBOutlet UIImageView *passBGImage;
@property (strong, nonatomic) IBOutlet UITextField *passWordTextField;
@property (strong, nonatomic) IBOutlet UITextField *userNameTextField;
@property (strong, nonatomic) IBOutlet UIView *userView;
@property (strong, nonatomic) IBOutlet UIView *passWordView;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;



@end
