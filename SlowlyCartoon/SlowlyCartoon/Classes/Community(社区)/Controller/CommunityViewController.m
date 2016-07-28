//
//  CommunityViewController.m
//  MyFamily
//
//  Created by lanou3g on 16/7/24.
//  Copyright (c) 2016年 Slowly Pangpang. All rights reserved.
//

#import "CommunityViewController.h"

#import "HeaderContent.h"

#import "FamilyGroupCell.h"

#import "ShowImageViewController.h"

#import "ReplyInputView.h"

#define Win_W [UIScreen mainScreen].bounds.size.width

#define Win_H [UIScreen mainScreen].bounds.size.height
@interface CommunityViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate

>

@property (nonatomic,strong)NSMutableArray *familyGroupData;

@property (nonatomic,weak)UIButton *replyButton; //点击后弹出的评论按钮

@property (nonatomic,weak)ReplyInputView *replyInputView;

@property (nonatomic,assign)BOOL flag;  //用于键盘出现时函数调用多次的情况

@property (strong, nonatomic) UITableView *familyTableView;

@property (nonatomic,assign)float replyViewDraw;

@property (nonatomic, strong)UIImageView * headIconImageView;

@property(nonatomic,strong)UIImageView * backGroundImageView;

//工具栏的高约束，用于当输入文字过多时改变工具栏的约束
@property (strong, nonatomic) NSLayoutConstraint *replyInputViewConstraintHeight;
@end

@implementation CommunityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    _familyTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 64, Win_W, Win_H - 112) style:(UITableViewStylePlain)];
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:_familyTableView];
    
    _familyTableView.delegate = self;
    
    _familyTableView.dataSource = self;
    
    [_familyTableView registerClass:[FamilyGroupCell class] forCellReuseIdentifier:@"FamilyGroupCell"];
    
    [self addHeaderView];
    
    self.flag = YES;
    
    //获取通知中心
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    //注册为被通知者
    [notificationCenter addObserver:self selector:@selector(keyChange:) name:UIKeyboardDidShowNotification object:nil];
    
}

#define headViewHeight 200
#define headIconWidth 50
#define headIconHeight 50


-(void)viewWillAppear:(BOOL)animated{
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
//    
//    self.navigationController.navigationBar.tintColor = [UIColor clearColor];
    
    [super viewWillAppear:animated];
}

-(void)viewDidDisappear:(BOOL)animated{
    
//    self.navigationController.navigationBar.backgroundColor = [UIColor orangeColor];
    
    [super viewDidDisappear:animated];
}
#pragma mark - 这些进入应用就应该全部保存起来，直接问服务器拿数据，保存，类似username,之后可以直接取，图片可以放入沙盒暂存

-(void)addHeaderView
{
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, headViewHeight)];
    
   _backGroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, headViewHeight - 2*padding)];
    
    _backGroundImageView.image = [UIImage imageNamed:@"background.jpg"];
    [headView addSubview:_backGroundImageView];
    
    
    _headIconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(padding, headViewHeight - headIconHeight, headIconWidth, headIconHeight)];
    
    _headIconImageView.image = [UIImage imageNamed:@"headicon"];
    
    [headView addSubview:_headIconImageView];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(headIconWidth + 2 * padding, headViewHeight - 0.8*headIconHeight, 100, 15)];
    
    nameLabel.text = @"Slowly Pangpang";
    
    nameLabel.font = [UIFont systemFontOfSize:16];
    
    nameLabel.textColor = [UIColor whiteColor];
    
    [headView addSubview:nameLabel];
    
    self.familyTableView.tableHeaderView = headView;
    
    //长按更换背景
    
    UILongPressGestureRecognizer * longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    
    [self.familyTableView.tableHeaderView addGestureRecognizer:longPressGesture];

}

#pragma mark- 长按更换背景

