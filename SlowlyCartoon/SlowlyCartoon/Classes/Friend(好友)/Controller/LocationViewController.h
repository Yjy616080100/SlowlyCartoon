//
//  LocationViewController.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void(^valueBlock) (UIImage *);
@interface LocationViewController : UIViewController

@property(nonatomic,copy)valueBlock MyBlock;

@end
