//
//  RegisterViewController.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *avatorImageV;
@property (strong, nonatomic) IBOutlet UITextField *usernNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passWordTextfield;
@property (strong, nonatomic) IBOutlet UIView *userView;
@property (strong, nonatomic) IBOutlet UIView *passWordVIew;

@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;
@property (strong, nonatomic) IBOutlet UIButton *backToLoginBtn;


@end
