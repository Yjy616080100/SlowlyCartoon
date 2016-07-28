//
//  MineMessageViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "MineMessageViewController.h"

@interface MineMessageViewController ()

@end

@implementation MineMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //leftItem
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc]initWithTitle:@"<个人中心" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftItemAction:)];
    
    
    
    [leftItem setTitleTextAttributes:@{NSFontAttributeName:Font_24} forState:(UIControlStateNormal)];
    
    
    self.navigationItem.leftBarButtonItem = leftItem;
}

-(void)leftItemAction:(UIBarButtonItem*)sender{
    
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