- (void)longPressAction:(UIGestureRecognizer*)gesture{
    
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    
    imagePickerController.delegate = self;
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"漫漫请您选择方式" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    //    调用相机
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"自拍上传" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    //    相册中选取
    UIAlertAction * photoAlbumAction = [UIAlertAction actionWithTitle:@"从相册中选择" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        //        跳转到 imagePickerController
        [self presentViewController:imagePickerController animated:YES completion:^{
            
        }];
        
    }];
    
    //    取消
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:cameraAction];
    
    [alertController addAction:photoAlbumAction];
    
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];

}
#pragma mark 图片选择器的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    _backGroundImageView.image = info[UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - tableview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"%lu",(unsigned long)[self.statusFrames count]);
    return [self.familyGroupData count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //虽然返回1，但是每个indexpath的section为0
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FamilyGroupCell *cell = [FamilyGroupCell cellWithTableView:tableView];
    
    cell.familyGroupFrame = self.familyGroupData[indexPath.row];
    
    [cell.replyButton addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.replyButton.tag = indexPath.row;   //评论时可以知道加到第几行
    
    cell.imageBlock = ^(NSArray *imageViews, NSInteger clickTag) {
        
        self.navigationController.navigationBarHidden = YES;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Community" bundle:[NSBundle mainBundle]];
        
        ShowImageViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"ShowImageViewController"];
        
        [vc setHidesBottomBarWhenPushed:YES]; //隐藏tabbar
        
        vc.clickTag = clickTag;
        
        vc.imageViews = imageViews;
        
        [self.navigationController pushViewController:vc animated:NO];
        
    };
    return cell;
}

-(NSMutableArray *)familyGroupData
{
    if (!_familyGroupData) {
        
        NSString *fullPath = [[NSBundle mainBundle]pathForResource:@"FamilyGroup.plist" ofType:nil];
        
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:fullPath];
        
        NSMutableArray *models = [NSMutableArray arrayWithCapacity:[dictArray count]];
        
        for (NSDictionary *dict in dictArray) {
            
            FamilyGroup *familyGroup = [FamilyGroup familyGroupWithDict:dict];
            
            FamilyGroupFrame *familyGroupFrame = [[FamilyGroupFrame alloc]init];
            
            familyGroupFrame.familyGroup = familyGroup;
            
            [models addObject:familyGroupFrame];
        }
        _familyGroupData = [models copy];
    }
 
    return _familyGroupData;
}

-(void)replyAction:(UIButton *)sender
{
    FamilyGroupCell *cell = (FamilyGroupCell *)sender.superview.superview;
    
    self.replyViewDraw = [cell convertRect:cell.bounds toView:self.view.window].origin.y + cell.frame.size.height;
    
    NSIndexPath *indexPath = [self.familyTableView indexPathForCell:cell];
    
    CGRect rectInTableView = [self.familyTableView rectForRowAtIndexPath:indexPath];
    
    //NSLog(@"%f",rectInTableView.origin.y);
    CGRect replyButtonF = CGRectMake(sender.frame.origin.x , rectInTableView.origin.y+sender.frame.origin.y - 2, 0,20);
    
    NSLog(@"%f",self.replyButton.frame.origin.y);
    
    NSLog(@"%f",rectInTableView.origin.y+sender.frame.origin.y - 2);
    
    if (self.replyButton && self.replyButton.frame.origin.y != (rectInTableView.origin.y+sender.frame.origin.y - 2-padding)) {
        
        [self.replyButton removeFromSuperview];      //以防用户按了一个评论又按另一个
        self.replyButton = nil;
    }
    
    [self initReplyButton:replyButtonF];
    
    if (self.replyButton) {
        
        self.replyButton.tag = sender.tag;
    }
}

