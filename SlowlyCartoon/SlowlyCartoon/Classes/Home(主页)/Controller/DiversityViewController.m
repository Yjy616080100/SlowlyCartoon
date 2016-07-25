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
UICollectionViewDataSource,
UIGestureRecognizerDelegate
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
//是否隐藏
@property (nonatomic , assign)BOOL isHiddenned;
//是否已经分享
@property(nonatomic, assign)BOOL isCollected;

@property (nonatomic,strong)CALayer * mylayer;

@property(nonatomic,strong)UITapGestureRecognizer* tapGesture;
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
    
//    添加手势
//    [self addGesture];
    
}
- (void)addGesture{
    _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    
    [self.view addGestureRecognizer:_tapGesture];
    
    _tapGesture.delegate = self;
    
}
- (void)tapGestureAction:(UITapGestureRecognizer* )gesture{
    
        [self.delegate DiversityViewControllerNavHideen];
}
//手势的代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    if (gestureRecognizer == _tapGesture) {
        
        NSLog(@"=============");
        
        return YES;
    }
    return NO;
}

// 漫画简介
-(void)addBriefIntroduceLabel{
    
    self.briefIntroduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height*0.1)];
    
    
    self.briefIntroduceLabel.text = @"漫漫漫画是为6000万漫画迷倾心打造一款APP。这里有最新最热门的巨星养成计划，薄荷之夏，斗破苍穹，盗墓笔记，班长大人，勇敢的女孩，花千骨，爱情公寓，暴走邻居，穿越西元3000年后，斗罗大陆漫画书等最好看的漫画书连载";
    
    NSLog(@"%@",self.briefIntroduceString);
    
    
    self.briefIntroduceLabel.textColor = myRedColor;
    
    self.briefIntroduceLabel.backgroundColor = [UIColor whiteColor];
    
    self.briefIntroduceLabel.font = Font_18;
    
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
    
    self.setCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.briefIntroduceLabel.frame), self.view.frame.size.width, self.view.frame.size.height*0.5 + 25) collectionViewLayout:flowLayout];
    
    self.setCollectionView.delegate = self;
    
    self.setCollectionView.dataSource = self;
    //注册
    [self.setCollectionView registerNib:[UINib nibWithNibName:@"DiversityCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:DiversityCollectionViewCell_Identify];
    
    self.setCollectionView.backgroundColor = [UIColor whiteColor];
    
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

    DiversityModel *model = self.diversityArray[indexPath.row];
    
    ImageViewController * imageVC = [ImageViewController new];

//    [_delegate DiversityViewControllerPushAction:model.order_idx];
    
    imageVC.onlyIdx = model.order_idx;
    
    [self.delegate DiversityViewControllerPushAction:model.order_idx];
    
}
























#define btnAndLabelHeight 49
-(void)addClickLabel{
    self.clickLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.setCollectionView.frame), self.setCollectionView.frame.size.width, btnAndLabelHeight)];
    
    self.clickLabel.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.clickLabel];
    
    
}







