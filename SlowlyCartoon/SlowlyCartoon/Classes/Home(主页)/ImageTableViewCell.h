//
//  ImageTableViewCell.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ImageTableViewCell_Identify @"ImageTableViewCell_Identify"

@interface ImageTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageV;

@end
