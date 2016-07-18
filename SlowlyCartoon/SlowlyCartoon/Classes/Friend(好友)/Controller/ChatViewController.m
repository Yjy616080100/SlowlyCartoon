//
//  ChatViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "ChatViewController.h"
#import "TextCellOfMine.h"
#import "TextCellOfFriends.h"
#import "customView.h"
#import "ImageCellOfMine.h"
#import "ImageCellOfFriends.h"
#import "EMCDDeviceManager.h"
#import "voiceCellOfFriends.h"
#import "VoiceCellOfMine.h"
@interface ChatViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
EMClientDelegate,
EMChatManagerDelegate,
UITextViewDelegate,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
//存储文字消息的数组
@property(nonatomic,strong)NSMutableArray *textArray;
//下方工具栏的view
@property (strong, nonatomic) IBOutlet UIView *MyView;
//接收到文字消息的行高
@property(nonatomic,assign)CGFloat cellHeightOfFriends;
//发送文字消息的行高
@property(nonatomic,assign)CGFloat cellHeightOfMine;

//工具条的下约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *MyViewBottomConstraint;
//tableView的下约束
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tableViewBottomConstraint;
//flag标记是否点击了添加按钮
@property(nonatomic)BOOL flag;
//标记是否点击了语音按钮
@property(nonatomic)BOOL VoiceFlag;
//声明自定义view的属性
@property(nonatomic,strong)customView *toolView;
//语音按钮
@property (strong, nonatomic) IBOutlet UIButton *voiceButton;
//语音在服务器上的路径
@property(nonatomic,strong)NSString *VoicePath;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title =[NSString stringWithFormat:@"正在和%@聊天",self.name];
    self.tabBarController.tabBar.hidden=YES;
    UIImageView *imageV=[[UIImageView alloc]initWithFrame:self.tableView.bounds];
    imageV.image=[UIImage imageNamed:@"beijing2.jpg"];
    [self.tableView setBackgroundView:imageV];
    self.textArray=[NSMutableArray array];
    self.voiceButton.hidden =YES;
    self.VoicePath =[NSString string];
   
    
    //初始化自定义View
    self.flag = YES;
    self.VoiceFlag=YES;
    self.toolView=[[customView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200)];
    //注册观察者 -->监听collectionView 的点击下标
    [self.toolView addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.toolView];
    
    
    
    //1.通知中心监听事件，改变工具条的下约束
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KbWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //2. 键盘消失时的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KbWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //注册XIB
    [self.tableView registerNib:[UINib nibWithNibName:@"TextCellOfMine" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:TextCellOfMine_identify];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TextCellOfFriends" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:TextCellOfFriends_Identify];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageCellOfMine" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ImageCellOfMine_identify];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ImageCellOfFriends" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ImageCellOfFriends_identify];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"voiceCellOfFriends" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:voiceCellOfFriends_identify];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"VoiceCellOfMine" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:VoiceCellOfMine_identify];
    
    
    
    //创建一个和某人的单聊会话
    EMConversation *conversion=[[EMClient sharedClient].chatManager getConversation:self.name type:EMConversationTypeChat createIfNotExist:YES];
    //获取此人的聊天消息 （参数limit--->获取聊天记录的条数；EMMessageSearchDirectionUp：代表向上所搜）
    self.textArray=[conversion loadMoreMessagesContain:nil before:-1 limit:20 from:nil direction:(EMMessageSearchDirectionUp)].mutableCopy;
    //获取之后刷新
    [self scrollViewToButtom];
    [self.tableView reloadData];
    
    
    
    //导航栏的左右方法
    self.navigationItem.leftBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction)];
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:(UIBarButtonSystemItemEdit) target:self action:@selector(rightAcyion)];
    
    
   
    
}
//左方法
-(void)leftAction{
    
    //移除观察者
    [self.toolView removeObserver:self forKeyPath:@"index" context:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
//右方法
-(void)rightAcyion{
    
    
}








#pragma mark---------------1.监听系统键盘的弹出和消失------------------------------------

//键盘的监听事件--->键盘显示时触发
-(void)KbWillShow:(NSNotification *)notiFication{
    
    //1. 获取键盘高度
    CGRect keyBoard=[notiFication.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyBoardHeight =keyBoard.size.height;
    //2. 更改工具条的下约束
    self.MyViewBottomConstraint.constant =keyBoardHeight;
    self.tableViewBottomConstraint.constant =keyBoardHeight +50;
    //3. 添加动画，消除时间同步
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
        self.toolView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
    }];
    self.flag =YES;
    [self scrollViewToButtom];
    
}
//------->键盘隐藏时触发的方法
-(void)KbWillHide:(NSNotification *)notiFication{

    // 恢复工具条的位置
    self.MyViewBottomConstraint.constant =0;
    self.tableViewBottomConstraint.constant =50;
    self.toolView.frame =CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200);
    
}


