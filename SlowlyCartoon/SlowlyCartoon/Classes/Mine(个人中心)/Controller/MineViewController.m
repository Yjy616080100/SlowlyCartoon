//
//  MineViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "MineViewController.h"

#import "LoginViewController.h"

#import "SettingViewController.h"

#import "ContactViewController.h"

#import "AboutUsViewController.h"

#import "MineTableViewCell.h"

#import "MineHeaderViewCell.h"

#import "MineMessageViewController.h"

#import "OpinionViewController.h"

#import "MIneDetailViewController.h"

//107/255.0 green:1 blue:232/255.0 alpha:1

@interface MineViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>

//tableView
@property(strong ,nonatomic) UITableView * tableView;

//数据数组
@property(strong , nonatomic) NSArray * dataArray;

//图片
@property(strong, nonatomic) NSArray * imageArray;

//头像
@property (strong, nonatomic)UIImage * avator;

//判断是否登录
//@property (strong, nonatomic)NSString * name;
@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //    初始化dataArray  确定数据
    
    [self setUpDataArray];
    
    //    初始化tableView
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:(UITableViewStyleGrouped)];
    
    _tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];

    //    _tableView.userInteractionEnabled = NO; 用户交互开关
    
    _tableView.scrollEnabled = NO;  //滑动开关
    
    //    设置代理
    
    _tableView.delegate = self;
    
    _tableView.dataSource = self;
    
    //    注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"MineTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MineTableViewCell_Identify];
    
    
    [_tableView registerNib:[UINib nibWithNibName:@"MineHeaderViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MineHeaderViewCell_Identify];
    
    //    去掉tableVieCell分割线
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

#pragma mark- 刷新数据
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    登录成功获取avator
//    NSData * imageData = [[NSUserDefaults standardUserDefaults]valueForKey:@"avator"];
    
//    if (imageData != nil) {
//        _avator = [UIImage imageWithData:imageData];
//    }
//    
//    _name = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
    
//    显示tabBar
    self.tabBarController.tabBar.hidden = NO;
    
    [_tableView reloadData];
}

#pragma mark- 数据数组懒加载 (构造二维数据数组)
- (void)setUpDataArray{
    
    _dataArray = @[@[@"登录/注册"],@[@"我的消息",@"设置"],@[@"意见反馈",@"联系我们",@"关于"]];
    
    _imageArray = @[@[@"avator"],@[@"mineMessage",@"setting"],@[@"opinion",@"contact",@"aboutUs"]];
}



#pragma mark-     UITableViewDataSource,UITableViewDelegate

//tableView中的section个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
//每个section中row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count];
}
//HeaderViewHeight
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//每个cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }
    return 75;
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( indexPath.section == 0) {
        MineHeaderViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MineHeaderViewCell_Identify];
        
        if (cell == nil) {
            cell = [[MineHeaderViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:MineHeaderViewCell_Identify];
        }

        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
//        判断是否登录
      
        
        NSString * userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
        
        NSData * avatorData = [[NSUserDefaults standardUserDefaults] valueForKey:@"avator"];
        
        UIImage * avatorImage = [UIImage imageWithData:avatorData];
    
//        如果登陆
        if (userName.length != 0) {
            
            cell.contentField.text = userName;
            
//            有头像
            if (avatorData != nil) {
                
                cell.avatorImage.image = avatorImage;
            }
          
//        没有登陆
        }else{
//            默认头像等
            cell.contentField.text = _dataArray[indexPath.section][indexPath.row];
            
            cell.avatorImage.image = [UIImage imageNamed:_imageArray[indexPath.section][indexPath.row]];
        }
        
        return cell;
    }
    
    MineTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:MineTableViewCell_Identify];
    
    if (cell == nil) {
        cell = [[MineTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:MineTableViewCell_Identify];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    
    
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    cell.contentField.text = _dataArray[indexPath.section][indexPath.row];
    
    cell.imageV.image = [UIImage imageNamed:_imageArray[indexPath.section][indexPath.row]];
    
    return cell;
}


//tableview点击事件

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    关闭tableViewcel点击状态
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    获取当前的 UIStoryboard
    
        UIStoryboard * SB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    switch (indexPath.section) {
            
        case 0:
            //   登录/注册
            if (indexPath.row == 0) {
                
                NSString * userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
                
                if (userName.length != 0) {
//                    登录成功之后 
                    MIneDetailViewController * detailVC = [SB instantiateViewControllerWithIdentifier:@"MIneDetailViewController"];
                    
                    [self.navigationController pushViewController:detailVC animated:YES];
                    
                    self.tabBarController.tabBar.hidden = YES;
                }else{
//          未登录  去登录
                    LoginViewController * loginVC = [SB instantiateViewControllerWithIdentifier:@"LoginViewController"];
                    
                    [self.navigationController pushViewController:loginVC animated:YES];
                    
                    self.tabBarController.tabBar.hidden = YES;
                }
             
            }
            break;
            
            
        case 1:
            
            if (indexPath.row == 0) {
                //    我的消息
                MineMessageViewController * messageVC = [SB instantiateViewControllerWithIdentifier:@"MineMessageViewController"];
                
                [self.navigationController pushViewController:messageVC animated:YES];
                
                self.tabBarController.tabBar.hidden = YES;
                
                NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
            }else{
                //      设置
                SettingViewController * settingVC = [SB instantiateViewControllerWithIdentifier:@"SettingViewController"];
                
                [self.navigationController pushViewController:settingVC animated:YES];
                
                self.tabBarController.tabBar.hidden = YES;
                
                NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
            }
            
            break;
            
            
        case 2:
            if (indexPath.row == 0) {
                //      意见反馈
                OpinionViewController * opinionVC = [SB instantiateViewControllerWithIdentifier:@"OpinionViewController"];
                
                [self.navigationController pushViewController:opinionVC animated:YES];
                
                self.tabBarController.tabBar.hidden = YES;
                
                NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
                
            }else if(indexPath.row == 1){
                //         联系我们
                ContactViewController * contactVC = [SB instantiateViewControllerWithIdentifier:@"ContactViewController"];
                
                [self.navigationController pushViewController:contactVC animated:YES];
                
                self.tabBarController.tabBar.hidden = YES;
                
                NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
                
            }else{
                //          关于
                AboutUsViewController * aboutVC = [SB instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
                
                [self.navigationController pushViewController:aboutVC animated:YES];
                
                self.tabBarController.tabBar.hidden = YES;
                
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
