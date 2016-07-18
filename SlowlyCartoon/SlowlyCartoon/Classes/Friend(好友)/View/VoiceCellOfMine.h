//
//  VoiceCellOfMine.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VoiceCellOfMine_identify @"VoiceCellOfMine_identify"
@interface VoiceCellOfMine : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong, nonatomic) IBOutlet UILabel *guestureLabel;



@end
