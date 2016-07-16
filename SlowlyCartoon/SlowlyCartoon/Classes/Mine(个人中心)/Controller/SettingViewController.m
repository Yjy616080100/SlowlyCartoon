//
//  SettingViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "SettingViewController.h"

#import "MineSettingTableViewCell.h"
@interface SettingViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSArray * dataArray;

@property (strong, nonatomic) NSString * cacheSize;
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   _tableView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
   
//    关闭滑动
    _tableView.scrollEnabled = NO;
    [self setUpDataArray];
    
//注册cell
    [_tableView registerNib:[UINib nibWithNibName:@"MineSettingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MineSettingTableViewCell_Identify];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    计算缓存
    [self appearCache];
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
    
    MineSettingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:MineSettingTableViewCell_Identify];
    
    if (cell ==nil) {
        cell = [[MineSettingTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:MineSettingTableViewCell_Identify];
    }
    cell.contentLabel.text = _dataArray[indexPath.section][indexPath.row];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.detailLbel.text = _cacheSize;
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.detailLbel.text = @"当前版本:V1.0.1";
    }

    return cell;
}
//点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
//         清理缓存
                [self removeCache];
                 NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
            }else{
//          检查更新
                
                [self checkUpdate];
                 NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
            }
            break;
        case 1:
            if (indexPath.row == 0) {
//         修改密码
                [self changePassWord];
                 NSLog(@"%ld====%ld",indexPath.section,indexPath.row);
            }else{
#pragma mark  退出登录
                [self signOut];
            }
            break;
        default:
            break;
    }
}
#pragma mark 修改密码
- (void)changePassWord{
    
}
#pragma mark 检查更新
- (void)checkUpdate{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"漫漫提示您" message:@"当前已是最新版" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"知道了%……&*" style:(UIAlertActionStyleCancel) handler:nil];
    
    [alertController addAction:confirmAction];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

#pragma mark 获取和清理缓存

- (void)removeCache{
    NSString* message = [NSString stringWithFormat:@"缓存大小为%@，是否清除",_cacheSize];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"漫漫提示您" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        NSString* cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        [self clearCache:cacheDir];
    }];
    [alertVC addAction:cancelAction];
    [alertVC addAction:confirmAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}
- (void)appearCache{
    _cacheSize = [NSString stringWithFormat:@"%.2fM",[self getFilePath]];
    [_tableView reloadData];
}
//获取缓存大小
-(float)getFilePath{
    
    //文件管理
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //缓存路径
    
    NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
    
    NSString *cacheDir = [cachePaths objectAtIndex:0];
    
    NSArray *cacheFileList;
    
    NSEnumerator *cacheEnumerator;
    
    NSString *cacheFilePath;
    
    unsigned long long cacheFolderSize = 0;
    
    cacheFileList = [fileManager subpathsOfDirectoryAtPath:cacheDir error:nil];
    
    cacheEnumerator = [cacheFileList objectEnumerator];
    
    while (cacheFilePath = [cacheEnumerator nextObject]) {
        
        NSDictionary * cacheFileAttributes = [fileManager attributesOfItemAtPath:[cacheDir stringByAppendingPathComponent:cacheFilePath] error:nil];
        
        cacheFolderSize += [cacheFileAttributes fileSize];
        
    }
    
    //单位MB
    
    return cacheFolderSize/1024/1024;
    
}

//清理缓存方法
- (void)clearCache:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [self appearCache];
}
    
#pragma mark   退出登录
- (void)signOut{
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"漫漫提示您" message:@"退出登录" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction * confirmAction = [UIAlertAction actionWithTitle:@"哦 ………" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"avator"];
        
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"passWord"];
        
        NSLog(@"本地退出成功");
        
        EMError *error = [[EMClient sharedClient] logout:YES];
        
        if (!error) {
            
            NSLog(@"退出成功");
        }
    }];
    
    UIAlertAction * cancleAction = [UIAlertAction actionWithTitle:@"噢^ NO ……" style:(UIAlertActionStyleCancel) handler:nil];
    
    [alertController addAction:confirmAction];
    
    [alertController addAction:cancleAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
 
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
