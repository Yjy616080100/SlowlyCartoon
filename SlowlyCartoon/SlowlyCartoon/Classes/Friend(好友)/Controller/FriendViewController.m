//
//  FriendViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "FriendViewController.h"
#import "SingleFriendManager.h"
#import "ChatViewController.h"
typedef void(^valueBlock) (void);//命名block
@interface FriendViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
EMContactManagerDelegate
>
//tableView的属性
@property(nonatomic,strong)UITableView *tableView;
//存储数据的数组
@property(nonatomic,strong)NSMutableArray *dataArray;
//block属性
@property(nonatomic,copy)valueBlock myBlock;
@end

@implementation FriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的好友";
    self.view.backgroundColor=[UIColor whiteColor];
    self.dataArray=[NSMutableArray array];
    
    //导航栏右方法
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addFriends)];
    
    //应用登录方法
    [self loginAction];
    
    
    //添加tableView
    self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-44) style:(UITableViewStylePlain)];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:self.tableView.bounds];
    imageV.image=[UIImage imageNamed:@"beijing.jpg"];
    [self.tableView setBackgroundView:imageV];
    [self.view addSubview:self.tableView];
    
    //从数据库中请求所有好友-->给dataArray赋值
    [self requestAllFriends];
    
    
    //设置代理-->当别人添加我时调用代理方法进行提示
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=NO;
    [self.tableView reloadData];
}

#pragma mark------------------------1.tableView的代理方法------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cellID"];
    }
    //cell背景图片
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing2.jpg"]];
    cell.textLabel.text=_dataArray[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:22];
    //取消选中cell的点击颜色
    UIView *view=[[UIView alloc]initWithFrame:cell.contentView.bounds];
    view.backgroundColor=[UIColor clearColor];
    cell.selectedBackgroundView =view;
    
    return cell;
    
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
}
#pragma mark------------------------2.登录应用方法------------------------

//登录方法
-(void)loginAction{
    
    EMError *error = [[EMClient sharedClient] loginWithUsername:@"00" password:@"00"];
    if (!error) {
        
        NSLog(@"登录成功");
        
    }else{
        //调用弹窗，打印登录失败的信息
        [self boundsWindow:error.errorDescription];
    }
}

//弹窗
-(void)boundsWindow:(NSString *)string{
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDestructive) handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}


#pragma mark------------------------3.从数据库请求好友列表-----------------------------
//从数据库请求好友列表
-(void)requestAllFriends{
    
    NSArray *tempArray=[[SingleFriendManager shareSingleFriendManager]requestAllFrineds];
    self.dataArray=[NSMutableArray arrayWithArray:tempArray];
    
}


#pragma mark------------------------4.左滑删除好友-----------------------------------

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}
//提交编辑结果
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //获取删除对象
        NSString *friendName=_dataArray[indexPath.row];
        //数组删除
        [_dataArray removeObject:friendName];
        //本地数据库中删除
        [[SingleFriendManager shareSingleFriendManager]deleteFriendWithName:friendName];
        //刷新
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationLeft)];
    }
    
}


#pragma mark------------------------5.点击cell 和好友聊天-----------------------------------
//点击跳转到聊天界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSLog(@"点击跳转到聊天界面");
    UIStoryboard *SB=[UIStoryboard storyboardWithName:@"Friends" bundle:[NSBundle mainBundle]];
    ChatViewController *chatVC=[SB instantiateViewControllerWithIdentifier:@"ChatViewController"];
    
    chatVC.name=_dataArray[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
    

    
}


#pragma mark------------------------6.导航栏右方法------------------------
//添加好友方法
-(void)addFriends{
    
    NSLog(@"添加好友");
    //弹窗提示--->输入好友用户名
    __weak typeof(self) weakSelf=self;
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"添加好友" message:@"请输入好友用户名" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancleAction=[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    UIAlertAction *sureAction=[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        weakSelf.myBlock();
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder=@"请输入账号";
        textField.font=[UIFont systemFontOfSize:15];
        textField.textAlignment=NSTextAlignmentCenter;
        
        weakSelf.myBlock=^(){
            //点击确定，发送添加好友请求
            [[SingleFriendManager shareSingleFriendManager]addFriendWithName:textField.text];
        };
        
    }];
    [alert addAction:cancleAction];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//当对方同意我的添加请求时调用
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername{
    
    NSLog(@"对方已同意--你的好友请求");
    //对方已同意，重新从服务器请求，刷新UI
    NSArray *tempArr=[[SingleFriendManager shareSingleFriendManager]requestAllFrineds];
    _dataArray=[NSMutableArray arrayWithArray:tempArr];
    [self.tableView reloadData];
}
//当对方拒绝我的添加请求时调用
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername{
    
    NSLog(@"对方已拒绝--你的好友请求");
}

//当别人添加我时，我会收到这个方法的回调
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage{
    
    NSString *str=[NSString stringWithFormat:@"%@用户想添加你为好友",aUsername];
    
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:str preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *action1=[UIAlertAction actionWithTitle:@"同意" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        //同意方法-->加入到服务器
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:aUsername];
        if (!error) {
            NSLog(@"你已同意添加对方为好友");
            
            //重新请求，刷新UI
            NSArray *tempArray=[[SingleFriendManager shareSingleFriendManager]requestAllFrineds];
            _dataArray=[[NSMutableArray alloc]initWithArray:tempArray];
            
            [self.tableView reloadData];
            
        }
    }];
    UIAlertAction *action2=[UIAlertAction actionWithTitle:@"拒绝" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
        //拒绝的方法
        EMError *error1 = [[EMClient sharedClient].contactManager declineInvitationForUsername:aUsername];
        if (!error1) {
            NSLog(@"你已拒绝添加对方为好友");
        }
    }];
    
    
    [alert addAction:action1];
    [alert addAction:action2];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
