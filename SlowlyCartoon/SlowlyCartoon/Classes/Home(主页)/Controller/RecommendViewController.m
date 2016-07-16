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

@property(nonatomic,strong)NSMutableArray *firstArray;
@property(nonatomic,strong)NSMutableArray *oneArray;
@property(nonatomic,strong)NSMutableArray *itemizeArray;
@property(nonatomic,strong)NSMutableArray *lastArray;

@property(nonatomic,strong)NSString *recommendString;
@property(nonatomic,strong)NSString *likeSrting;
@property(nonatomic,strong)NSString *hotString;

@end

@implementation RecommendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //请求数据
    [self requestRecommend];
    
//    //添加最底层的UIScrollView
//    [self addUnderlyingScrollView];
//    //添加最上面轮播图
//    [self addTheFirstScrollView];
//    //添加第一个tableView
//    [self addOneTableView];
//    //添加分类展示的ScrollView
//    [self addItemizeScrollView];
//    //添加最后的CollectionView
//    [self addLastCollectionView];

}


//添加最底层的UIScrollView
- (void)addUnderlyingScrollView
{
    self.recommendScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.recommendScrollView.bounces = YES;
    self.recommendScrollView.contentSize = CGSizeMake(0, self.view.frame.size.height*7);
    self.recommendScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.recommendScrollView];

}




//添加最上面轮播图
- (void)addTheFirstScrollView
{
    self.firstScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.firstScrollView.pagingEnabled = YES;
    self.firstScrollView.contentSize = CGSizeMake(self.view.frame.size.width*(self.firstArray.count+2),0);
    NSLog(@"%ld",self.firstArray.count);
   
    self.firstScrollView.contentOffset = CGPointMake(self.view.frame.size.width, 0);
    self.firstScrollView.backgroundColor = [UIColor greenColor];
    self.firstScrollView.delegate = self;
    self.firstScrollView.showsHorizontalScrollIndicator = NO;
    [self.recommendScrollView addSubview:self.firstScrollView];
    //添加button
    [self buttonImage];
    
    
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.firstScrollView.frame.size.width-80, self.firstScrollView.frame.size.height-40, 60, 30)];
    //没有点击的小按钮的颜色
    self.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    //点击的小按钮的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.numberOfPages = _firstArray.count;
    self.pageControl.currentPage = 0;
    //添加点击事件
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.recommendScrollView addSubview:self.pageControl];
    
}
- (void)buttonImage
{
    for (int i=0; i<_firstArray.count+2; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.firstScrollView.frame.size.height);
        NSInteger index = i -1;
        if (i == 0) {
            index = _firstArray.count -1;
        }else if (i == _firstArray.count +1) {
            index = 0;
        }
        firstScrollViewModel *model=_firstArray[index];
        NSString *str=[NSString stringWithFormat:@"http://www.comicq.cn%@",model.active_pic_url_2];
        [button setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]] forState:UIControlStateNormal];
        //还没有写button的点击方法
        
        [self.firstScrollView addSubview:button];
    }
}
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
    self.oneTableView.scrollEnabled=NO;
    [self.oneTableView registerNib:[UINib nibWithNibName:@"OneTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:OneTableViewCell_Identify];
    self.oneTableView.delegate = self;
    self.oneTableView.dataSource = self;
    
    [self.recommendScrollView addSubview:self.oneTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.oneArray[section] count];
}
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.oneArray.count;
}
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}



//添加分类展示的ScrollView
- (void)addItemizeScrollView
{
    self.ItemizeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.oneTableView.frame), self.recommendScrollView.frame.size.width, 130)];
    self.ItemizeScrollView.contentSize = CGSizeMake(self.recommendScrollView.frame.size.width*3-110, 0);
    self.ItemizeScrollView.backgroundColor = [UIColor whiteColor];
    [self.recommendScrollView addSubview:self.ItemizeScrollView];
    [self addsmallButton];
}
- (void)addsmallButton
{
    for (int i=0; i<_itemizeArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
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
        [button setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:arr[i]]]] forState:UIControlStateNormal];
        [self.ItemizeScrollView addSubview:button];
    }
}











- (void)addLastCollectionView
{
    //创建
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    //cell 的size
    flowLayout.itemSize=CGSizeMake(100, 165);
    //cell 的 最小列间距
    flowLayout.minimumInteritemSpacing=25;
    //cell 的 最小行间距
    flowLayout.minimumLineSpacing=50;
    //cell 的 滚动状态（横着或者竖着滚动视图）
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //cell 的 每个分区边缘的距离
    flowLayout.sectionInset=UIEdgeInsetsMake(0, 20, 20, 20);
    //设置头高
    flowLayout.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 50);

    self.lastCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.ItemizeScrollView.frame), 414, 2200) collectionViewLayout:flowLayout];
    self.lastCollectionView.delegate = self;
    self.lastCollectionView.dataSource = self;
    [self.lastCollectionView registerNib:[UINib nibWithNibName:@"LastCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:LastCollectionViewCell_Identify];
    self.lastCollectionView.scrollEnabled=NO;
    self.lastCollectionView.backgroundColor=[UIColor whiteColor];
    [self.recommendScrollView addSubview:self.lastCollectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.lastArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LastCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:LastCollectionViewCell_Identify forIndexPath:indexPath];
    lastCollectionViewModel *model=self.lastArray[indexPath.row];
    
    [cell.imageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.comicq.cn%@",model.comic_pic_240_320]]];
    cell.nameLabel.text = model.comic_name;
    cell.orderidxLabel.text = [NSString stringWithFormat:@"%@话",model.comic_last_orderidx];
    
    return cell;
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
            oneTableViewModel *model=[[oneTableViewModel alloc]init];
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
        
    } failure:^(NSError *error) {
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
