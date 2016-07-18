//
//  RankListModel.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankListModel : NSObject


@property(nonatomic,strong)NSString *oneID;  //位置识别ID
@property(nonatomic,strong)NSString *comic_name;//漫画名称
@property(nonatomic,strong)NSString *comic_desc;//漫画简介
@property(nonatomic,strong)NSString *comic_sort_id;
@property(nonatomic,strong)NSString *comic_update_time;//时间参数
@property(nonatomic,strong)NSString *is_show;
@property(nonatomic,strong)NSString *comic_theme_id_1;
@property(nonatomic,strong)NSString *comic_theme_id_2;
@property(nonatomic,strong)NSString *comic_theme_id_3;
@property(nonatomic,strong)NSString *comic_type_id;
@property(nonatomic,strong)NSString *painter_user_nickname;//漫画作者
@property(nonatomic,strong)NSString *script_user_nickname;//漫画作者
@property(nonatomic,strong)NSString *comic_pic_516_306; //详情页面 大图
@property(nonatomic,strong)NSString *comic_pic_720_520; //详情页面 背景模糊图
@property(nonatomic,strong)NSString *comic_pic_240_320; //首页图片
@property(nonatomic,strong)NSString *comic_pic_300_300; //详情页面 图片
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *comic_last_orderidx;//集数
@property(nonatomic,strong)NSString *comic_isover;
@property(nonatomic,strong)NSString *comic_like_num;
@property(nonatomic,strong)NSString *score;// 点赞数
@property(nonatomic,strong)NSString *comic_comment_num; //评论数


@end
