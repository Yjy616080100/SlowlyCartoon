//
//  ImageCellOfMine.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/17.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ImageCellOfMine_identify @"ImageCellOfMine_identify"
@interface ImageCellOfMine : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *sendImageOfMine;

@property(nonatomic)CGPoint pointCenter;

@end
