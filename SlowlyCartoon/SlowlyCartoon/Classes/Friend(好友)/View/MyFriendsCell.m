//
//  MyFriendsCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "MyFriendsCell.h"

@implementation MyFriendsCell

- (void)awakeFromNib {
    // Initialization code
    
    self.imageV.layer.masksToBounds = YES;
    self.imageV.layer.cornerRadius = self.imageV.layer.bounds.size.width/2;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
