//
//  RecommendViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "RecommendViewController.h"
#import "RecommendRequest.h"
#import "firstScrollViewModel.h"
#import "oneTableViewModel.h"
#import "itemizeScrollViewModel.h"
#import "lastCollectionViewModel.h"

#import "OneTableViewCell.h"
#import "LastCollectionViewCell.h"

#import "WebViewViewController.h"
#import "DetailsViewController.h"

@interface RecommendViewController ()
<
UIScrollViewDelegate,
UITableViewDataSource,
UITableViewDelegate,
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource
>

@property(nonatomic,strong)UIScrollView *recommendScrollView;//最底层的UIScrollView

@property(nonatomic,strong)UIScrollView *firstScrollView;//最上面的轮播图

@property(nonatomic,strong)UIPageControl *pageControl;//轮播图下面的分页按钮

@property(nonatomic,strong)NSTimer *timer;//创建一个定时器用于轮播图

@property(nonatomic,strong)UITableView *oneTableView;//tableView用于展示

@property(nonatomic,strong)UIScrollView *ItemizeScrollView;//分类展示的ScrollView

@property(nonatomic,strong)UICollectionView *lastCollectionView;//最下面的CollectionView


@property(nonatomic,strong)NSMutableArray *firstArray;//装顶部轮播图数据的数组

@property(nonatomic,strong)NSMutableArray *oneArray;//装tableVIew数据的数组

@property(nonatomic,strong)NSMutableArray *itemizeArray;//装ScrollView数据的数组

@property(nonatomic,strong)NSMutableArray *lastArray;//装collectionView数据的数组

@property(nonatomic,strong)NSString *recommendString;//接收图片url

@property(nonatomic,strong)NSString *likeSrting;//接收图片url

@property(nonatomic,strong)NSString *hotString;//接收图片url

@end

@implementation RecommendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    //    正在加载
  MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.color = myRedColor;
    
    hud.detailsLabelFont = Font_16;
    
    hud.detailsLabelText = @"加载中……";

 //请求数据
    [self requestRecommend];
    
    _oneTableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        // 进入刷新状态后会自动调用这个block
         [self requestRecommend];
    }];
   
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
}

//添加最底层的UIScrollView
- (void)addUnderlyingScrollView
{
    // 初始化
    self.recommendScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //
    self.recommendScrollView.bounces = YES;
    
    self.recommendScrollView.contentSize = CGSizeMake(0, self.view.frame.size.height*7);
    
    self.recommendScrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.recommendScrollView];

}




