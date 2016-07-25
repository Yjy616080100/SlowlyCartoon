//
//  MineSettingTableViewCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "MineSettingTableViewCell.h"

@implementation MineSettingTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _contentLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:20];
    
    _detailLbel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:17];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
