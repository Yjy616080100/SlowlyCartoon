//
//  MineDetailTableViewCell.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MineDetailTableViewCell_Identify @"MineDetailTableViewCell"
@interface MineDetailTableViewCell : UITableViewCell
//内容
@property (strong, nonatomic) IBOutlet UILabel *comentLabel;

//详情
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

@end
