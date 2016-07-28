//
//  CommentViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentTableViewCell.h"
#import "CommentModel.h"

@interface CommentViewController ()
<
UITableViewDataSource,
UITableViewDelegate
>



@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加TableView
    [self addtableView];
    
    self.commentArray = [NSMutableArray array];
    
}
- (void)addtableView
{
    self.commentTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    self.commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    self.commentTableView.delegate = self;
    
    self.commentTableView.dataSource = self;
    
    [self.commentTableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommentTableViewCell_Identify];
    
    [self.view addSubview:self.commentTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.commentArray.count;
}
#define cellPadding 2
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return cellPadding;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectio{
//    return cellPadding;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommentTableViewCell_Identify];
    
    CommentModel *model = self.commentArray[indexPath.row];
    
    [cell.ImageV setImageWithURL:[NSURL URLWithString:model.user_pic]];
    
    cell.nameLabel.text = model.user_nickname;
    
    cell.timeLabel.text = model.order_comment_time;
    
    cell.msgLabel.text = model.order_comment_msg;
    
    return cell;
}
#define cellHeight 150
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return cellHeight;
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
