//
//  OpinionViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "OpinionViewController.h"

@interface OpinionViewController ()<UITextViewDelegate>

@end

@implementation OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _textVIew.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    _textVIew.layer.cornerRadius = 10;
    
    _textVIew.layer.masksToBounds = YES;
    
    _textField.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    _textField.layer.cornerRadius = 5;
    
    _textField.layer.masksToBounds = YES;
    

    _sendBtn.layer.cornerRadius = 10;
    
    _sendBtn.layer.masksToBounds = YES;
    
//    设置代理(拖线已经搞定)
    _textVIew.delegate = self;
    
    
}

//发送
- (IBAction)sendOpinion:(UIButton *)sender {
#warning   根本上没实现  没服务器
    
//        提交意见不能为空
    if (_textVIew.text.length != 0) {
        

    //    邮箱匹配
        if ([self checkContactWayText:_textField.text]) {
            
            [self showAlertWithTitle:@"" message:@"感谢您的评价和关心，我们会尽快联系您!" dalayTime:1.5];
            
            NSLog(@"==============感谢您的评价和关心，我们会尽快联系您!");
            
         }else{
            
              [self showAlertWithTitle:@"" message:@"您的邮箱有误！" dalayTime:2];
         }
        
    }else{
        
       [self showAlertWithTitle:@"" message:@"请填写您的意见！" dalayTime:2];
        
    }

}

#pragma mark- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    _textVIew = textView;
    
    if (textView.text.length ==0) {
        
    _label.text = @"欢迎各位给我们提出宝贵意见";
        
    }else{
        
        _label.text = @"";
        
    }
}

#pragma mark 自动消失alertView

//初始化UIAlertView
- (void)showAlertWithTitle:(NSString*)title message:(NSString*)message dalayTime:(CGFloat)delayTime{
    
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    promptAlert.backgroundColor = [UIColor darkGrayColor];
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:delayTime
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:NO];
    
    [promptAlert show];
}

//UIAlertView 自动消失
- (void)timerFireMethod:(NSTimer*)theTimer
{
    
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    
    [promptAlert dismissWithClickedButtonIndex:0 animated:YES];
    
}


#pragma mark  判断联系方式格式是否正确

- (BOOL)checkContactWayText:(NSString*)email{
    
//    正则表达式
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailCheck evaluateWithObject:email];

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
