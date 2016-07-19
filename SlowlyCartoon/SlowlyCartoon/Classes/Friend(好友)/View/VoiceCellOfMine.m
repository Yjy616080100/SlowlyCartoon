//
//  VoiceCellOfMine.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "VoiceCellOfMine.h"

@implementation VoiceCellOfMine

- (void)awakeFromNib {
    // Initialization code
    
    self.guestureLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];

    [self.guestureLabel addGestureRecognizer:tapGesture];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)tapGestureAction:(UIGestureRecognizer* )sender{
    
    if (_dellegate && [_dellegate respondsToSelector:@selector(playVoiceOnMineCell:)]) {
        
        [_dellegate playVoiceOnMineCell:self];
    }
}



@end
