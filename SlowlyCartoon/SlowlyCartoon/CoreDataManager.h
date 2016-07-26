//
//  CoreDataManager.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
/*
 @property (nullable, nonatomic, retain) NSString *userName;
 @property (nullable, nonatomic, retain) NSData *avator;
 @property (nullable, nonatomic, retain) NSString *gender;
 @property (nullable, nonatomic, retain) NSString *bornYear;
 @property (nullable, nonatomic, retain) NSString *cityName;
 @property (nullable, nonatomic, retain) NSString *qqNumber;
 @property (nullable, nonatomic, retain) NSString *weChatNumber;
 @property (nullable, nonatomic, retain) NSString *weBoNumber;
 @property (nullable, nonatomic, retain) NSString *mailboxNumber;
 @property (nullable, nonatomic, retain) NSString *phoneNumber;
 */

#import <Foundation/Foundation.h>
@class PersonManager;
@interface CoreDataManager : NSObject

//单例
+(instancetype)shareCoreDataManager;


//查询数据库
-(NSArray *)selectObjectContextFromDbName:(NSString*)dbName;
//添加数据
-(void)addObjectContextWithUserName:(NSString *)userName
                 avator:(NSData *)avator
                 gender:(NSString *)gender
               bornYear:(NSString *)bornYear
               cityName:(NSString *)cityName
               qqNumber:(NSString *)qqNumber
           weChatNumber:(NSString *)weChatNumber
             weBoNumber:(NSString *)weBoNumber
          mailboxNumber:(NSString *)mailboxNumber
            phoneNumber:(NSString *)phoneNumber
                 dbName:(NSString*)dbName;

//删除数据库
-(void)deleteObjectContext:(PersonManager *)model fromDb:(NSString*)dbName;

//更新数据库
-(void)upDateWithPerson:(PersonManager *)model dbName:(NSString*)dbName;

//通过userNam查询
- (NSArray* )selectPersonManager;










@end
