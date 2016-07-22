//
//  PersonManager+CoreDataProperties.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PersonManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonManager (CoreDataProperties)

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

@end

NS_ASSUME_NONNULL_END
