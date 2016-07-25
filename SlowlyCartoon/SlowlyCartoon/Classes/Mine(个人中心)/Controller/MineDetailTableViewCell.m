//
//  MineDetailTableViewCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "MineDetailTableViewCell.h"

@implementation MineDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _comentLabel.font = Font_22;
    
    _detailLabel.font = Font_20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
