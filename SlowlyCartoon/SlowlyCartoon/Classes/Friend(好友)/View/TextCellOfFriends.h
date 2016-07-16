//
//  TextCellOfFriends.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TextCellOfFriends_Identify @"TextCellOfFriends_Identify"
@interface TextCellOfFriends : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *friendsMessageLabel;

-(CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title font:(UIFont *)font;
@end
