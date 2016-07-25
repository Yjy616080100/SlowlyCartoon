//
//  MineHeaderViewCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "MineHeaderViewCell.h"

@implementation MineHeaderViewCell

- (void)awakeFromNib {
    // Initialization code
    
//    切头像圆角
    _avatorImage.layer.masksToBounds =YES;
    
    _avatorImage.layer.cornerRadius = 55;
    
    _contentField.font = Font_28;
    
    _contentField.textColor = myRedColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
