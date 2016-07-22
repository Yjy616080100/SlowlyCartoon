//
//  TwoDimensionalCodeView.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoDimensionalCodeView : UIView


@property(nonatomic,strong)UIImageView *TwoDimensionalCodeImageV;
@property(nonatomic,strong)UIImageView *MyImageV;
@property(nonatomic,strong)UILabel *textLabel;
//初始化方法
-(instancetype)initWithFrame:(CGRect)frame
              currentUseName:(NSString *)useName;

@end
