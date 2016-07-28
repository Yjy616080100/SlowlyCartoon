//
//  WebViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:_URL]];
    
///自动适应全屏网页
    
    _webView.scalesPageToFit = YES;
    
//添加放大手势
//    [self addGesure];
    [_webView loadRequest:request];

    //leftItem
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"<个人中心" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftItemAction:)];
    
    
    
    [leftItem setTitleTextAttributes:@{NSFontAttributeName:Font_24} forState:(UIControlStateNormal)];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)leftItemAction:(UIBarButtonItem*)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark  添加手势
//- (void)addGesure{
//    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
//    
//    tapGesture.numberOfTapsRequired = 2;
//    
//   
//    
//    [_webView addGestureRecognizer:tapGesture];
//}

//手势target
//- (void)pinchAction:(UIGestureRecognizer *)gesture{
//     NSLog(@"===============");
//    
//}
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
