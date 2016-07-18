//
//  voiceCellOfFriends.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define voiceCellOfFriends_identify @"voiceCellOfFriends_identify"
@interface voiceCellOfFriends : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *guestureLabel;
@property (strong, nonatomic) IBOutlet UIView *view;


@end
