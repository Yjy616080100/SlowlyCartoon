//
//  UIImage+ReSize.m
//  MyFamily
//
//  Created by lanou3g on 16/7/22.
//  Copyright (c) 2016年 Slowly Pangpang. All rights reserved.
//

#import "UIImage+ReSize.h"

@implementation UIImage (ReSize)
-(UIImage *)reSizeImagetoSize:(CGSize)reSize   
{
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(reSize.width, reSize.height),NO,0.0);
    
    [self drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return reSizeImage;
    

}
@end
