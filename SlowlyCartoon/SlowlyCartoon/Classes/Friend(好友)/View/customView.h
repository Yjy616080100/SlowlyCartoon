//
//  customView.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface customView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UICollectionView *collectView;

//检测点击的cell 的下标
@property(nonatomic)NSInteger index;


@end
