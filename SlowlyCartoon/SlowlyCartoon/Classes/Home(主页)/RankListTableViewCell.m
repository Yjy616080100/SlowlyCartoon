//
//  RankListTableViewCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "RankListTableViewCell.h"

@implementation RankListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    _nameLabel.font = Font_22;
    
    _painterLabel.font = Font_20;
    
    _orderidxLabel.font = Font_20;
    
    _likeLabel.font = Font_16;
    
    _commentLabel.font = Font_16;
    
    self.contentView.backgroundColor = myWhiteColor;
    
    self.contentView.layer.cornerRadius = 10;
    
    self.contentView.layer.masksToBounds = YES;
    
    _onluOneImageV.layer.cornerRadius = 10;
    
    _onluOneImageV.layer.masksToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
