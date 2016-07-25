//
//  HigtenerViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "HigtenerViewController.h"
#import "higtEnerTableViewCell.h"
#import "HigtEnerModel.h"
#import "HigtEnerRequest.h"

#import "WebViewViewController.h"
@interface HigtenerViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>
@property(nonatomic,strong)UITableView *higtEnerTableView;

// 接收数据的数组
@property(nonatomic,strong)NSMutableArray *higtEnerArray;



@end

@implementation HigtenerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化数组
    self.higtEnerArray = [NSMutableArray array];
    
    //tableView初始化
    self.higtEnerTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-113) style:(UITableViewStylePlain)];
    
    //设置代理
    self.higtEnerTableView.dataSource = self;
    self.higtEnerTableView.delegate = self;
    
    //tableView注册
    [self.higtEnerTableView registerNib:[UINib nibWithNibName:@"HigtEnerTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:HigtEnerTableViewCell_Identify];
    
    [self.view addSubview:self.higtEnerTableView];
    
    // 请求数据
    [self MakeRequest];
    
}
//请求数据
-(void)MakeRequest{
    
    __weak typeof(self)weakSelf = self;
    
    HigtEnerRequest *request = [[HigtEnerRequest alloc] init];
    
    [request higtEnerRequestWithParameter:nil success:^(NSDictionary *dic) {
      
        NSDictionary *dict1 = dic[@"data"];
        
        NSArray *array = dict1[@"active_arr"];
        
        for (NSDictionary *dict2 in array) {
            
            HightEnerModel *model = [HightEnerModel new];
            
            [model setValuesForKeysWithDictionary:dict2];
            
            [weakSelf.higtEnerArray addObject:model];
            
            //回到主线程刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.higtEnerTableView reloadData];
            });
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"errot --------------- %@",error);
    }];
    
    
}

//设置cell高度
#define cellHeight 200
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return cellHeight;
}

//设置cell个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.higtEnerArray.count;
}

//给cell赋值
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HigtEnerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HigtEnerTableViewCell_Identify];
    
    HightEnerModel *model = self.higtEnerArray[indexPath.row];
    
    [cell.higtEnerImageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.comicq.cn%@",model.active_pic_url_1]]];
    
    cell.HightEnerLabel.text = model.active_name;
    
    return cell;
}
//cell的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //关闭cell的点击效果
    
    [self.higtEnerTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HightEnerModel *model = self.higtEnerArray[indexPath.row];
    
    WebViewViewController *webVC=[[WebViewViewController alloc]init];
    
    webVC.urlString = model.active_desc_url;
    //跳转页面
    [self.navigationController pushViewController:webVC animated:YES];
}












@end
