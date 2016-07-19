//
//  ImageRequest.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "BaseRequest.h"
#import "NetWorkRequest.h"

@interface ImageRequest : BaseRequest

- (void)requestImageWithID:(NSString *)ID
        pager_idx:(NSString *)pager_idx
        success:(SuccessResponse)success
        failure:(FailureResponse)failure;



@end
