//
//  RankListViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "RankListViewController.h"
#import "RankListTableViewCell.h"
#import "RankListRequest.h"
#import "RankListModel.h"
#import "DetailsViewController.h"

@interface RankListViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property(nonatomic,strong)UITableView *rankListTableView;
//点击按钮，切换展示数据
@property(nonatomic,strong)UIButton *rankListUpBtn;

//装排行数据的小数组
@property(nonatomic,strong)NSMutableArray *rankingArray;
//装最新数据的小数组
@property(nonatomic,strong)NSMutableArray *latestArray;
//检测展示数据类型
@property(nonatomic,assign)int Detection;

@end

@implementation RankListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //数组初始化
    self.rankingArray = [NSMutableArray array];
    self.latestArray = [NSMutableArray array];
    
    //解析数据
    [self rankingRequest];

    
    // 添加tableView
    [self addTableView];
    
    // 添加下面的button按钮
    [self addRankListUpBtn];
 
    //设置最开始的检测状态
    self.Detection = 0;
    
   
}
// 点击按钮刷新tableView 同时改变检测状态
-(void)rankListUpBtnAction:(UIButton *)btn{
    if (self.Detection == 0) {
        //改变检测状态
        self.Detection = 1;
        [self.rankListTableView reloadData];
    }else if (self.Detection == 1) {
        self.Detection = 0;
        [self.rankListTableView reloadData];
    }
}
//解析数据
- (void)rankingRequest
{
    __weak typeof(self) weakSelf = self;
    RankListRequest *request=[[RankListRequest alloc]init];
    [request rankListRequestWithParameter:nil success:^(NSDictionary *dic) {
        //获取排行所有数据
        NSArray *arr = [dic objectForKey:@"rank_comic_info"];
        for (NSDictionary *dict in arr) {
            RankListModel *model=[[RankListModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            
            [weakSelf.rankingArray addObject:model];
        }
        //获取最新所有数据
        NSArray *arr1 = [dic objectForKey:@"newest_comic_list"];
        for (NSDictionary *dict1 in arr1) {
            RankListModel *model=[[RankListModel alloc]init];
            [model setValuesForKeysWithDictionary:dict1];
            
            [weakSelf.latestArray addObject:model];
        }
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.rankListTableView reloadData];
        });
        
    } failure:^(NSError *error) {
    }];
    
}

//点击按钮初始化设置
-(void)addRankListUpBtn{
    
    self.rankListUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rankListUpBtn.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*1/12 );
    self.rankListUpBtn.backgroundColor = [UIColor cyanColor];
    [self.rankListUpBtn addTarget:self action:@selector(rankListUpBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.rankListUpBtn];
    
}

//tableView初始化设置
-(void)addTableView{
    
    self.rankListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height*1/12, self.view.frame.size.width, self.view.frame.size.height*11/12) style:(UITableViewStylePlain)];
    
    [self.rankListTableView registerNib:[UINib nibWithNibName:@"RankListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RankListTableViewCell_Identify];
    
    self.rankListTableView.dataSource = self;
    self.rankListTableView.delegate = self;
    
    [self.view addSubview:self.rankListTableView];
    
    
}
// 设置cell高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
// 设置cell个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //根据检测状态来选择展示的数据类型  (不同数据类型cell个数不一样)
    if (self.Detection == 0) {
        
        return self.rankingArray.count;
    }else{
        
        return self.latestArray.count;
    }
}
// 给cell赋值
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RankListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RankListTableViewCell_Identify];
    RankListModel *model=[[RankListModel alloc]init];
    
    if (self.Detection == 0) {
        model = self.rankingArray[indexPath.row];
    }else if (self.Detection == 1) {
        model = self.latestArray[indexPath.row];
    }
    cell.nameLabel.text = model.comic_name;
    cell.painterLabel.text = model.painter_user_nickname;
    cell.orderidxLabel.text = model.comic_last_orderidx;
    cell.likeLabel.text = [NSString stringWithFormat:@"❤️ %@",model.comic_like_num];
    cell.commentLabel.text = [NSString stringWithFormat:@"✉️ %@",model.comic_comment_num];
    
    // 给图片赋值
    [cell.onluOneImageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.comicq.cn%@",model.comic_pic_240_320]]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailsViewController *detaVC=[[DetailsViewController alloc]init];
    RankListModel *model = [[RankListModel alloc]init];
    if (self.Detection == 0) {
        model = self.rankingArray[indexPath.row];
    }else if (self.Detection == 1) {
        model = self.latestArray[indexPath.row];
    }
    detaVC.onlyID = model.oneID;
    detaVC.onlyTime = model.comic_update_time;
    //跳转
    [self.navigationController pushViewController:detaVC animated:YES];
}


@end
