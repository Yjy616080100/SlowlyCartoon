//
//  RegisterViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
<
    UIImagePickerControllerDelegate,
    UINavigationControllerDelegate
>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = myWhiteColor;
    
    self.usernNameTextField.font = Font_20;
    
    self.passWordTextfield.font = Font_20;
    
    self.confirmBtn.titleLabel.font = Font_22;
    
    self.confirmBtn.backgroundColor = myRedColor;
    
    self.backToLoginBtn.titleLabel.font = Font_22;
    
    self.backToLoginBtn.titleLabel.textColor = myRedColor;
    
    [self.backToLoginBtn setTitleColor:myRedColor forState:(UIControlStateNormal)];
   
//    切圆角
    [self cutRound];
   
//    给_avatorImageV添加点击手势
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAvator:)];
    
    [_avatorImageV addGestureRecognizer:tapGesture];
    
    _avatorImageV.userInteractionEnabled = YES;
    
    //leftItem
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"<个人中心" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftItemAction:)];
    
    
    
    [leftItem setTitleTextAttributes:@{NSFontAttributeName:Font_24} forState:(UIControlStateNormal)];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)leftItemAction:(UIBarButtonItem*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark 选择图片
- (void)selectAvator:(UIGestureRecognizer*)gesture{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    
    imagePickerController.delegate = self;
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"漫漫请您选择方式" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
//    调用相机
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"自拍上传" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
//    相册中选取
    UIAlertAction * photoAlbumAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
//        跳转到 imagePickerController
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
        
    }];
    
//    取消
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cameraAction];
    
    [alertController addAction:photoAlbumAction];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
}
#pragma mark 调用相册 代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    _avatorImageV.image = info[UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark  切圆角
- (void)cutRound{
    _userView.layer.cornerRadius = 25;
    _userView.layer.masksToBounds = YES;
    
    _passWordVIew.layer.cornerRadius = 25;
    _passWordVIew.layer.masksToBounds = YES;
    
//    _avatorImageV.layer.cornerRadius = 83;
//    _avatorImageV.layer.masksToBounds = YES;
    
    
    
    _backToLoginBtn.layer.masksToBounds = YES;
    _backToLoginBtn.layer.cornerRadius = 25;
    
    _confirmBtn.layer.masksToBounds = YES;
    _confirmBtn.layer.cornerRadius = 25;
}

#pragma mark  确认注册
- (IBAction)comfirmRegister:(UIButton *)sender {

//    匹配合法用户名(邮箱和手机号匹配)
    if ([self checkPassword:_usernNameTextField.text]) {
       
//        匹配合法密码
        if ([self checkPassword:_passWordTextfield.text]) {
            //    注册
            EMError *error = [[EMClient sharedClient] registerWithUsername:_usernNameTextField.text password:_passWordTextfield.text];
            
            if (error == nil) {
                NSLog(@"注册=== 成功");
                
                [self successPrompt];
                
            }else{
                NSLog(@"注册=====%@",error);

//         网络错误和用户名已被注册
                
                switch (error.code) {
                    case EMErrorNetworkUnavailable://网络不可用
                        
                        [self showAlertWithTitle:@"" message:@"请检查网路" dalayTime:2];
                        
                        break;
                      
                    case EMErrorUserAlreadyExist://用户名已被注册
                    
                        [self showAlertWithTitle:@"" message:@"该用户名已被注册" dalayTime:2];
                        
                        break;

                    default:
                        break;
                }
       
            }
//            密码不合法
        }else{
            
            [self showAlertWithTitle:@"" message:@"密码必须由6~20位数字或字母构成" dalayTime:2];
        }
        
//  用户名不合法
        
    }else{
        
        [self showAlertWithTitle:@"" message:@"账号由6~20位数字或字母构成" dalayTime:2];
        
    }

    
}
- (IBAction)backToLogin:(UIButton *)sender {
//    返回登录界面
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark-  注册成功提示
- (void)successPrompt{
    //   存入本地
    NSData * imageData = UIImageJPEGRepresentation(_avatorImageV.image, 1);
    [[NSUserDefaults standardUserDefaults]setValue:imageData forKey:@"avator"];
    
//注册成功之后把userName和avator存入数据库
    
    [[CoreDataManager shareCoreDataManager]addObjectContextWithUserName:_usernNameTextField.text avator:imageData gender:@"未填写" bornYear:@"未填写" cityName:@"未填写" qqNumber:@"未填写" weChatNumber:@"未填写" weBoNumber:@"未填写" mailboxNumber:@"未填写" phoneNumber:@"未填写" dbName:dataBaseName];
    
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
}

#pragma mark- 用户名已被注册失败提示
- (void)failurePromptWithErrorMessage:(NSString*)errorMessage{
    
    UIAlertController *  alertController = [UIAlertController alertControllerWithTitle:@"漫漫提示您" message:errorMessage preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"继续注册" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction * backToLoginAction = [UIAlertAction actionWithTitle:@"返回登录" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        //            返回登录界面
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    
    [alertController addAction:confirmAction];
    [alertController addAction:backToLoginAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark-  邮箱匹配

- (BOOL)checkUserNameEmail:(NSString*)email{
    
    //    正则表达式
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailCheck = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailCheck evaluateWithObject:email];
    
}


#pragma mark 手机号匹配
- (BOOL) checkUserNamePhoneNumber:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:mobile];
}

#pragma mark 密码格式匹配

- (BOOL) checkPassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    
    return [passWordPredicate evaluateWithObject:passWord];
}


#pragma mark- 自动消失alertView

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
