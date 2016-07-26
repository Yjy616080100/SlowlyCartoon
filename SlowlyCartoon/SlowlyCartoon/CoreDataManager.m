//
//  CoreDataManager.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "CoreDataManager.h"
#import "AppDelegate.h"
#import "PersonManager.h"

@interface CoreDataManager ()

@property(nonatomic,strong)NSManagedObjectContext *objectContext;
@end

@implementation CoreDataManager

//懒加载
-(NSManagedObjectContext *)objectContext{
    
    if (_objectContext == nil) {
        
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        
        _objectContext = app.managedObjectContext;
        
    }
    return _objectContext;
}


//单例
static CoreDataManager *manager = nil;

+(instancetype)shareCoreDataManager{
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        manager = [[CoreDataManager alloc]init];
    });
    
    return manager;
}



//查询全部数据库
-(NSArray *)selectObjectContextFromDbName:(NSString*)dbName{
    
    NSFetchRequest *request=[[NSFetchRequest alloc]initWithEntityName:dbName];
    NSArray *tempArray=[self.objectContext executeFetchRequest:request error:nil];
    
    return tempArray;
    
}

//通过userName查询数据库
- (NSArray* )selectPersonManager{
    
    NSEntityDescription * entity  = [NSEntityDescription entityForName:dataBaseName inManagedObjectContext:self.objectContext];
    
    NSFetchRequest * request = [[NSFetchRequest alloc]init];
    
    [request setEntity:entity];
    
    NSArray * tempArray = [self.objectContext executeFetchRequest:request error:nil];
    
    return  tempArray;
}
//增加数据
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
                 dbName:(NSString*)dbName{
    
    
    PersonManager *model=[NSEntityDescription insertNewObjectForEntityForName:dbName inManagedObjectContext:self.objectContext];
    
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

//删除
-(void)deleteObjectContext:(PersonManager *)model fromDb:(NSString*)dbName{
    
    
    [self.objectContext deleteObject:model];
    
    NSError *error=nil;
    
    //保存
    [self.objectContext save:&error];
 
}

//更新数据库
-(void)upDateWithPerson:(PersonManager *)model dbName:(NSString*)dbName{
    
    
    NSArray *tempArray = [self selectObjectContextFromDbName:dbName];
    
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