//添加最上面轮播图
- (void)addTheFirstScrollView
{
    //初始化
    self.firstScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    //设置整夜滑动
    self.firstScrollView.pagingEnabled = YES;
    
    self.firstScrollView.contentSize = CGSizeMake(self.view.frame.size.width*(self.firstArray.count+2),0);
    
    self.firstScrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    
    self.firstScrollView.backgroundColor = [UIColor whiteColor];
    //设置代理
    self.firstScrollView.delegate = self;
    
    self.firstScrollView.showsHorizontalScrollIndicator = NO;
    
    [self.recommendScrollView addSubview:self.firstScrollView];
    
    //添加button
    [self buttonImage];
    

    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.firstScrollView.frame.size.width - 80, self.firstScrollView.frame.size.height - 30, 60, 30)];
    
    //没有点击的小按钮的颜色
    self.pageControl.pageIndicatorTintColor = myRedColor;
    
    //点击的小按钮的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    
    //设置按钮个数
    self.pageControl.numberOfPages = _firstArray.count;
    
    //设置按钮起点
    self.pageControl.currentPage = 0;
    
    //添加点击事件
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    
    [self.recommendScrollView addSubview:self.pageControl];
    
}
//给每一个点击按钮添加图片
- (void)buttonImage
{
    
    for (int i=0; i<_firstArray.count+2; i++) {
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.firstScrollView.frame.size.height);
        
        NSInteger index = i - 1;
        
        if (i == 0) {
            
            index = _firstArray.count -1;
            
        }else if (i == _firstArray.count +1) {
            
            index = 0;
        }
        //根据标记从model里面取值
        firstScrollViewModel *model=_firstArray[index];
        
        NSString *str = [NSString stringWithFormat:@"http://www.comicq.cn%@",model.active_pic_url_2];
        
        [button setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]] forState:UIControlStateNormal];
        
        //标记button对应数组里面哪一个数据
        
        button.tag = 999+index;
        
        //button的点击方法
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self.firstScrollView addSubview:button];
    }
}
//轮播图按钮点击事件
- (void)buttonAction:(UIButton *)sender
{
    //获取点击的model
    long a = sender.tag-999;
    firstScrollViewModel *model = [[firstScrollViewModel alloc]init];
    model = self.firstArray[a];
    
    if (model.active_desc_url.length != 0) {
        
        //如果有这个URL 跳转到网页
        WebViewViewController *webVC=[[WebViewViewController alloc]init];
        
        webVC.urlString = model.active_desc_url;
        
//        self.tabBarController.tabBar.hidden = YES;
        
        [self.navigationController pushViewController:webVC animated:YES];
        
    }else {
        //如果没有这个URL 跳转到cell详情页面
        DetailsViewController *detaVC=[[DetailsViewController alloc]init];
        
        detaVC.onlyID = model.oneID;
        
//        self.tabBarController.tabBar.hidden = YES;
        
        //跳转
        [self.navigationController pushViewController:detaVC animated:YES];
    }
    
}
//通过scrollView代理方法 测定偏移量
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView//scrollView代理方法
{
    CGFloat scrollviewW =  scrollView.frame.size.width;
    
    if (scrollView == _firstScrollView) {
        
        NSInteger index = scrollView.contentOffset.x/scrollviewW;
        
        NSInteger pageIndex = index-1;
        if (index == _firstArray.count+1) {
          scrollView.contentOffset = CGPointMake(scrollviewW, 0);
            pageIndex = 0;
        }else if (index == 0) {
            scrollView.contentOffset = CGPointMake(scrollviewW *(_firstArray.count), 0);
            pageIndex = _firstArray.count-1;
        }
        _pageControl.currentPage = pageIndex;
    }
}
- (void)changePage:(UIPageControl *)page
{
    int a = (int)page.currentPage;
    
    self.firstScrollView.contentOffset = CGPointMake(self.firstScrollView.frame.size.width * a, 0);
}
//// 开始拖拽的时候调用
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
////    关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
//    [self.timer invalidate];
//}
////拖拽减速的时候调用
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
////    开启定时器
//    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
//}
//- (void)nextImage //定时器的方法
//{
//    int page = (int)self.pageControl.currentPage;
//    if (page == 4) {
//        page = 0;
//    }else{
//        page++;
//    }
//    CGFloat x = page * self.firstScrollView.frame.size.width;
//    self.firstScrollView.contentOffset = CGPointMake(x, 0);
//}





//添加第一个tableView
- (void)addOneTableView
{
    self.oneTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.firstScrollView.frame.size.height, self.recommendScrollView.frame.size.width, 2520) style:UITableViewStyleGrouped];
    
    //禁止tableView滑动
    self.oneTableView.scrollEnabled = NO;
    
 
    //注册
    [self.oneTableView registerNib:[UINib nibWithNibName:@"OneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:OneTableViewCell_Identify];
    
    self.oneTableView.delegate = self;
    
    self.oneTableView.dataSource = self;
    
    [self.recommendScrollView addSubview:self.oneTableView];
}
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.oneArray[section] count];
}
//给cell赋值
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OneTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:OneTableViewCell_Identify];
    
    oneTableViewModel *model=self.oneArray[indexPath.section][indexPath.row];
    
    cell.nameLabel.text = model.comic_name;
    
    cell.descLabel.text = model.comic_desc;
    
    NSString *str=[NSString stringWithFormat:@"http://www.comicq.cn%@",model.comic_pic_720_520];
    
    [cell.imageV setImageWithURL:[NSURL URLWithString:str]];
    
    return cell;
}
//分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.oneArray.count;
}
//点击cell  实现跳转页面和传值
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //关闭cell的点击效果
    
    [self.oneTableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //传参数
    oneTableViewModel *model = self.oneArray[indexPath.section][indexPath.row];
    
    DetailsViewController *detaVC = [[DetailsViewController alloc]init];
    
    detaVC.onlyID = model.oneID;
    
    detaVC.onlyTime = model.comic_update_time;
    
    detaVC.title = model.comic_name;
    //跳转
    [self.navigationController pushViewController:detaVC animated:YES];
}
// 给tableView 设置分区视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIImageView *imageV1=[[UIImageView alloc]init];
    
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(30, 10, 354, 30)];
    
    if (section == 0) {
        
        [imageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.comicq.cn%@",self.recommendString]]];
        
    }else{
        
        [imageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.comicq.cn%@",self.hotString]]];
    }
    
    [imageV1 addSubview:imageV];
    
    return imageV1;
}
// 设置分区视图高度

#define sectionHeight 50

#define cellHeight 220
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return sectionHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 10;
}
// 给cell设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
}



