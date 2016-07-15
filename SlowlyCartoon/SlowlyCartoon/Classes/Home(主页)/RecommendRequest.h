//
//  RecommendRequest.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkRequest.h"
@interface RecommendRequest : BaseRequest


- (void)recommentRequestWithParameter:(NSDictionary *)parameter
                    success:(SuccessResponse)success
                    failure:(FailureResponse)failure;


@end
