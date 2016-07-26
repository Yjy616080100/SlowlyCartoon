//
//  RankListTableViewCell.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RankListTableViewCell_Identify @"RankListTableViewCell"

@interface RankListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *onluOneImageV;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *painterLabel;

@property (strong, nonatomic) IBOutlet UILabel *orderidxLabel;

@property (strong, nonatomic) IBOutlet UILabel *likeLabel;

@property (strong, nonatomic) IBOutlet UILabel *commentLabel;

@end