//添加分类展示的ScrollView
- (void)addItemizeScrollView
{
    self.ItemizeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.oneTableView.frame) + 10, self.recommendScrollView.frame.size.width, 130)];
    
    self.ItemizeScrollView.contentSize = CGSizeMake(self.recommendScrollView.frame.size.width*3-110, 0);
    
    self.ItemizeScrollView.backgroundColor = [UIColor whiteColor];
    
    [self.recommendScrollView addSubview:self.ItemizeScrollView];
    
    [self addsmallButton];
}
// 给ScrollView 添加button

- (void)addsmallButton
{
    for (int i=0; i<_itemizeArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //标记button
        button.tag = 1999 + i;
        
        if (i == 0) {
            
            button.frame = CGRectMake(i*180+35, 15, 180, self.ItemizeScrollView.frame.size.height - 30);
            
        }else{
            
            button.frame = CGRectMake(i*215+35, 15, 180, self.ItemizeScrollView.frame.size.height - 30);
        }
        
        NSMutableArray *arr=[NSMutableArray array];
        
        for (itemizeScrollViewModel *model in self.itemizeArray) {
            
            NSString *str=[NSString stringWithFormat:@"http://www.comicq.cn%@",model.topic_pic_url];
            
            [arr addObject:str];
        }
        // 给button添加背景图片
        [button setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arr[i]]]] forState:UIControlStateNormal];
        //给button添加点击事件
        
        [self.ItemizeScrollView addSubview:button];
    }
}

#define HPadding 25
#define VPadding 15
- (void)addLastCollectionView
{
    //创建
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    
    //cell 的size
    flowLayout.itemSize=CGSizeMake(100, 165);
    
    //cell 的 最小列间距
    flowLayout.minimumInteritemSpacing= HPadding;
    
    //cell 的 最小行间距
    flowLayout.minimumLineSpacing= VPadding;
    
    //cell 的 滚动状态（横着或者竖着滚动视图）
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    //cell 的 每个分区边缘的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 20, 20);
    
    //设置头高
    flowLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 30);

    self.lastCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.ItemizeScrollView.frame), 414, 2200) collectionViewLayout:flowLayout];
    
    //设置代理
    self.lastCollectionView.delegate = self;
    
    self.lastCollectionView.dataSource = self;
    //注册
    [self.lastCollectionView registerNib:[UINib nibWithNibName:@"LastCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:LastCollectionViewCell_Identify];
    
    //禁止CollectionView 滑动
    self.lastCollectionView.scrollEnabled=NO;
    
    self.lastCollectionView.backgroundColor=[UIColor whiteColor];
    
    [self.recommendScrollView addSubview:self.lastCollectionView];
}
//设置cell个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.lastArray.count;
}

//给cell赋值
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LastCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:LastCollectionViewCell_Identify forIndexPath:indexPath];
    lastCollectionViewModel *model=self.lastArray[indexPath.row];
    
    [cell.imageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.comicq.cn%@",model.comic_pic_240_320]]];
    cell.nameLabel.text = model.comic_name;
    cell.orderidxLabel.text = [NSString stringWithFormat:@"%@话",model.comic_last_orderidx];
    
    return cell;
}
//点击cell实现的方法
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    lastCollectionViewModel *model = self.lastArray[indexPath.row];
    DetailsViewController *detaVC = [[DetailsViewController alloc]init];
    detaVC.onlyID = model.oneID;
    detaVC.onlyTime = model.comic_update_time;
    //跳转
    [self.navigationController pushViewController:detaVC animated:YES];
}







