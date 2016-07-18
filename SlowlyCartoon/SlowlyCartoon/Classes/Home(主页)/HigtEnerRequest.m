//
//  HigtEnerRequest.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "HigtEnerRequest.h"

@implementation HigtEnerRequest

- (void)higtEnerRequestWithParameter:(NSDictionary *)parameter
                             success:(SuccessResponse)success
                             failure:(FailureResponse)failure{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    
    [request requestWithUrl:HigtEnerRequest_Url parameters:parameter successResponse:^(NSDictionary *dic) {
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
    
    
}
@end
