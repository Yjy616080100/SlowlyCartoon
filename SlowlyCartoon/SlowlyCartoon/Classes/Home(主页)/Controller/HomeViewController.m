//
//  HomeViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "HomeViewController.h"
#import "RecommendViewController.h"
#import "HigtenerViewController.h"
#import "RankListViewController.h"
@interface HomeViewController ()
<
UIScrollViewDelegate
>

@property(nonatomic,strong)UISegmentedControl *segControl;
@property(nonatomic,strong)UIScrollView *scoView;
@property(nonatomic,strong)RecommendViewController *recomVC;
@property(nonatomic,strong)HigtenerViewController *higtenerVC;
@property(nonatomic,strong)RankListViewController *ranklistVC;


@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.segControl = [[UISegmentedControl alloc] initWithItems:@[@"推荐", @"高能",@"排行"]];
    self.navigationItem.titleView = self.segControl;
    [self.segControl addTarget:self action:@selector(segmentedControlAction:) forControlEvents:UIControlEventValueChanged];
    self.segControl.selectedSegmentIndex = 0;
    
    // 创建scrollView
    self.scoView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.scoView];
    // 设置scrollView的内容
    self.scoView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 3, 0);
    self.scoView.pagingEnabled = YES;
    self.scoView.bounces = NO;
    
    // 创建控制器
    self.recomVC = [RecommendViewController new];
    self.higtenerVC = [HigtenerViewController new];
    self.ranklistVC = [RankListViewController new];
    // 添加为self的子控制器
    [self addChildViewController:self.recomVC];
    [self addChildViewController:self.higtenerVC];
    [self addChildViewController:self.ranklistVC];
    self.recomVC.view.frame = CGRectMake(0, 0, self.scoView.frame.size.width, CGRectGetHeight(self.scoView.frame));
    self.higtenerVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, self.scoView.frame.size.width, CGRectGetHeight(self.scoView.frame));
    self.ranklistVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*2, 0, self.scoView.frame.size.width, CGRectGetHeight(self.scoView.frame));
    [self.scoView addSubview:self.higtenerVC.view];
    [self.scoView addSubview:self.recomVC.view];
    [self.scoView addSubview:self.ranklistVC.view];
    self.higtenerVC.view.backgroundColor=[UIColor redColor];
    self.recomVC.view.backgroundColor = [UIColor blueColor];
    self.ranklistVC.view.backgroundColor=[UIColor greenColor];
    // 设置scrollView的代理
    self.scoView.delegate = self;
    
}
- (void)segmentedControlAction:(UISegmentedControl *)sender
{
    [self.scoView setContentOffset:CGPointMake(sender.selectedSegmentIndex * self.scoView.frame.size.width, 0) animated:NO];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger n = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.segControl.selectedSegmentIndex = n;
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
