//
//  FamilyGroupCell.h
//  MyFamily
//
//  Created by lanou3g on 16/7/22.
//  Copyright (c) 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FamilyGroupFrame.h"
typedef void (^ImageBlock)(NSArray *imageViews,NSInteger clickTag);


@interface FamilyGroupCell : UITableViewCell

@property (nonatomic,strong)FamilyGroupFrame *familyGroupFrame;

@property (weak,nonatomic)UIButton *replyButton;

@property (strong,nonatomic)ImageBlock imageBlock;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
