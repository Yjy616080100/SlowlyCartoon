//
//  RankListRequest.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "RankListRequest.h"

@implementation RankListRequest

- (void)rankListRequestWithParameter:(NSDictionary *)parameter
                             success:(SuccessResponse)success
                             failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    
    [request requestWithUrl:RankListRequest_Url parameters:parameter successResponse:^(NSDictionary *dic) {
        success(dic);

    } failureResponse:^(NSError *error) {
        failure(error);
       
    }];

}


@end
