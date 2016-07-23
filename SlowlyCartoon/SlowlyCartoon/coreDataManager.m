//
//  coreDataManager.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "coreDataManager.h"
#import "AppDelegate.h"
#import "PersonManager.h"

@interface coreDataManager ()

@property(nonatomic,strong)NSManagedObjectContext *objectContext;
@end

@implementation coreDataManager

//懒加载
-(NSManagedObjectContext *)objectContext{
    
    if (_objectContext == nil) {
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        _objectContext = app.managedObjectContext;
        
    }
    return _objectContext;
}


//单例
static coreDataManager *manager = nil;
+(instancetype)sharecoreDataManager{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[coreDataManager alloc]init];
    });
    return manager;
}



//搜索数据库
-(NSArray *)selectObjectContext{
    
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:@"PersonManager"];
    NSArray *tempArray=[self.objectContext executeFetchRequest:request error:nil];
    
    return tempArray;
    
}
//添加数据库
-(void)addObjectContext:(NSString *)userName
                 avator:(NSData *)avator
                 gender:(NSString *)gender
               bornYear:(NSString *)bornYear
               cityName:(NSString *)cityName
               qqNumber:(NSString *)qqNumber
           weChatNumber:(NSString *)weChatNumber
             weBoNumber:(NSString *)weBoNumber
          mailboxNumber:(NSString *)mailboxNumber
            phoneNumber:(NSString *)phoneNumber{
    
    
    PersonManager *model=[NSEntityDescription insertNewObjectForEntityForName:@"PersonManager" inManagedObjectContext:self.objectContext];
    
    model.userName = userName;
    model.avator = avator;
    model.gender = gender;
    model.bornYear = bornYear;
    model.cityName = cityName;
    model.qqNumber = qqNumber;
    model.weChatNumber = weChatNumber;
    model.weBoNumber = weBoNumber;
    model.mailboxNumber = mailboxNumber;
    model.phoneNumber = phoneNumber;
    
    NSError *error=nil;
    //保存
    [self.objectContext save:&error];
    
    
}

//删除数据库
-(void)deleteObjectContext:(PersonManager *)model{
    
    
    [self.objectContext deleteObject:model];
    NSError *error=nil;
    //保存
    [self.objectContext save:&error];
 
}

//更新数据库
-(void)upDateWithPerson:(PersonManager *)model{
    
    NSArray *tempArray = [self selectObjectContext];
    
    for (PersonManager *tempModel in tempArray) {
        
        if ([tempModel.userName isEqualToString:model.userName]) {
            
            tempModel.userName = model.userName;
            tempModel.avator = model.avator;
            tempModel.gender = model.gender;
            tempModel.bornYear = model.bornYear;
            tempModel.cityName = model.cityName;
            tempModel.qqNumber = model.qqNumber;
            tempModel.weChatNumber = model.weChatNumber;
            tempModel.weBoNumber = model.weBoNumber;
            tempModel.mailboxNumber = model.mailboxNumber;
            model.phoneNumber = model.phoneNumber;
            
            NSError *error=nil;
            //保存
            [self.objectContext save:&error];
            
        }
    }
}


@end
