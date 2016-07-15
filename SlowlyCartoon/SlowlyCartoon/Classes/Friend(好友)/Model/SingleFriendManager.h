//
//  SingleFriendManager.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingleFriendManager : NSObject

//单例
+(instancetype)shareSingleFriendManager;

//从服务器获取好友
-(NSArray *)requestAllFrineds;

//添加好友 (用户A添加用户B)
-(void)addFriendWithName:(NSString *)useName;

//删除好友
-(void)deleteFriendWithName:(NSString *)useName;

//加入黑名单
-(void)addFriendToBlackListWithName:(NSString *)userName;

//将好友从黑名单移除
-(void)removeBlackListWithUserName:(NSString *)userName;






@end
