//
//  CommentViewController.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentViewController : UIViewController

@property(nonatomic,strong)NSMutableArray *commentArray;

@property(nonatomic,strong)UITableView *commentTableView;
@end
