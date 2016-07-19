//
//  ImageRequest.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "ImageRequest.h"

@implementation ImageRequest
//请求具体图片

- (void)requestImageWithID:(NSString *)ID
                 pager_idx:(NSString *)pager_idx
                   success:(SuccessResponse)success
                   failure:(FailureResponse)failure
{
    NetWorkRequest *request=[[NetWorkRequest alloc]init];
    [request requestWithUrl:RequestImage_Url(ID, pager_idx) parameters:nil successResponse:^(NSDictionary *dic) {
        
        NSLog(@"%@",RequestImage_Url(ID, pager_idx));
        
        success(dic);
    } failureResponse:^(NSError *error) {
        failure(error);
    }];
}
@end
