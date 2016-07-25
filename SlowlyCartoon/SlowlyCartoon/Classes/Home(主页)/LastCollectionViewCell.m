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
    _nameLabel.font = Font_14;
    
    _orderidxLabel.font = Font_12;
    
    _orderidxLabel.textColor = myRedColor;
}

@end
