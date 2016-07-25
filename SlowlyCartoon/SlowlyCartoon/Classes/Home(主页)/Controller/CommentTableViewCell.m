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
    
    _nameLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:20];
    
    _timeLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:10];
    
    _msgLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:14];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
