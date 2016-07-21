//
//  TwoDimensionalCodeView.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
/*
 所谓的二维码就是一个图片，只不过在iOS需要借用<CoreImage/CoreImage.h>来实现， 
 并且二维码图片是通过CIImage来转成UIImage的。
*/

#import "TwoDimensionalCodeView.h"
#import <CoreImage/CoreImage.h>
#define  kWidth self.frame.size.width
#define kHeight self.frame.size.height
@implementation TwoDimensionalCodeView

//重写setter方法
-(UIImageView *)MyImageV{
    
    if (_MyImageV == nil) {
        
        _MyImageV =[[UIImageView alloc]initWithFrame:CGRectMake(0.44*kWidth, 0.5*kHeight, 0.13*kWidth, 0.1*kHeight)];
        _MyImageV.image =[UIImage imageNamed:@"biaoqing"];
        
    }
    return _MyImageV;
    
}
-(UILabel *)textLabel{
    
    if (_textLabel ==nil) {
        
        _textLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 0.2*kHeight)];
        _textLabel.text =@"加微信,夜间送福利哦oo";
        _textLabel.textAlignment =NSTextAlignmentCenter;
        _textLabel.font =[UIFont systemFontOfSize:20];
        [_textLabel setTextColor:[UIColor grayColor]];
    }
    
    return _textLabel;
}
//初始化View
-(instancetype)initWithFrame:(CGRect)frame
              currentUseName:(NSString *)useName{
    
    self =[super initWithFrame:frame];
    if (self) {

        self.backgroundColor =[UIColor whiteColor];

        self.TwoDimensionalCodeImageV =[[UIImageView alloc]initWithFrame:CGRectMake(0.1*kWidth, 0.2*kHeight, 0.8*kWidth, 0.7*kHeight)];
        [self CreateTwoDimensionalCode:useName];
        
        [self addSubview:self.TwoDimensionalCodeImageV];
        [self addSubview:self.MyImageV];
        [self addSubview:self.textLabel];
        
    }
    
    return self;
}


//生成二维码
-(void)CreateTwoDimensionalCode:(NSString *)currentUseName{
    
    //1. 创建一个滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //2.设置默认的属性
    [filter setDefaults];
    //3.给滤镜设置数据 (NSData数据)
    NSString *string = currentUseName;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    //4. 获取输出的数据CIImage类型
    CIImage *outPutImage = [filter outputImage];
    
    //5. 将输出的图片转换成高清二维码 ,并赋值给ImageView
    self.TwoDimensionalCodeImageV.image = [self CreateHighDefinitionTwoDimensionalCode:outPutImage withSize:200];
    
    
    
}

//生成高清二维码
-(UIImage *)CreateHighDefinitionTwoDimensionalCode:(CIImage *)image
                                          withSize:(CGFloat)size{
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    //1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    
    return [UIImage imageWithCGImage:scaledImage];
   
    
}



















/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
