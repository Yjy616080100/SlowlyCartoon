//
//  ShowImageView.h
//  FriendGroup
//
//  Created by lanou3g on 16/7/23.
//  Copyright (c) 2016年 Slowly Pangpang. All rights reserved.
//

//用来处理图片点击后放大的效果
#import <UIKit/UIKit.h>
typedef void(^didRemoveImage)(void);
@interface ShowImageView : UIView

@property (nonatomic,copy)didRemoveImage removeImg;

-(id)initWithFrame:(CGRect)frame byClickTag:(NSInteger)clickTag appendArray:(NSArray *)appendArray;

@end


