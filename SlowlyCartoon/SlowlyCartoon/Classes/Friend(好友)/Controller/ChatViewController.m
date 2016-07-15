//
//  ChatViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "ChatViewController.h"
#import "TextCellOfMine.h"
@interface ChatViewController ()
<
UITableViewDataSource,
UITableViewDelegate,
EMClientDelegate,
EMChatManagerDelegate
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
//存储文字消息的数组
@property(nonatomic,strong)NSMutableArray *textArray;
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
    
    
    //注册XIB
    [self.tableView registerNib:[UINib nibWithNibName:@"TextCellOfMine" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:TextCellOfMine_identify];
    
    
    //创建一个和某人的单聊会话 (参数1：创建和某人的会话; 参数2：聊天类型 ;参数3：没有此会话则创建)
    EMConversation *conversion=[[EMClient sharedClient].chatManager getConversation:self.name type:EMConversationTypeChat createIfNotExist:YES];
    //获取此人的聊天消息 （参数limit--->获取聊天记录的条数；EMMessageSearchDirectionUp：代表向上所搜）
    self.textArray=[conversion loadMoreMessagesContain:nil before:-1 limit:10 from:nil direction:(EMMessageSearchDirectionUp)].mutableCopy;
    //获取之后刷新
    [self.tableView reloadData];
    
    
    
   
    
}


#pragma mark---------------1.添加接收消息的代理，并将接收到的消息进行解析并存放在数组中--------------------------

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //视图显示时，加代理--------->接收聊天消息的代理
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
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
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    //视图消失的时候，移除代理
    [[EMClient sharedClient].chatManager removeDelegate:self];
    
}


#pragma mark------------------------2.tableView的代理方法------------------------------

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
                
                return cell;
                
            }else{//接收方
                
                
                
                
            }
            
        }
        //2.图片类型
        case EMMessageBodyTypeImage:{
            
            
        }
        //3.语音类型
        case EMMessageBodyTypeVoice:{
            
            
        }
        //4.位置类型
        case EMMessageBodyTypeLocation:{
            
            
        }
        //5.视频类型
        case EMMessageBodyTypeVideo:{
            
            
        }
            
        default:{
            return nil; break;
        }
           
    }
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130;
}
#pragma mark------------------------发送消息按钮------------------------------

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
            });
        }];
    }
}



















#pragma mark------------------------录制语音按钮------------------------------

- (IBAction)VoiceButton:(UIButton *)sender {
    
    
    
    
    
    
}
#pragma mark------------------------添加表情按钮------------------------------

- (IBAction)AddButton:(UIButton *)sender {
    
    
    
    
    
    
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
