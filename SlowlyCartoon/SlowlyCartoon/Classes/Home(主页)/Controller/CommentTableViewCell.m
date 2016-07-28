//
//  CommentTableViewCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.userInteractionEnabled = NO;
    
    _nameLabel.font = Font_24;
    
    _nameLabel.textColor = myRedColor;
    
    _timeLabel.font = Font_16;
    
    _msgLabel.font = Font_20;
    
    self.contentView.backgroundColor = myWhiteColor;
    
    self.bgView.layer.cornerRadius = 15;
    
    self.bgView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
