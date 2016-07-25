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
    
    _nameLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:17];
    
    _painterLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:17];
    
    _orderidxLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:17];
    
    _likeLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:14];
    
    _commentLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
