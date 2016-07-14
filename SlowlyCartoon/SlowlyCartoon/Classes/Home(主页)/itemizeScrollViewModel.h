//
//  itemizeScrollViewModel.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface itemizeScrollViewModel : NSObject

@property(nonatomic,strong)NSString *oneID; // 唯一ID
@property(nonatomic,strong)NSString *topic_name; //下标名称
@property(nonatomic,strong)NSString *topic_pic_url; //图片
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *topic_tag_name; //所属内别
@property(nonatomic,strong)NSString *is_show;


@end