//移除通知
-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark---------------2.滑动到tableView的最后一行------------------------------------

-(void)scrollViewToButtom{
  
    if (self.textArray.count <1) {
        
        return ;
    }
    
    //最后元素的下标
    NSIndexPath *index=[NSIndexPath indexPathForRow:self.textArray.count-1 inSection:0];
    //滑动到tableView最后一行的最下面
    [self.tableView scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    
}





#pragma mark---------------3.添加接收消息的代理，并将接收到的消息进行解析并存放在数组中--------

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //视图显示时，加代理--------->接收聊天消息的代理
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [self scrollViewToButtom];
}

//解析消息---->代理方法 (接收到消息时就调用)
- (void)didReceiveMessages:(NSArray *)aMessages{
    
    for (EMMessage *message in aMessages) {
        
        //如果会话的ID==当前的消息人，则加入到数组中，并在聊天界面展示
        if ([message.conversationId isEqualToString:self.name]) {
            
            [self.textArray addObject:message];
        }
    }
    
    [self.tableView reloadData];
    [self scrollViewToButtom];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    //视图消失的时候，移除代理
    [[EMClient sharedClient].chatManager removeDelegate:self];
    
    
}


#pragma mark----------------4.tableView的代理方法------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _textArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获得数组中的消息
    EMMessage *message =_textArray[indexPath.row];
    EMMessageBody *messageBody=message.body;
    
    
    switch (messageBody.type) {
        //1.文本类型
        case EMMessageBodyTypeText:{
            
            EMTextMessageBody *textBody =(EMTextMessageBody *)messageBody;
            NSString *string =textBody.text;
            
            if (message.direction ==EMMessageDirectionSend) {//发送方
                
                TextCellOfMine *cell=[tableView dequeueReusableCellWithIdentifier:TextCellOfMine_identify forIndexPath:indexPath];
                if (cell==nil) {
                    cell=[[TextCellOfMine alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:TextCellOfMine_identify];
                }
                cell.backgroundColor=[UIColor clearColor];
                cell.messageLabel.text =string;
                UIView *view=[[UIView alloc]initWithFrame:cell.contentView.bounds];
                view.backgroundColor=[UIColor clearColor];
                cell.selectedBackgroundView =view;
                self.cellHeightOfMine=[cell getHeightByWidth:78 title:string font:[UIFont systemFontOfSize:20]];
                
                return cell;
                
            }else{//接收方
                
                TextCellOfFriends *cell=[tableView dequeueReusableCellWithIdentifier:TextCellOfFriends_Identify forIndexPath:indexPath];
                if (cell==nil) {
                    
                    cell=[[TextCellOfFriends alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:TextCellOfFriends_Identify];
                }
                cell.backgroundColor=[UIColor clearColor];
                cell.friendsMessageLabel.text =string;
                self.cellHeightOfFriends = [cell getHeightByWidth:100 title:string font:[UIFont systemFontOfSize:20]];
                UIView *view=[[UIView alloc]initWithFrame:cell.contentView.bounds];
                view.backgroundColor=[UIColor clearColor];
                cell.selectedBackgroundView =view;
                return cell;
            }
            break;
            
        }
        //2.图片类型
        case EMMessageBodyTypeImage:{
            
            EMImageMessageBody *body =(EMImageMessageBody *)messageBody;
            NSString *path =body.remotePath ;//在服务器上的路径
            NSLog(@"图片在服务器上的路径--%@",path);
            NSURL *url =[NSURL URLWithString:path];
            NSData *data=[NSData dataWithContentsOfURL:url];
            
            if (message.direction ==EMMessageDirectionSend) {
                
                ImageCellOfMine *cell =[tableView dequeueReusableCellWithIdentifier:ImageCellOfMine_identify];
                if (nil ==cell) {
                    
                    cell=[[ImageCellOfMine alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ImageCellOfMine_identify];
                }
                cell.sendImageOfMine.image =[UIImage imageWithData:data];
                cell.backgroundColor=[UIColor clearColor];
                UIView *view=[[UIView alloc]initWithFrame:cell.contentView.bounds];
                view.backgroundColor=[UIColor clearColor];
                cell.selectedBackgroundView =view;
                return cell;
                
            }else{
                
                ImageCellOfFriends *cell=[tableView dequeueReusableCellWithIdentifier:ImageCellOfFriends_identify];
                
                if (nil ==cell) {
                    
                    cell=[[ImageCellOfFriends alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ImageCellOfFriends_identify];
                    
                }
                cell.sendImageOfFriends.image=[UIImage imageWithData:data];
                cell.backgroundColor=[UIColor clearColor];
                UIView *view=[[UIView alloc]initWithFrame:cell.contentView.bounds];
                view.backgroundColor=[UIColor clearColor];
                cell.selectedBackgroundView =view;
                return cell;
                
            }
            break;
        }
        //3.语音类型
        case EMMessageBodyTypeVoice:{

            EMVoiceMessageBody *MyBody =(EMVoiceMessageBody *)messageBody;
            self.VoicePath = MyBody.localPath ;//在本地的路径
            NSLog(@"bendi-----%@",self.VoicePath);
            if (message.direction == EMMessageDirectionSend) {
                
                VoiceCellOfMine *cell =[tableView dequeueReusableCellWithIdentifier:VoiceCellOfMine_identify];
                if (nil ==cell) {
                    
                    cell=[[VoiceCellOfMine alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:VoiceCellOfMine_identify];
                }
                cell.backgroundColor=[UIColor clearColor];
                UIView *view=[[UIView alloc]initWithFrame:cell.contentView.bounds];
                view.backgroundColor=[UIColor clearColor];
                cell.selectedBackgroundView =view;
                cell.tag =1000;
                cell.timeLabel.text =[NSString stringWithFormat:@"%d” ",MyBody.duration];
                
                UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playVoiceOfMine:)];
                cell.guestureLabel.userInteractionEnabled =YES;
                [cell.guestureLabel addGestureRecognizer:tap];
                

                return cell;
      
            }else{
                    
                voiceCellOfFriends *cell =[tableView dequeueReusableCellWithIdentifier:voiceCellOfFriends_identify];
                if (nil ==cell) {
                        
                cell=[[voiceCellOfFriends alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:voiceCellOfFriends_identify];
                }
                cell.backgroundColor=[UIColor clearColor];
                UIView *view=[[UIView alloc]initWithFrame:cell.contentView.bounds];
                view.backgroundColor=[UIColor clearColor];
                cell.selectedBackgroundView =view;
                cell.tag =2000;
                cell.timeLabel.text =[NSString stringWithFormat:@"%d” ",MyBody.duration];
   
                UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playVoiceOfFriends:)];
//                cell.guestureLabel.userInteractionEnabled =YES;
                [cell.guestureLabel addGestureRecognizer:tap];
                
                return cell;
            }
     
            break;
        }
        //4.位置类型
        case EMMessageBodyTypeLocation:{
            return nil;
            break;
        }
        //5.视频类型
        case EMMessageBodyTypeVideo:{
            return nil;
            break;
        }
            
        default:{
            return nil;
            break;
        }
    }
}

-(void)playVoiceOfMine:(UITapGestureRecognizer *)sender{
    
    NSLog(@"---语音的本地路径--%@",self.VoicePath);
    VoiceCellOfMine *cell =[self.view viewWithTag:1000];
    [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:self.VoicePath completion:^(NSError *error) {
       
        if ( !error) {
            
            NSLog(@"语音播放完毕");

            [cell.imageV stopAnimating];
            
        }else{
            NSLog(@"播放语音失败--%@",error);
        }
    }];
    
    cell.imageV.animationImages =@[[UIImage imageNamed:@"q1"],[UIImage imageNamed:@"q2"],
                              [UIImage imageNamed:@"q3"]];
    cell.imageV.animationDuration =1;
    cell.imageV.animationRepeatCount =YES;
    [cell.imageV startAnimating];
    
    
}

-(void)playVoiceOfFriends:(UITapGestureRecognizer *)sender{
    
    NSLog(@"---语音的本地路径--%@",self.VoicePath);
    
    voiceCellOfFriends *cell =[self.view viewWithTag:2000];
    [[EMCDDeviceManager sharedInstance] asyncPlayingWithPath:self.VoicePath completion:^(NSError *error) {
        
        if ( !error) {
            
            NSLog(@"语音播放完毕");
            [cell.imageV stopAnimating];
            
        }else{
            NSLog(@"播放语音失败--%@",error);
        }
    }];
    
    
    cell.imageV.animationImages =@[[UIImage imageNamed:@"q1"],[UIImage imageNamed:@"q2"],
                                   [UIImage imageNamed:@"q3"]];
    cell.imageV.animationDuration =1;
    cell.imageV.animationRepeatCount =YES;
    [cell.imageV startAnimating];
    
    
}


//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    //取出数组元素
    EMMessage *message=_textArray[indexPath.row];
    EMMessageBody *messageBody=message.body;

    switch (messageBody.type) {
            
            //文本
        case EMMessageBodyTypeText:{
            if (message.direction ==EMMessageDirectionSend) {
        
                return self.cellHeightOfMine +40;
            }else{
                return self.cellHeightOfFriends +50;
            }
            break;
        }
            //图片
        case EMMessageBodyTypeImage:{
            
            return 168;
            break;
        }
            //语音
        case EMMessageBodyTypeVoice:{
            
            return 60;
            break;
        }

        default:{
            return 200; break;
        }
           
    }
}
//tableView 的点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"聊天界面---cell的点击事件--%ld行 ",indexPath.row);
    //取消选中状态
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark-------------------5. 发送文字消息按钮-----------------------------------

