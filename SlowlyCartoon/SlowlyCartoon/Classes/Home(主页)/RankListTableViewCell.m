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
    
    _nameLabel.font = Font_18;
    
    _painterLabel.font = Font_18;
    
    _orderidxLabel.font = Font_18;
    
    _likeLabel.font = Font_14;
    
    _commentLabel.font = Font_14;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
