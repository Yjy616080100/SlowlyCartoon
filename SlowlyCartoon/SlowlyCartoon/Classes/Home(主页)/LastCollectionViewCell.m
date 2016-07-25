//
//  LastCollectionViewCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "LastCollectionViewCell.h"

@implementation LastCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    _nameLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:14];
    
    _orderidxLabel.font = [UIFont fontWithName:@"Li-Xuke-Comic-Font" size:10];
    
    _orderidxLabel.textColor = myRedColor;
}

@end
