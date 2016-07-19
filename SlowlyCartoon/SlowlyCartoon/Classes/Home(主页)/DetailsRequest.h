//
//  DetailsRequest.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkRequest.h"

@interface DetailsRequest : BaseRequest

- (void)requestDiversityWithID:(NSString *)ID
            time:(NSString *)time
        success:(SuccessResponse)success
        failure:(FailureResponse)failure;

- (void)requestCommentWithID:(NSString *)ID
            success:(SuccessResponse)success
            failure:(FailureResponse)failure;




@end
