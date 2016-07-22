//
//  ReplyInputView.h
//  MyFamily
//
//  Created by lanou3g on 16/7/23.
//  Copyright (c) 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>
//改变根据文字改变TextView的高度
typedef void (^ContentSizeBlock)(CGSize contentSize);
//添加评论
typedef void (^replyAddBlock)(NSString *replyText,NSInteger inputTag);
@interface ReplyInputView : UIView
@property (nonatomic,assign)NSInteger replyTag;

-(void)setContentSizeBlock:(ContentSizeBlock) block;
-(void)setReplyAddBlock:(replyAddBlock)block;
-(id)initWithFrame:(CGRect)frame andAboveView:(UIView *)bgView;
@end
