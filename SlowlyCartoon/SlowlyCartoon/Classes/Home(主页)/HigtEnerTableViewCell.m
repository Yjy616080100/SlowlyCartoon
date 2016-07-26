//
//  HigtEnerTableViewCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "HigtEnerTableViewCell.h"

@implementation HigtEnerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _HightEnerLabel.font = Font_20;
    
    _HightEnerLabel.textColor = myRedColor;
    
    self.contentView.layer.cornerRadius = 10;
    
    self.contentView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
