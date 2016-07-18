//
//  RankListRequest.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkRequest.h"
@interface RankListRequest : BaseRequest

- (void)rankListRequestWithParameter:(NSDictionary *)parameter
                             success:(SuccessResponse)success
                             failure:(FailureResponse)failure;

@end
