//
//  DetailsViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "DetailsViewController.h"
#import "DiversityViewController.h"
#import "CommentViewController.h"
#import "DetailsRequest.h"
#import "DiversityModel.h"
#import "CommentModel.h"

@interface DetailsViewController ()
<
UIScrollViewDelegate
>

//  模糊图片
@property(nonatomic,strong)UIImageView *fuzzyImageV;
//  主页显示图片
@property(nonatomic,strong)UIImageView *smallImageV;
//  漫画名字
@property(nonatomic,strong)UILabel *comicNameLabel;
//  作者名字
@property(nonatomic,strong)UILabel *authorNameLabel;
//  点赞
@property(nonatomic,strong)UIButton *praiseButton;
//  观看人数
@property(nonatomic,strong)UILabel *lookerLabel;
//  给模糊图片上添加view
@property(nonatomic,strong)UIView *upView;
//  添加segmentControl
@property(nonatomic,strong)UISegmentedControl *segmentControl;
//  添加滑动页面
@property(nonatomic,strong)UIScrollView *scrollView;
//  目录控制器
@property(nonatomic,strong)DiversityViewController *diversityVC;
//  评论控制器
@property(nonatomic,strong)CommentViewController *commentVC;

//创建一个字典接收数据 目录数据
@property(nonatomic,strong)NSDictionary *dataDuct;
//创建一个数组接收评论数据
@property (nonatomic,strong)NSMutableArray *comArray;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.view.backgroundColor= [UIColor whiteColor];
    
    self.dataDuct = [NSDictionary dictionary];
    
    self.comArray = [NSMutableArray array];
    
    
    //请求数据
    [self request];
    //隐藏导航栏
//    [self.navigationController setNavigationBarHidden:YES animated:NO];

}

-(void)viewWillAppear:(BOOL)animated{
    
    //隐藏tabbar
    self.tabBarController.tabBar.hidden = YES;
    
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    //隐藏tabbar
    self.tabBarController.tabBar.hidden = NO;
    
    [super viewDidDisappear:animated];
}
//请求数据
- (void)request
{
    __weak typeof(self) weakSelf = self;
    DetailsRequest *request = [[DetailsRequest alloc]init];
    [request requestDiversityWithID:self.onlyID time:self.onlyTime success:^(NSDictionary *dic) {
        
        weakSelf.dataDuct =[NSDictionary dictionaryWithDictionary:[[[dic objectForKey:@"data"] objectForKey:@"comic_info"] objectForKey:@"comic_data"]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            
            // 添加模糊图片
            [self addFuzzyImageView];
            // 给模糊图片上添加透明view
            [self addUpView];
            // 添加主页小图片
            [self addSmallImageView];
            // 添加漫画名字
            [self addComicNameLabel];
            // 添加漫画作者
            [self addAuthorNameLabel];
            // 添加点赞button
            [self addPraiseButton];
            // 添加观看人数
            [self addLookerLabel];
            // 添加segmentControl
            [self addSegment];
            // 添加滑动
            [self addScrollView];
            // 设置代理
            self.scrollView.delegate = self;
            // 添加控制器
            [self addController];
        
        
        
});
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    
    [request requestCommentWithID:self.onlyID success:^(NSDictionary *dic) {
        
        //初始化需要接收的数组
//        self.commentVC.commentArray = [NSMutableArray array];
        NSLog(@"%@",dic);
        
        NSArray *array = [[dic objectForKey:@"data"] objectForKey:@"comment_arr"];
    
        for (NSDictionary *dict in array) {
            CommentModel *model = [[CommentModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.commentVC.commentArray addObject:model];
            NSLog(@"%@",model);
        }
        
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.commentVC.commentTableView reloadData];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];

    
}
    // 添加模糊图片
-(void)addFuzzyImageView{
    self.fuzzyImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height *0.25)];
    self.fuzzyImageV.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.fuzzyImageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.comicq.cn%@",[self.dataDuct objectForKey:@"comic_pic_516_306"]]]];
    //    self.fuzzyImageV.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:self.fuzzyImageV];
    
    // 设置成模糊色
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.fuzzyImageV.frame.size.width, self.fuzzyImageV.frame.size.height)];
    toolbar.barStyle = UIBarStyleBlackTranslucent;
    [self.fuzzyImageV addSubview:toolbar];
    
}

 // 给模糊图片上添加透明view
-(void)addUpView{
    
    self.upView = [[UIView alloc] init];
    self.upView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height *0.25);
    self.upView.backgroundColor = [UIColor clearColor];
    [self.upView bringSubviewToFront:self.fuzzyImageV];
    [self.view addSubview:self.upView];
}

 // 添加主页小图片
