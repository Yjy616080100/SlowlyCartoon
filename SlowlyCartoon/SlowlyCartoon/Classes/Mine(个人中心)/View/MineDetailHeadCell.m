//
//  MineDetailHeadCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "MineDetailHeadCell.h"

@implementation MineDetailHeadCell

- (void)awakeFromNib {
    // Initialization code
    
    _avatorImage.layer.cornerRadius = 40;
    
    _avatorImage.layer.masksToBounds = YES;
    
    _contentLabel.font = Font_22;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