//创建继续阅读按钮
-(void)addReadBtn{
    self.readButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.readButton.frame = CGRectMake(0, CGRectGetMaxY(self.setCollectionView.frame), self.clickLabel.frame.size.width*0.4, self.clickLabel.frame.size.height);
    
    [self.readButton setTitle:@"开始阅读" forState:(UIControlStateNormal)];
    
    self.readButton.titleLabel.font = Font_28;
    
    self.readButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    self.readButton.layer.borderWidth = 1.0;
    
    self.readButton.layer.borderColor = [UIColor orangeColor].CGColor;
    
//    self.readButton.tintColor = myRedColor;
    
    self.readButton.backgroundColor = myRedColor;
    
    self.readButton.layer.cornerRadius = 8;
    
    self.readButton.layer.masksToBounds = YES;
    
    [self.view addSubview:self.readButton];
    
    [self.readButton addTarget:self action:@selector(readButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

// 继续阅读点击事件
-(void)readButtonAction:(UIButton *)btn{
    
    [self.delegate DiversityViewControllerPushAction:@"1"];
}


//创建收藏按钮
-(void)addStarButton{
    self.starButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.starButton.frame = CGRectMake(CGRectGetMaxX(self.readButton.frame), CGRectGetMinY(self.readButton.frame), self.clickLabel.frame.size.width*0.2, self.clickLabel.frame.size.height);
    
    [self.starButton setImage:[UIImage imageNamed:@"heart.png"] forState:(UIControlStateNormal)];
    
    self.starButton.backgroundColor = [UIColor whiteColor];
    
    self.starButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.starButton];
    
    [self.starButton addTarget:self action:@selector(starButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

//collectionAction

-(void)starButtonAction:(UIButton *)btn{
    
//    是否已收藏判断（没实现）
    if (_isCollected) {
        
        [btn setImage:[UIImage imageNamed:@"heart.png"] forState:(UIControlStateNormal)];
        
        _isCollected = !_isCollected;
        
    }else{
        
        [btn setImage:[UIImage imageNamed:@"heart_selected.png"] forState:(UIControlStateNormal)];
        
        UIImageView * imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"heart_selected.png"]];
        
        imageV.frame = CGRectMake(- 100, 1000, 50, 50);
        
        [self.view addSubview:imageV];
        
        
        CGPoint point = CGPointMake(self.starButton.imageView.frame.origin.x, self.starButton.imageView.frame.origin.y);
        
      CGPoint newPoint = [self.view convertPoint:point fromView:self.starButton];
        
        NSLog(@"%f====%f",newPoint.x,newPoint.y);
//
//        imageV.layer.backgroundColor = [UIColor blueColor].CGColor;
//        __layer = imageV.layer;
        
        _mylayer = imageV.layer;
        
        //_myLayer添加到View自带的layer层上
        [self.view.layer addSublayer:_mylayer];
        
        _isCollected = !_isCollected;
        
        [self CAKeyFrameAnimationPosition];
    }
    
}
-(void)CAKeyFrameAnimationPosition{
//    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
//    animation.keyPath = @"position";
//    //    执行路径
//    NSValue* aValue = [NSValue valueWithCGPoint:CGPointMake(50, 200)];
//    NSValue* bValue = [NSValue valueWithCGPoint:CGPointMake(80, 250)];
//    NSValue* cValue = [NSValue valueWithCGPoint:CGPointMake(100, 270)];
//    NSValue* dValue = [NSValue valueWithCGPoint:CGPointMake(80, 380)];
//    NSValue* eValue = [NSValue valueWithCGPoint:CGPointMake(50, 450)];
//    animation.removedOnCompletion = YES;
//    animation.fillMode = kCAFillModeBackwards;
//    animation.values = @[aValue,bValue,cValue,dValue,eValue];
//    animation.duration = 3;
//    [_mylayer addAnimation:animation forKey:@"position"];
//        创建贝瑟尔路径
        UIBezierPath* path = [UIBezierPath bezierPath];
    
        [path moveToPoint:CGPointMake(194.26667, 478.6)];
    
    int x = 194;
    
    int y = 478;
    
    int value = 4;
    
    do {
        if (x % 3) {
            
            value ++;
            
            x += value ++;
         
        }else{
            
             x -= value  ;
            
        }

            
        y -= 30.0;
        
        [path addLineToPoint:CGPointMake(x, y)];
        
    } while (y > - 300);
    
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    
        animation.keyPath = @"position";
    
        animation.removedOnCompletion = YES;
    
        animation.fillMode = kCAFillModeBackwards;
    
        animation.path = path.CGPath;
    
        animation.duration = 2.0;
    
        [_mylayer addAnimation:animation forKey:@"position"];
    
}

//创建下载按钮
-(void)addDownloadButton{
    self.downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.downloadButton.frame = CGRectMake(CGRectGetMaxX(self.starButton.frame), CGRectGetMinY(self.readButton.frame), self.clickLabel.frame.size.width*0.2, self.clickLabel.frame.size.height);
    
    [self.downloadButton setImage:[UIImage imageNamed:@"download.png"] forState:(UIControlStateNormal)];
    
    self.downloadButton.backgroundColor = [UIColor whiteColor];
    
    self.downloadButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.downloadButton];
    
    [self.downloadButton addTarget:self action:@selector(downloadButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
}

//downloadActon
-(void)downloadButtonAction:(UIButton *)btn{
    
    
}

//创建分享按钮
-(void)addShareButton{
    self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.shareButton.frame = CGRectMake(CGRectGetMaxX(self.downloadButton.frame), CGRectGetMinY(self.readButton.frame), self.clickLabel.frame.size.width*0.2, self.clickLabel.frame.size.height);
    
    [self.shareButton setImage:[UIImage imageNamed:@"share.png"] forState:(UIControlStateNormal)];
    
    self.shareButton.backgroundColor = [UIColor whiteColor];
    
    self.shareButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view addSubview:self.shareButton];
    
    [self.shareButton addTarget:self action:@selector(shareButtonAciton:) forControlEvents:(UIControlEventTouchUpInside)];
}

//shareAction
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
