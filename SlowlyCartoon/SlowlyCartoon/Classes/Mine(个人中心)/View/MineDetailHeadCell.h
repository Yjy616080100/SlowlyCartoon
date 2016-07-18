//
//  MineDetailHeadCell.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MineDetailHeadCell_Identify @"MineDetailHeadCell_Identify"
@interface MineDetailHeadCell : UITableViewCell

//内容
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;

//头像
@property (strong, nonatomic) IBOutlet UIImageView *avatorImage;

@end