- (IBAction)SendButton:(UIButton *)sender {
    
    if (self.textView.text.length > 0) {
        
        //设置消息体
        EMTextMessageBody *body=[[EMTextMessageBody alloc]initWithText:self.textView.text];
        NSString *from=[[EMClient sharedClient] currentUsername];
        EMMessage *message=[[EMMessage alloc]initWithConversationID:self.name from:from to:self.name body:body ext:nil];
        message.chatType = EMChatTypeChat;// 设置为单聊消息
        
        __weak typeof(self) weakSelf=self;
        //调用发送消息的方法
        [[EMClient sharedClient].chatManager asyncSendMessage:message progress:^(int progress) {
            
            NSLog(@"发送文字消息的进度--%d",progress);
        } completion:^(EMMessage *message, EMError *error) {
            
            //将数据加入到数组
            [weakSelf.textArray addObject:message];
            //刷新UI
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [weakSelf.tableView reloadData];
                weakSelf.textView.text=nil;
                [weakSelf scrollViewToButtom];
            });
        }];
    }
}

#pragma mark-----------------6. 添加表情按钮------------------------------

- (IBAction)AddButton:(UIButton *)sender {
    
    //隐藏键盘
    __weak typeof(self) weakSelf = self;
    self.tableView.keyboardDismissMode =UIScrollViewKeyboardDismissModeOnDrag;
    NSLog(@"添加表情输出");
    
    if (self.flag) {
        
        [UIView animateWithDuration:0.2 animations:^{
            
            weakSelf.MyViewBottomConstraint.constant =200;
            weakSelf.tableViewBottomConstraint.constant =250;
            weakSelf.toolView.frame =CGRectMake(0, weakSelf.view.frame.size.height-200, weakSelf.view.frame.size.width, 200);
        } completion:^(BOOL finished) {
            
            weakSelf.flag=NO;
        }];
   
        
    }else{
        
        [UIView animateWithDuration:0.2 animations:^{
            
            weakSelf.MyViewBottomConstraint.constant =0;
            weakSelf.tableViewBottomConstraint.constant =50;
            weakSelf.toolView.frame =CGRectMake(0, weakSelf.view.frame.size.height, weakSelf.view.frame.size.width, 200);
            
        } completion:^(BOOL finished) {
            
            weakSelf.flag = YES;
        }];

    }
}
//执行观察者
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    switch (self.toolView.index) {
        //图片
        case 0:{
            NSLog(@"-------%ld--发送图片功能",self.toolView.index);
            [self sendImages];
            break;
        }
        //收藏
        case 1:{
            NSLog(@"-------%ld--收藏功能",self.toolView.index);
            break;
        }
        //位置
        case 2:{
            NSLog(@"-------%ld--发送位置功能",self.toolView.index);
            break;
        }
        //语音聊天
        case 3:{
            NSLog(@"-------%ld--语音聊天功能",self.toolView.index);
            break;
        }
        //发送视频
        case 4:{
            NSLog(@"-------%ld--发送视频功能",self.toolView.index);
            break;
        }
        //我的名片
        case 5:{
            NSLog(@"-------%ld--我的名片功能",self.toolView.index);
            break;
        }
        //转账
        case 6:{
            NSLog(@"-------%ld--转账功能",self.toolView.index);
            break;
        }
        default:{
            break;
        }
    }
}



