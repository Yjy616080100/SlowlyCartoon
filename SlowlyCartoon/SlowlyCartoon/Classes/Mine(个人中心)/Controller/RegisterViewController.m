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

//    切圆角
    [self cutRound];
   
//    给_avatorImageV添加点击手势
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectAvator:)];
    
    [_avatorImageV addGestureRecognizer:tapGesture];
    
    _avatorImageV.userInteractionEnabled = YES;
    
    
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
- (IBAction)comfirmRegister:(UIButton *)sender {
    
//    注册
    EMError *error = [[EMClient sharedClient] registerWithUsername:_usernNameTextField.text password:_passWordTextfield.text];
    if (error == nil) {
        NSLog(@"注册=== 成功");
//   存入本地
        NSData * imageData = UIImageJPEGRepresentation(_avatorImageV.image, 1);
        [[NSUserDefaults standardUserDefaults]setValue:imageData forKey:@"avator"];
        
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
