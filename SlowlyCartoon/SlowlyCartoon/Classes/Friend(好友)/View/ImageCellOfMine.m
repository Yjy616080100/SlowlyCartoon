//
//  ImageCellOfMine.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/17.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "ImageCellOfMine.h"

@implementation ImageCellOfMine

- (void)awakeFromNib {

    
    self.sendImageOfMine.userInteractionEnabled = YES;
    //双击放大
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired=2;
    tap.numberOfTouchesRequired=1;
    [self.sendImageOfMine addGestureRecognizer:tap];
    
    //长按缩小
    UILongPressGestureRecognizer *longP=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPAction:)];
    longP.numberOfTapsRequired=0;
    longP.numberOfTouchesRequired=1;
    longP.minimumPressDuration=1;//设置长按时间为1S
    [self.sendImageOfMine addGestureRecognizer:longP];
    
    
    self.pointCenter = self.sendImageOfMine.center;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)tapAction:(UITapGestureRecognizer *)sender{
    
    self.sendImageOfMine.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 300);
  
}
-(void)longPAction:(UITapGestureRecognizer *)sender{
    
    self.sendImageOfMine.bounds = CGRectMake(0, 0, 115, 141);
    
    self.sendImageOfMine.center = CGPointMake(280.5, 85.5);

    
}


@end
