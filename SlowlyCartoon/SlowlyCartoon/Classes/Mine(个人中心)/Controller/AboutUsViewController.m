//
//  AboutUsViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "AboutUsViewController.h"

#import "AboutUsTableViewCell.h"

#import "WebViewController.h"
//241   ,241,241
@interface AboutUsViewController ()
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSArray * dataArray;
@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    //    关闭滑动
    _tableView.scrollEnabled = NO;
    
    [self setUpDataArray];
    
    //注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"AboutUsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:AboutUsTableViewCell_Identify];
    
}
//视图即将出现
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    显示tabBar
    self.tabBarController.tabBar.hidden = NO;
}
//初始化数据数组

- (void)setUpDataArray{
    _dataArray = @[@"去评分",@"软件介绍",@"检查更新"];
}

#pragma mark- UITableViewDelegate,UITableViewDataSource

//cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AboutUsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:AboutUsTableViewCell_Identify];
    
    if (cell ==nil) {
        cell = [[AboutUsTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:AboutUsTableViewCell_Identify];
    }
    
    cell.contentLabel.text = _dataArray[indexPath.row];
    if (indexPath.row == 2) {
        cell.datailLabel.text = @"当前版本:V1.0.1";
    }
    return cell;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
 
        case 0:
//    去评分
            [self goToAppraise];
            break;
            
        case 1:
            
//    软件介绍
            
                 NSLog(@"====%ld",indexPath.row);
            break;
            
        case 2:
//    检查更新
            
            [self checkUpdate];
            
                NSLog(@"====%ld",indexPath.row);
            break;
        default:
            break;
    }
}

#pragma mark 检查更新
- (void)checkUpdate{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"漫漫提示您" message:@"当前已是最新版" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"知道了%……&*" style:(UIAlertActionStyleCancel) handler:nil];
    
    [alertController addAction:confirmAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark 去评价 Appraise（评价）
- (void)goToAppraise{
   
    UIStoryboard * SB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    
    WebViewController * webViewVC = [SB instantiateViewControllerWithIdentifier:@"WebViewController"];

//    传参 URL
    
    webViewVC.URL = @"http://www.apple.com/cn/itunes/charts/free-apps/";
    
    [self.navigationController pushViewController:webViewVC animated:YES];
    
//    干掉tabBar
    
    self.tabBarController.tabBar.hidden = YES;
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