- (void)requestRecommend
{

    self.firstArray = [NSMutableArray array];
    
    self.oneArray = [NSMutableArray array];
    
    self.itemizeArray = [NSMutableArray array];
    
    self.lastArray = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    
    RecommendRequest *request = [[RecommendRequest alloc]init];
    
    [request recommentRequestWithParameter:nil success:^(NSDictionary *dic) {
        //装轮播图数组
        NSDictionary *dict1 = [dic objectForKey:@"data"];
        
        NSArray *arr1 = [dict1 objectForKey:@"index_head_arr"];
        
        for (NSDictionary *dict2 in arr1) {
            
            firstScrollViewModel *model = [[firstScrollViewModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict2];
            
            [weakSelf.firstArray addObject:model];
        }
        //NSLog(@"++++++++++%@",self.firstArray);
        
        
        
        //装中部轮播图案数组
        NSArray *arr2 = [dict1 objectForKey:@"index_topic_arr"];
        
        for (NSDictionary *dict3 in arr2) {
            
            itemizeScrollViewModel *model = [[itemizeScrollViewModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict3];
            
            [weakSelf.itemizeArray addObject:model];
        }
        //NSLog(@"-------------%@",weakSelf.itemizeArray);
        
        
        
        //tableView数组
        NSMutableArray *array1=[NSMutableArray array];
        
        NSMutableArray *array2=[NSMutableArray array];
        
        NSDictionary *dict4 = [dict1 objectForKey:@"index_comic_arr"];
        
        //三个图片的字符串
        weakSelf.recommendString = [dict4 objectForKey:@"recommend_title_pic_url"];
        
        weakSelf.likeSrting = [dict4 objectForKey:@"like_title_pic_url"];
        
        weakSelf.hotString = [dict4 objectForKey:@"hot_title_pic_url"];

        NSArray *arr3 = [dict4 objectForKey:@"recommend_comic_arr"];
        
        for (NSDictionary *dict5 in arr3) {
            
            oneTableViewModel *model=[[oneTableViewModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict5];
            
            [array1 addObject:model];
        }
        NSArray *arr4 = [dict4 objectForKey:@"hot_comic_arr"];
        
        for (NSDictionary *dict6 in arr4) {
            
            oneTableViewModel *model = [[oneTableViewModel alloc]init];
            
            [model setValuesForKeysWithDictionary:dict6];
           
            [array2 addObject:model];
        }
        [weakSelf.oneArray addObject:array1];
        [weakSelf.oneArray addObject:array2];
        //NSLog(@"******************* %@",weakSelf.oneArray);
        
        
        
        //装CollectionView数组
        NSArray *array7 = [dict4 objectForKey:@"like_comic_arr"];
        
        for (NSDictionary *dict7 in array7) {
            
            lastCollectionViewModel *model = [[lastCollectionViewModel alloc]init];
            [model setValuesForKeysWithDictionary:dict7];
            
            
            [weakSelf.lastArray addObject:model];
        }
        //NSLog(@"////////////////// %@",weakSelf.lastArray);
        
        //添加最底层的UIScrollView
        [self addUnderlyingScrollView];
        
        //添加最上面轮播图
        [self addTheFirstScrollView];
        
        //添加第一个tableView
        [self addOneTableView];
        
        //添加分类展示的ScrollView
        [self addItemizeScrollView];
        
        //添加最后的CollectionView
        [self addLastCollectionView];
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [_oneTableView.header endRefreshing];
            
            [_oneTableView reloadData];
            
            
            
        });
        
    } failure:^(NSError *error) {
        
//        干掉正在加载View
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
//        生成一个网路提示View
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeText;
        
        hud.color = myRedColor;
        
        hud.labelText = @"您的网络不给力!";
        
        hud.labelFont = Font_24;
        
        [hud hide: YES afterDelay: 30];
        
        NSLog(@"%@",error);
    }];
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
