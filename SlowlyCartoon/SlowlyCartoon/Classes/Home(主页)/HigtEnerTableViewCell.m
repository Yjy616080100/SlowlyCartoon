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
    
    _HightEnerLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:17];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
