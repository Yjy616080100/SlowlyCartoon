//
//  CustomCollectionViewCell.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CustomCollectionViewCell_identify @"CustomCollectionViewCell_identify"
@interface CustomCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageV;
@property (strong, nonatomic) IBOutlet UILabel *Label;



@end
