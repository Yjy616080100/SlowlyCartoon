//
//  MIneDetailViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "MIneDetailViewController.h"

@interface MIneDetailViewController ()

<
    UITableViewDataSource,
    UITableViewDelegate
>
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSArray * dataArray;
@end

@implementation MIneDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
    
    //    关闭滑动
    _tableView.scrollEnabled = NO;

//   初始化数据
    [self setUpDataArray];
//    注册
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
}
//初始化数据
- (void)setUpDataArray{
    _dataArray = @[@[@"头像"],@[@"性别",@"昵称",@"出生年月",@"所在城市"],@[@"QQ",@"微信",@"微博",@"邮箱",@"手机"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -     UITableViewDataSource,UITableViewDelegate

//返回每个分区头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ( section == 0) {
        return 5;
    }
    if (section == 1) {
        return 5;
    }
    return 10;
}
//返回cell高度
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ( indexPath.section == 0) {
        
        return 80;
    }
    return 56;
}
//返回分区数
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _dataArray.count;
}

//返回每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [_dataArray[section] count];
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"reuse"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue2) reuseIdentifier:@"reuse"];
    }
    
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    
    cell.detailTextLabel.text = @"wha are 按时大大";
    
    
    return cell;
    
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
