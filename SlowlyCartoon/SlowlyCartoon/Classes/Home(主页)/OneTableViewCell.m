//
//  OneTableViewCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "OneTableViewCell.h"

@implementation OneTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    _nameLabel.font = Font_16;
    
    _descLabel.font = Font_16;
    
    _Label.font = Font_16;
    
    _Label.textColor = myRedColor;
    
    self.contentView.layer.cornerRadius = 10;
    
    self.contentView.layer.masksToBounds = YES;
}

@end
