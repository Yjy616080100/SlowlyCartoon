//
//  DiversityViewController.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DiversityViewControllerDelegate <NSObject>

- (void)DiversityViewControllerPushAction:(NSString*)string;

- (void)DiversityViewControllerNavHideen;

@end
@interface DiversityViewController : UIViewController

@property (nonatomic, strong) NSString *briefIntroduceString;

@property (nonatomic, strong) NSMutableArray *diversityArray;


@property (nonatomic, assign)id <DiversityViewControllerDelegate>delegate;
@end
