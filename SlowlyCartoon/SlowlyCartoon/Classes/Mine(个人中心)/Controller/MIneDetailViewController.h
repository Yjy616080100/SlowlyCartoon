//
//  MIneDetailViewController.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^updateInfoBlock) (void);
@interface MIneDetailViewController : UIViewController


@property (copy,nonatomic)updateInfoBlock updateBlcok;
@end
