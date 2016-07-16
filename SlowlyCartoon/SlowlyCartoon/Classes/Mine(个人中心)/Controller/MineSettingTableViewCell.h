//
//  MineSettingTableViewCell.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MineSettingTableViewCell_Identify @"MineSettingTableViewCell_Identify"
@interface MineSettingTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLbel;

@end
