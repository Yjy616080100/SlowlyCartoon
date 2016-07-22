//
//  FamilyGroup.m
//  MyFamily
//
//  Created by lanou3g on 16/7/22.
//  Copyright (c) 2016年 Slowly Pangpang. All rights reserved.
//

#import "FamilyGroup.h"

@implementation FamilyGroup
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(id)familyGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
