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
    
    _contentLabel.font = Font_20;
    
    _detailLbel.font = Font_18;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
