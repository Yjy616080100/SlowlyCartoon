//
//  UITableView+Improve.m
//  MyFamily
//
//  Created by lanou3g on 16/7/22.
//  Copyright (c) 2016年 Slowly Pangpang. All rights reserved.
//

#import "UITableView+Improve.h"

@implementation UITableView (Improve)
-(void)improveTableView
{
    self.tableFooterView = [[UIView alloc]init];  //删除多余的行
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {  //防止分割线显示不
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
}

@end
