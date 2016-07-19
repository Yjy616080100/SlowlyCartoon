//
//  VoiceCellOfMine.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VoiceCellOfMine_identify @"VoiceCellOfMine_identify"
@class VoiceCellOfMine;

@protocol VoiceCellOfMineDelegate <NSObject>

- (void)playVoiceOnMineCell:(VoiceCellOfMine*)MineCell;

@end

@interface VoiceCellOfMine : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *guestureLabel;

@property(nonatomic,strong)NSString *path;

@property (assign , nonatomic) id<VoiceCellOfMineDelegate> dellegate;

@end
