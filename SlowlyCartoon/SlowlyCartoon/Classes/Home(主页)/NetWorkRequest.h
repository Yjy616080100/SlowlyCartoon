//
//  NetWorkRequest.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "BaseRequest.h"

@interface NetWorkRequest : BaseRequest
//成功回调block块儿
typedef void(^SuccessResponse)(NSDictionary *dic);

//失败回调block块儿
typedef void(^FailureResponse)(NSError *error);


//请求数据
// @url：请求数据的url
// @parameterDic：请求的参数
// @success：成功回调的block
// @failure：失败回调的block

#pragma mark -    GET
- (void)requestWithUrl:(NSString *)url
            parameters:(NSDictionary *)parameterDic
       successResponse:(SuccessResponse)success
       failureResponse:(FailureResponse)failure;

#pragma mark -    POST
- (void)sendWithUrl:(NSString *)url
         parameters:(NSDictionary *)parameterDic
    successResponse:(SuccessResponse)success
    failureResponse:(FailureResponse)failure;


@end
