//
//  OpinionViewController.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OpinionViewController : UIViewController
//意见输入 textView
@property (strong, nonatomic) IBOutlet UITextView *textVIew;

//联系方式（邮箱）
@property (strong, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic) IBOutlet UIButton *sendBtn;

//textView上的Label
@property (strong, nonatomic) IBOutlet UILabel *label;

@end
