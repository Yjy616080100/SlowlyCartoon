//
//  CommentModel.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

@property(nonatomic,strong)NSString *comic_id;
@property(nonatomic,strong)NSString *hot_number;
@property(nonatomic,strong)NSString *hot_user_ids;
@property(nonatomic,strong)NSString *yonghuID;
@property(nonatomic,strong)NSString *is_hot;
@property(nonatomic,strong)NSString *order_comment_msg;
@property(nonatomic,strong)NSString *order_comment_time;
@property(nonatomic,strong)NSString *reply_number;
@property(nonatomic,strong)NSString *user_id;
@property(nonatomic,strong)NSString *user_nickname;
@property(nonatomic,strong)NSString *user_pic;

@end
