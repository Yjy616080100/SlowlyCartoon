//
//  firstScrollViewModel.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface firstScrollViewModel : NSObject

@property(nonatomic,strong)NSString *oneID; //唯一ID
@property(nonatomic,strong)NSString *active_name; //名称
@property(nonatomic,strong)NSString *active_info; //所属内别
@property(nonatomic,strong)NSString *active_type;
@property(nonatomic,strong)NSString *rank;
@property(nonatomic,strong)NSString *active_pic_url_1;
@property(nonatomic,strong)NSString *active_pic_url_2; //图片
@property(nonatomic,strong)NSString *is_show;
@property(nonatomic,strong)NSString *active_desc_url;
@property(nonatomic,strong)NSString *comic_id;
@property(nonatomic,strong)NSString *order_idx;
@property(nonatomic,strong)NSString *is_head;

@end
