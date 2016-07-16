//
//  AboutUsViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "AboutUsViewController.h"

#import "AboutUsTableViewCell.h"
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
                 NSLog(@"====%ld",indexPath.row);
            break;
            
        case 1:
                 NSLog(@"====%ld",indexPath.row);
            break;
            
        case 2:
                NSLog(@"====%ld",indexPath.row);
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
