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


#define rankListUpBtn_H 40

#define Win_W [UIScreen mainScreen].bounds.size.width

#define Win_H [UIScreen mainScreen].bounds.size.height

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
    //    正在加载
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.color = myRedColor;
    
    hud.detailsLabelFont = Font_16;
    
    hud.detailsLabelText = @"加载中……";
    
    self.view.backgroundColor = myRedColor
    ;
    //数组初始化
    self.rankingArray = [NSMutableArray array];
    
    self.latestArray = [NSMutableArray array];
 
    //解析数据
    [self rankingRequest];
    
    

    // 添加tableView
    [self addTableView];
    
   MJRefreshGifHeader * header  = [MJRefreshGifHeader headerWithRefreshingBlock:^{
       
        [self rankingRequest];
        
    }];
    
    header.stateLabel.font = Font_20;
    
    header.lastUpdatedTimeLabel.font = Font_18;
    
    NSArray * idleImages = @[[UIImage imageNamed:@"1"],[UIImage imageNamed:@"2"]];
    
    NSArray * pullingImages = @[[UIImage imageNamed:@"3"],[UIImage imageNamed:@"4"]];
    
    NSArray * refreshingImages = @[[UIImage imageNamed:@"5"],[UIImage imageNamed:@"6"],[UIImage imageNamed:@"7"],
                                   [UIImage imageNamed:@"8"],[UIImage imageNamed:@"9"],[UIImage imageNamed:@"10"]];
    
//   普通状态下的动画图片
    
    
    [header setImages:idleImages forState:MJRefreshStateIdle];
    
// 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:pullingImages forState:MJRefreshStatePulling];
    
// 设置正在刷新状态的动画图片
    [header setImages:refreshingImages duration:0.34f forState:MJRefreshStateRefreshing];
    
    self.rankListTableView.mj_header = header;
    
//    // 添加下面的button按钮
//    [self addRankListUpBtn];
  
 
    //设置最开始的检测状态
    self.Detection = 0;
    
   
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
            
            RankListModel *model = [[RankListModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [weakSelf.rankingArray addObject:model];
        }
        //获取最新所有数据
        NSArray *arr1 = [dic objectForKey:@"newest_comic_list"];
        
        for (NSDictionary *dict1 in arr1) {
            
            RankListModel *model = [[RankListModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict1];
            
            [weakSelf.latestArray addObject:model];
        }
        //回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                
                [weakSelf.rankListTableView.mj_header endRefreshing];
            
                [weakSelf.rankListTableView reloadData];
            });
        
        } failure:^(NSError *error) {
        
    }];
    
}

//点击按钮初始化设置
-(UIView *)addRankListUpBtn{
    
    self.rankListUpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.rankListUpBtn.frame = CGRectMake(0, 0, Win_W, rankListUpBtn_H );
    
    self.rankListUpBtn.backgroundColor = myRedColor;
    
    if (_Detection) {
        
         [self.rankListUpBtn setImage:[UIImage imageNamed:@"recommend.png"] forState:(UIControlStateNormal)];
        
    }else{
        
         [self.rankListUpBtn setImage:[UIImage imageNamed:@"hot.png"] forState:(UIControlStateNormal)];
        
    }
    
   
    
    self.rankListUpBtn.tintColor = [UIColor whiteColor];
    
    self.rankListUpBtn.titleLabel.font = Font_24;
    
    [self.rankListUpBtn addTarget:self action:@selector(rankListUpBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return self.rankListUpBtn;
}


// 点击按钮刷新tableView 同时改变检测状态
-(void)rankListUpBtnAction:(UIButton *)btn{
    
    if (_Detection) {
        
        //改变检测状态
        _Detection = !_Detection;
        
        
        
        [self.rankListTableView reloadData];
        
    }else{
        
        _Detection = !_Detection;
        
         [self.rankListUpBtn setImage:[UIImage imageNamed:@"hot.png"] forState:(UIControlStateNormal)];
        
        [self.rankListTableView reloadData];
    }
}
//tableView初始化设置


-(void)addTableView{
    
    self.rankListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,69, Win_W, Win_H - 118) style:(UITableViewStylePlain)];
    
    [self.rankListTableView registerNib:[UINib nibWithNibName:@"RankListTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:RankListTableViewCell_Identify];
    
    self.rankListTableView.dataSource = self;
    
    self.rankListTableView.delegate = self;
    
    [self.view addSubview:self.rankListTableView];
    
    
}
// 设置cell高度

#define cellHeight 200
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return cellHeight;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return [self addRankListUpBtn];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return rankListUpBtn_H;
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

#pragma mark  tableView点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //关闭cell的点击效果
    
    [self.rankListTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailsViewController *detaVC=[[DetailsViewController alloc]init];
    
    RankListModel *model = [[RankListModel alloc]init];
    
    if (self.Detection == 0) {
        
        model = self.rankingArray[indexPath.row];
        
    }else if (self.Detection == 1) {
        
        model = self.latestArray[indexPath.row];
    }
    
    detaVC.onlyID = model.oneID;
    
    detaVC.onlyTime = model.comic_update_time;
    
    detaVC.title = model.comic_name;
    
    //跳转
    [self.navigationController pushViewController:detaVC animated:YES];
}


@end
