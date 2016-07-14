//
//  SettingViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSArray * dataArray;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
   
//    关闭滑动
    _tableView.scrollEnabled = NO;
    [self setUpDataArray];
    
//注册cell
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
}

- (void)setUpDataArray{
    _dataArray = @[@[@"清理缓存",@"检查更新"],@[@"修改密码",@"退出登录"]];
}
#pragma mark- UITableViewDelegate,UITableViewDataSource
//tableView中的section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
//cell个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count];
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
//cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell ==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"reuse"];
    }
    
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    return cell;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
//         清理缓存
                
                 NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
            }else{
//          检查更新
                 NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
            }
            break;
        case 1:
            if (indexPath.row == 0) {
//         修改密码
                 NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
            }else{
//         退出登录
                 NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
            }
            break;
        default:
            break;
    }
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