//调用相册，发送图片
-(void)sendImages{
    
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc]init];
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerVC.delegate =self;
    [self presentViewController:pickerVC animated:YES completion:nil];
    
}

//调用相册的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    
    //将图片转化为NSData类型
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    //生成消息 ，发送图片数据
    EMImageMessageBody *imageBody =[[EMImageMessageBody alloc]initWithData:data displayName:@"图片"];
    NSString *from =[[EMClient sharedClient] currentUsername];
    
    EMMessage *message=[[EMMessage alloc]initWithConversationID:self.name from:from to:self.name body:imageBody ext:nil];
    message.chatType =EMChatTypeChat ;
    
    __weak typeof(self) weakSelf =self;
    [[EMClient sharedClient].chatManager asyncSendMessage:message progress:^(int progress) {
        NSLog(@"--这是发送图片的进度--%d",progress);
    } completion:^(EMMessage *message, EMError *error) {
        
        //加入数组， 刷新UI
        [weakSelf.textArray addObject:message];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakSelf.tableView reloadData];
            [weakSelf scrollViewToButtom];
            
        });
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark-----------------7. 录制语音按钮------------------------------

- (IBAction)VoiceButton:(UIButton *)sender {
    
    self.VoiceFlag = !self.VoiceFlag;
    
    if (self.VoiceFlag ) {
        
        _voiceButton.hidden =YES;
    }else{
        _voiceButton.hidden =NO;
    }
}

