//
//  RecommendRequest.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "RecommendRequest.h"

@implementation RecommendRequest

- (void)recommentRequestWithParameter:(NSDictionary *)parameter
                success:(SuccessResponse)success
                failure:(FailureResponse)failure
{
    NetWorkRequest *request=[[NetWorkRequest alloc]init];
    [request requestWithUrl:RecommendUrl    parameters:parameter successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}


@end
