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
    
    
    //请求数据
    [self requestRecommend];
}

//添加最底层的UIScrollView
- (void)addUnderlyingScrollView
{
    self.recommendScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    self.recommendScrollView.bounces = YES;
    self.recommendScrollView.contentSize = CGSizeMake(0, self.view.frame.size.height*4);
    self.recommendScrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.recommendScrollView];

}




//添加最上面轮播图
- (void)addTheFirstScrollView
{
    self.firstScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    self.firstScrollView.pagingEnabled = YES;
    self.firstScrollView.contentSize = CGSizeMake(self.view.frame.size.width*4,0);
    self.firstScrollView.backgroundColor = [UIColor greenColor];
    self.firstScrollView.delegate = self;
    [self.recommendScrollView addSubview:self.firstScrollView];
    
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(self.firstScrollView.frame.size.width-80, self.firstScrollView.frame.size.height-40, 60, 30)];
    //没有点击的小按钮的颜色
    self.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    //点击的小按钮的颜色
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.numberOfPages = 4;
    //添加点击事件
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    [self.recommendScrollView addSubview:self.pageControl];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView //ScrollView的代理方法
{
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.pageControl.currentPage = page;
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
    self.oneTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,self.firstScrollView.frame.size.height, self.recommendScrollView.frame.size.width, 1000) style:UITableViewStyleGrouped];
    [self.oneTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"oneCell"];
    self.oneTableView.delegate = self;
    self.oneTableView.dataSource = self;
    
    [self.recommendScrollView addSubview:self.oneTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"oneCell"];
    cell.textLabel.text = @"1212";
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 414, 30)];
    imageV.image = [UIImage imageNamed:@"tabbar_game_sel@2x.png"];
    
    return imageV;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}




//添加分类展示的ScrollView
- (void)addItemizeScrollView
{
    self.ItemizeScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.oneTableView.frame), self.recommendScrollView.frame.size.width, 130)];
    self.ItemizeScrollView.contentSize = CGSizeMake(self.recommendScrollView.frame.size.width*3, 0);
    self.ItemizeScrollView.backgroundColor = [UIColor grayColor];
    [self.recommendScrollView addSubview:self.ItemizeScrollView];
}




- (void)addLastCollectionView
{
    //创建
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
    //cell 的size
    flowLayout.itemSize=CGSizeMake(90, 90);
    //cell 的 最小列间距
    flowLayout.minimumInteritemSpacing=50;
    //cell 的 最小行间距
    flowLayout.minimumLineSpacing=50;
    //cell 的 滚动状态（横着或者竖着滚动视图）
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    //cell 的 每个分区边缘的距离
    flowLayout.sectionInset=UIEdgeInsetsMake(20, 20, 20, 20);
    //设置头高
    flowLayout.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 50);

    self.lastCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.ItemizeScrollView.frame), 414, 1600) collectionViewLayout:flowLayout];
    self.lastCollectionView.delegate = self;
    self.lastCollectionView.dataSource = self;
    [self.lastCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellCollection"];
    
    self.lastCollectionView.backgroundColor=[UIColor blueColor];
    [self.recommendScrollView addSubview:self.lastCollectionView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 30;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellCollection" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}






- (void)requestRecommend
{
    self.firstArray = [NSMutableArray array];
    self.oneArray = [NSMutableArray array];
    self.itemizeArray = [NSMutableArray array];
    self.lastArray = [NSMutableArray array];
    
    RecommendRequest *request = [[RecommendRequest alloc]init];
    [request recommentRequestWithParameter:nil success:^(NSDictionary *dic) {
        //装轮播图数组
        NSDictionary *dict1 = [dic objectForKey:@"data"];
        NSArray *arr1 = [dict1 objectForKey:@"index_head_arr"];
        for (NSDictionary *dict2 in arr1) {
            firstScrollViewModel *model = [[firstScrollViewModel alloc]init];
            [model setValuesForKeysWithDictionary:dict2];
            [self.firstArray addObject:model];
        }
        NSLog(@"++++++++++%@",self.firstArray);
        
        
        
        //装中部轮播图案数组
        NSArray *arr2 = [dict1 objectForKey:@"index_topic_arr"];
        for (NSDictionary *dict3 in arr2) {
            itemizeScrollViewModel *model = [[itemizeScrollViewModel alloc]init];
            [model setValuesForKeysWithDictionary:dict3];
            [self.itemizeArray addObject:model];
        }
        NSLog(@"-------------%@",self.itemizeArray);
        
        
        
        //tableView数组
        NSMutableArray *array1=[NSMutableArray array];
        NSMutableArray *array2=[NSMutableArray array];
        NSDictionary *dict4 = [dict1 objectForKey:@"index_comic_arr"];
        //三个图片的字符串
        self.recommendString = [dict4 objectForKey:@"recommend_title_pic_url"];
        self.likeSrting = [dict4 objectForKey:@"like_title_pic_url"];
        self.hotString = [dict4 objectForKey:@"hot_title_pic_url"];

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
        [self.oneArray addObject:array1];
        [self.oneArray addObject:array2];
        NSLog(@"******************* %@",self.oneArray);
        
        
        
        //装CollectionView数组
        NSArray *array7 = [dict4 objectForKey:@"like_comic_arr"];
        for (NSDictionary *dict7 in array7) {
            lastCollectionViewModel *model = [[lastCollectionViewModel alloc]init];
            [model setValuesForKeysWithDictionary:dict7];
            [self.lastArray addObject:model];
        }
        NSLog(@"////////////////// %@",self.lastArray);
        
        
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