//1.点下按钮 ，开始录音
- (IBAction)TouchDownAction:(UIButton *)sender {
    
    //录音文件以时间命名，不会重复
//    int x =arc4random() %100000 ;
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    NSString *fileName = [NSString stringWithFormat:@"%d",(int)time];
    
    [sender setTitle:@"松开发送" forState:(UIControlStateNormal)];
    //调用环信自带的录音方法
    [[EMCDDeviceManager sharedInstance] asyncStartRecordingWithFileName:fileName completion:^(NSError *error) {
       
        if (error == nil) {
            
            NSLog(@"开始录音成功");
        }
    }];
}

//2.松开手指 ，停止录音
- (IBAction)TouchUpInsideAction:(UIButton *)sender {
    
    __weak typeof(self) weakSelf = self;
    [[EMCDDeviceManager sharedInstance] asyncStopRecordingWithCompletion:^(NSString *recordPath, NSInteger aDuration, NSError *error) {
        if (error == nil) {
            
            NSLog(@"录音成功--%@",recordPath);
            [sender setTitle:@"按住说话" forState:(UIControlStateNormal)];
            //发送语音到服务器
            [weakSelf sendVoiceMessage:recordPath duration:aDuration];
        }else{
            NSLog(@"--录音失败--%@",error);
        }
        
    }];
}
//3.取消发送录音
- (IBAction)TouchUpOutSide:(UIButton *)sender {
    
    NSLog(@"---TouchUpOutSide--取消发送录音");
    [[EMCDDeviceManager sharedInstance] cancelCurrentRecording];
    [sender setTitle:@"按住说话" forState:(UIControlStateNormal)];
    
}

//自定义发送语音消息
-(void)sendVoiceMessage:(NSString *)fileNamePath
               duration:(NSInteger)duration{
    
    //1. 构造语音消息体
    EMVoiceMessageBody *body =[[EMVoiceMessageBody alloc]initWithLocalPath:fileNamePath displayName:@"[语音]"];
    body.duration = (int)duration;
    NSString *from =[[EMClient sharedClient] currentUsername];
    EMMessage *message = [[EMMessage alloc]initWithConversationID:self.name from:from to:self.name body:body ext:nil];
    message.chatType = EMChatTypeChat ;
    
    //2. 发送
    __weak typeof(self) weakSelf = self;
    [[EMClient sharedClient].chatManager asyncSendMessage:message progress:^(int progress) {
        NSLog(@"--发送语音消息的进度--%d",progress);
    } completion:^(EMMessage *message, EMError *error) {
        
        if (!error) {
            
            [weakSelf.textArray addObject:message];
            dispatch_async(dispatch_get_main_queue(), ^{
               
                [weakSelf.tableView reloadData];
                [weakSelf scrollViewToButtom];
            });
            
        }else{
            NSLog(@"--发送语音消息失败--%@",error);
        }
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
