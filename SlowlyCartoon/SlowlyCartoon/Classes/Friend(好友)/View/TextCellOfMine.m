//
//  TextCellOfMine.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "TextCellOfMine.h"

@implementation TextCellOfMine

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    self.messageLabel.text = title;
    self.messageLabel.font = font;
    self.messageLabel.numberOfLines = 0;
    [self.messageLabel sizeToFit];
    CGFloat height = self.messageLabel.frame.size.height;
    
    return height;
}



@end
