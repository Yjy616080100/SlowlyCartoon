//
//  DiversityCollectionViewCell.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "DiversityCollectionViewCell.h"

@implementation DiversityCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
//    _BGImageV.layer.cornerRadius = 5;
//    
//    _BGImageV.layer.masksToBounds = YES;
//    
//    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.layer.cornerRadius = 10;
    
    self.layer.masksToBounds = YES;
    
    _nameLabel.font = Font_22;
}

@end
