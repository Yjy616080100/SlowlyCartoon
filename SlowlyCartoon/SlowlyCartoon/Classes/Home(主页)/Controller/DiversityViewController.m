//
//  DiversityViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "DiversityViewController.h"
#import "DiversityCollectionViewCell.h"
#import "DiversityModel.h"
#import "ImageViewController.h"

@interface DiversityViewController ()
<
UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource
>
// 漫画简介
@property(nonatomic,strong)UILabel *briefIntroduceLabel;

// 集数
@property(nonatomic,strong)UICollectionView *setCollectionView;
//
@property(nonatomic,strong)UILabel *clickLabel;
//继续阅读按钮
@property(nonatomic,strong)UIButton *readButton;
//星星按钮
@property(nonatomic,strong)UIButton *starButton;
//下载按钮
@property(nonatomic,strong)UIButton *downloadButton;
//分享按钮
@property(nonatomic,strong)UIButton *shareButton;


@end

@implementation DiversityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 简介
    [self addBriefIntroduceLabel];
    
    [self addsetCollectionView];
    
    //创建lebel贴 最下面的4个button
    [self addClickLabel];
    //创建继续阅读按钮
    [self addReadBtn];
    //创建收藏按钮
    [self addStarButton];
    //创建下载按钮
    [self addDownloadButton];
    //分享按钮
    [self addShareButton];
    
    
}
// 漫画简介
-(void)addBriefIntroduceLabel{
    
    self.briefIntroduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.1)];
    
    
    self.briefIntroduceLabel.text = @"漫漫漫画是为6000万漫画迷倾心打造一款APP。这里有最新最热门的巨星养成计划，薄荷之夏，斗破苍穹，盗墓笔记，班长大人，勇敢的女孩，花千骨，爱情公寓，暴走邻居，穿越西元3000年后，斗罗大陆漫画书等最好看的漫画书连载";
    
    NSLog(@"%@",self.briefIntroduceString);
    
    
    self.briefIntroduceLabel.textColor = myRedColor;
    
    self.briefIntroduceLabel.backgroundColor = [UIColor whiteColor];
    
    self.briefIntroduceLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:18];
    
    self.briefIntroduceLabel.numberOfLines = 0;
    
    [self.view addSubview:self.briefIntroduceLabel];
}

-(void)addsetCollectionView{
    // 创建
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // cell 的size
    flowLayout.itemSize = CGSizeMake(70, 40);
    // cell 的最小列间距
    flowLayout.minimumInteritemSpacing = 20;
    // cell 的最小行间距
    flowLayout.minimumLineSpacing = 20;
    // cell 的滚动状态
    flowLayout.scrollDirection=UICollectionViewScrollDirectionVertical;
    // cell 离边缘距离
    flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 0, 20);
    //  设置
    
    self.setCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.briefIntroduceLabel.frame), self.view.frame.size.width, self.view.frame.size.height*0.5) collectionViewLayout:flowLayout];
    
    self.setCollectionView.delegate = self;
    
    self.setCollectionView.dataSource = self;
    //注册
    [self.setCollectionView registerNib:[UINib nibWithNibName:@"DiversityCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DiversityCollectionViewCell_Identify];
    
    self.setCollectionView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.setCollectionView];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.diversityArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DiversityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DiversityCollectionViewCell_Identify forIndexPath:indexPath];
        
    DiversityModel *model = self.diversityArray[indexPath.row];
    cell.nameLabel.text = model.order_idx;
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

//cell 的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageViewController *imageVC=[[ImageViewController alloc]init];
    DiversityModel *model = self.diversityArray[indexPath.row];
    
    imageVC.onlyID = model.comic_id;
    imageVC.onlyIdx = model.order_idx;
    
    [self presentViewController:imageVC animated:YES completion:^{
        
    }];
}

























-(void)addClickLabel{
    self.clickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.setCollectionView.frame), self.setCollectionView.frame.size.width, self.view.frame.size.height*0.1)];
    self.clickLabel.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.clickLabel];
    
    
}







//创建继续阅读按钮
-(void)addReadBtn{
    self.readButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.readButton.frame = CGRectMake(0, CGRectGetMaxY(self.setCollectionView.frame), self.clickLabel.frame.size.width*0.4, self.clickLabel.frame.size.height);
    [self.readButton setTitle:@"继续阅读" forState:(UIControlStateNormal)];
    self.readButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.readButton.backgroundColor = [UIColor cyanColor];
    //    [self.readButton bringSubviewToFront:self.clickLabel];
    [self.view addSubview:self.readButton];
    [self.readButton addTarget:self action:@selector(readButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

// 继续阅读点击事件
-(void)readButtonAction:(UIButton *)btn{
    
    
}


//创建收藏按钮
-(void)addStarButton{
    self.starButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.starButton.frame = CGRectMake(CGRectGetMaxX(self.readButton.frame), CGRectGetMinY(self.readButton.frame), self.clickLabel.frame.size.width*0.2, self.clickLabel.frame.size.height);
    [self.starButton setImage:[UIImage imageNamed:@"28-star"] forState:(UIControlStateNormal)];
    self.starButton.backgroundColor = [UIColor whiteColor];
    self.starButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.starButton];
    
    [self.starButton addTarget:self action:@selector(starButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)starButtonAction:(UIButton *)btn{
    
}

//创建下载按钮
-(void)addDownloadButton{
    self.downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downloadButton.frame = CGRectMake(CGRectGetMaxX(self.starButton.frame), CGRectGetMinY(self.readButton.frame), self.clickLabel.frame.size.width*0.2, self.clickLabel.frame.size.height);
    [self.downloadButton setImage:[UIImage imageNamed:@"40-inbox"] forState:(UIControlStateNormal)];
    self.downloadButton.backgroundColor = [UIColor whiteColor];
    self.downloadButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.downloadButton];
    
    [self.downloadButton addTarget:self action:@selector(downloadButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

-(void)downloadButtonAction:(UIButton *)btn{
    
}

//创建分享按钮
-(void)addShareButton{
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.shareButton.frame = CGRectMake(CGRectGetMaxX(self.downloadButton.frame), CGRectGetMinY(self.readButton.frame), self.clickLabel.frame.size.width*0.2, self.clickLabel.frame.size.height);
    [self.shareButton setImage:[UIImage imageNamed:@"eye"] forState:(UIControlStateNormal)];
    self.shareButton.backgroundColor = [UIColor whiteColor];
    self.shareButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.shareButton];
    
    [self.shareButton addTarget:self action:@selector(shareButtonAciton:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)shareButtonAciton:(UIButton *)btn{
    
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
