//
//  DetailsRequest.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "DetailsRequest.h"



@implementation DetailsRequest

//请求集数
- (void)requestDiversityWithID:(NSString *)ID
                          time:(NSString *)time
                       success:(SuccessResponse)success
                       failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    
    [request requestWithUrl:DiversityRequest_Url(time, ID) parameters:nil successResponse:^(NSDictionary *dic) {
        success(dic);
        
    } failureResponse:^(NSError *error) {
        failure(error);
        
    }];

}


//请求评论
- (void)requestCommentWithID:(NSString *)ID
                     success:(SuccessResponse)success
                     failure:(FailureResponse)failure
{
    NetWorkRequest *request = [[NetWorkRequest alloc] init];
    
    [request requestWithUrl:CommentRequest_Url(ID) parameters:nil successResponse:^(NSDictionary *dic) {
        
        success(dic);
        
    } failureResponse:^(NSError *error) {
        failure(error);
        
    }];

}
@end