-(void)initReplyButton:(CGRect)replyButtonF
{
    if (!self.replyButton) {
        
        UIButton *replyButton = [UIButton buttonWithType:0];
        
        replyButton.layer.cornerRadius = 5;
        
        replyButton.backgroundColor = [UIColor colorWithRed:33/255.0 green:37/255.0 blue:38/255.0 alpha:1.0];
        
        replyButton.frame = replyButtonF;
        
        [replyButton setTitleColor:[UIColor whiteColor] forState:0];
        
        replyButton.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [replyButton addTarget:self action:@selector(replyMessage:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.familyTableView addSubview:replyButton];
        
        self.replyButton = replyButton;
        
        [UIView animateWithDuration:0.25f animations:^{
            
            CGRect replyButtonDurF;
            
            replyButtonDurF.size.height = replyButtonF.size.height + 2*padding;
            
            replyButtonDurF.origin.y = replyButtonF.origin.y - padding;
            
            replyButtonDurF.origin.x = replyButtonF.origin.x - 60;
            
            replyButtonDurF.size.width = 60;
            
            replyButton.frame = replyButtonDurF;
            
        } completion:^(BOOL finished) {
            
            [replyButton setTitle:@"评论" forState:0];
            
        }];
        
    }
    else
    {
        [UIView animateWithDuration:0.25f animations:^{
            
            self.replyButton.frame = replyButtonF;    //只是为了有收缩的动画效果
            
        } completion:^(BOOL finished) {
            
            [self.replyButton removeFromSuperview];
            
            self.replyButton = nil;
        }];
        
    }
}

-(void)replyMessage:(UIButton *)sender
{
    if (self.replyButton) {
        
        [self initReplyInputView:sender.tag];
        
        [self.replyButton removeFromSuperview];
        
        self.replyButton = nil;
    }
}

-(void)initReplyInputView:(NSInteger) tag
{
    ReplyInputView *replyInputView = [[ReplyInputView alloc]initWithFrame:CGRectMake(0, self.view.bounds.origin.y + self.view.frame.size.height - 105, screenWidth, 54) andAboveView:self.view];
    
    
    self.flag = YES;
    //回调输入框的contentSize,改变工具栏的高度
    
    [replyInputView setContentSizeBlock:^(CGSize contentSize) {
        [self updateHeight:contentSize];
        
    }];
    
    [replyInputView setReplyAddBlock:^(NSString *replyText, NSInteger inputTag) {
        
        replyText = [@"老衲只用清扬：" stringByAppendingString:replyText];
        
        FamilyGroupFrame *familyGroupFrameNeedChanged = self.familyGroupData[inputTag];
        
        FamilyGroup *newFamilyGroup = familyGroupFrameNeedChanged.familyGroup;
        
        //做个中转
        NSMutableArray *mutaArray = [[NSMutableArray alloc] init];
        
        [mutaArray addObjectsFromArray:newFamilyGroup.replys];
        
        [mutaArray addObject:replyText];
        
        newFamilyGroup.replys = mutaArray;
        
        familyGroupFrameNeedChanged.replysF = nil;
        
        familyGroupFrameNeedChanged.picturesF = nil;
        
        familyGroupFrameNeedChanged.familyGroup = newFamilyGroup;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:inputTag inSection:0];  //nsindexpath初始化方法
        
        [self.familyTableView reloadRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        
        
    }];
    
    replyInputView.replyTag = tag;    //值为cell所在的行
    
    [self.view addSubview:replyInputView];
    
    self.replyInputView = replyInputView;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FamilyGroupFrame *frame = self.familyGroupData[indexPath.row];
    return frame.cellHeight;
}

//更新replyView的高度约束
-(void)updateHeight:(CGSize)contentSize
{
    float height = contentSize.height + 20;
    CGRect frame = self.replyInputView.frame;
    frame.origin.y -= height - frame.size.height;  //高度往上拉伸
    frame.size.height = height;
    self.replyInputView.frame = frame;
}

//键盘出来的时候调整replyView的位置
-(void) keyChange:(NSNotification *) notify
{
    NSDictionary *dic = notify.userInfo;
    CGRect keyboardRect = [dic[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    if (keyboardRect.size.height >250 && self.flag) {
        [UIView animateWithDuration:[dic[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
            
            [UIView setAnimationCurve:[dic[UIKeyboardAnimationCurveUserInfoKey] doubleValue]];
            
            CGRect frame = self.replyInputView.frame;
            frame.origin.y = frame.origin.y - keyboardRect.size.height + 52;
            self.replyInputView.frame = frame;
            
            CGPoint point = self.familyTableView.contentOffset;
            
            point.y -= (frame.origin.y - self.replyViewDraw);
            self.familyTableView.contentOffset = point;
        }];
        self.flag = NO;
        
    }
}
- (void)dealloc{
//    移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