-(void)addSmallImageView{
    
    
    
    self.smallImageV = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.upView.frame)+150, CGRectGetMinX(self.upView.frame)+20, self.upView.frame.size.width *1/4, self.upView.frame.size.height*0.6)];
    
    [self.smallImageV setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.comicq.cn%@",[self.dataDuct objectForKey:@"comic_pic_300_300"]]]];
    
    self.smallImageV.layer.masksToBounds=YES;
    
    //设置为图片宽度的一半出来为圆形
    self.smallImageV.layer.cornerRadius=self.smallImageV.frame.size.width/2;
    
    self.smallImageV.layer.cornerRadius= self.smallImageV.frame.size.height/2;
    
    self.smallImageV.layer.borderWidth=3.0f;
    
    self.smallImageV.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    [self.upView addSubview:self.smallImageV];
    
}
// 添加漫画名字
-(void)addComicNameLabel{
    
    self.comicNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.smallImageV.frame), CGRectGetMaxY(self.smallImageV.frame) + 5, self.smallImageV.frame.size.width + 10, self.smallImageV.frame.size.height *0.2)];
    
    NSString * name = [self.dataDuct objectForKey:@"comic_name"];
    
    self.comicNameLabel.text = [NSString stringWithFormat:@"作品：%@",name];
    
    self.comicNameLabel.textColor = [UIColor whiteColor];
    
    self.comicNameLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:17];
    
    
    [self.upView addSubview:self.comicNameLabel];
    
    
}
// 添加漫画作者
-(void)addAuthorNameLabel{
    
    self.authorNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.comicNameLabel.frame), CGRectGetMaxY(self.comicNameLabel.frame) + 5, self.comicNameLabel.frame.size.width, self.comicNameLabel.frame.size.height)];
    
    NSString * authorName = [self.dataDuct objectForKey:@"painter_user_nickname"];
    
    self.authorNameLabel.text = [NSString stringWithFormat:@"作者：%@",authorName];
    
    self.authorNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.authorNameLabel.textColor = [UIColor whiteColor];
    
    self.authorNameLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:17];
    
    [self.upView addSubview:self.authorNameLabel];
    
    
}
// 添加点赞button
-(void)addPraiseButton{
    
    self.praiseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.praiseButton.frame = CGRectMake(CGRectGetMaxX(self.authorNameLabel.frame) + 70, CGRectGetMinY(self.smallImageV.frame) + 10, self.smallImageV.frame.size.width*2/3, self.smallImageV.frame.size.height*2/6);
    
    //    self.praiseButton.backgroundColor = [UIColor yellowColor];
    
    [self.praiseButton setTitle:@"♡  赞" forState:(UIControlStateNormal)];

    [self.praiseButton setTintColor:[UIColor redColor]];
    
    [self.upView addSubview:self.praiseButton];
    
    [self.praiseButton addTarget:self action:@selector(praiseButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}
// 添加观看人数
-(void)addLookerLabel{
    
    self.lookerLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.authorNameLabel.frame)+80, CGRectGetMinY(self.authorNameLabel.frame), self.authorNameLabel.frame.size.width, self.authorNameLabel.frame.size.height)];
    
    self.lookerLabel.text = [self.dataDuct objectForKey:@"score"];
    
    //    self.lookerLabel.backgroundColor = [UIColor redColor];
    self.lookerLabel.textColor = [UIColor whiteColor];
    self.lookerLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.upView addSubview:self.lookerLabel];
    
    
}

// 点击点赞的点击事件
-(void)praiseButtonAction:(UIButton *)btn{
    
}


// 添加SegmentControl
-(void)addSegment{
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"目录",@"评论"]];
    self.segmentControl.frame = CGRectMake(CGRectGetMinX(self.upView.frame), CGRectGetMaxY(self.upView.frame), self.upView.frame.size.width, self.view.frame.size.height*0.05);
    [self.segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:(UIControlEventValueChanged)];
    self.segmentControl.selectedSegmentIndex = 0;
    [self.view addSubview:self.segmentControl];
    
}

-(void)addScrollView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.segmentControl.frame), self.view.frame.size.width, self.view.frame.size.height*0.70)];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width*2, 0);
    self.scrollView.backgroundColor = [UIColor redColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
}
//添加控制器
-(void)addController{
    self.diversityVC = [DiversityViewController new];
    self.commentVC = [CommentViewController new];
    
    self.diversityVC.view.frame = CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    self.commentVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
    
    
    //集数目录 传值
    
    //给目录子Controller赋值
    self.diversityVC.briefIntroduceString = [self.dataDuct objectForKey:@"comic_desc"];
    //给数组赋值 （目录数组）
    self.diversityVC.diversityArray = [NSMutableArray array];
    
    NSArray *array = [self.dataDuct objectForKey:@"comic_order_arr"];
    
    for (NSDictionary *dic in array) {
        DiversityModel *model = [[DiversityModel alloc]init];
        [model setValuesForKeysWithDictionary:dic];
        [self.diversityVC.diversityArray addObject:model];
    }
    [self.scrollView addSubview:self.diversityVC.view];
    [self.scrollView addSubview:self.commentVC.view];
    
}

// segmentControl 点击事件
-(void)segmentControlAction:(UISegmentedControl *)sender{
    [self.scrollView setContentOffset:CGPointMake(sender.selectedSegmentIndex * self.scrollView.frame.size.width, 0) animated:NO];
}

// scrollview代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger n = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.segmentControl.selectedSegmentIndex = n;
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
