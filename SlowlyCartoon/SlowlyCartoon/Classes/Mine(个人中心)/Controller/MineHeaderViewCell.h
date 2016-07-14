//
//  MineHeaderViewCell.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define MineHeaderViewCell_Identify @"MineHeaderViewCell_Identify"
@interface MineHeaderViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *avatorImage;
@property (strong, nonatomic) IBOutlet UILabel *contentField;

@end
