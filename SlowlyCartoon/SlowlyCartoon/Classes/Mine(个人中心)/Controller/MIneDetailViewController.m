//
//  MIneDetailViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "MIneDetailViewController.h"

#import "MineDetailTableViewCell.h"


#import "MineDetailHeadCell.h"

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
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MineDetailTableViewCell_Identify];
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineDetailHeadCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MineDetailHeadCell_Identify];
    
//    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuse"];
}
//初始化数据
- (void)setUpDataArray{
    _dataArray = @[@[@"头像"],@[@"账户",@"性别",@"出生年月",@"所在城市"],@[@"QQ",@"微信",@"微博",@"邮箱",@"手机"]];
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
        
        return 100;
    }
    return 50;
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
//  第一分区
    if ( indexPath.section == 0) {
        
        MineDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:MineDetailHeadCell_Identify];
    
        if (cell == nil) {
            
            cell = [[MineDetailHeadCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:MineDetailHeadCell_Identify];
            
        }
        NSData * imageData = [[NSUserDefaults standardUserDefaults] valueForKey:@"avator"];
        
        if (imageData != nil) {
            
            cell.avatorImage.image = [UIImage imageWithData:imageData];
        }
    
        cell.contentLabel.text = _dataArray[indexPath.section][indexPath.row];
        return cell;
    }
// 其他分区
    MineDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MineDetailTableViewCell_Identify];
    
    if (cell == nil) {
        
        cell = [[MineDetailTableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:MineDetailTableViewCell_Identify];
    }
    
    cell.comentLabel.text = _dataArray[indexPath.section][indexPath.row];
    
    NSString * userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
    
    if (indexPath.row == 0 && userName.length != 0 ) {
        
        cell.detailLabel.text = userName;
        
    }
    
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    关闭tableViewcel点击状态
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
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
