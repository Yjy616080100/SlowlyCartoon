//
//  LocationViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "LocationViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface LocationViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>
@property(nonatomic,strong)MKMapView *mapView;
@property(nonatomic,strong)CLLocationManager *locManager;
@property(nonatomic,strong)UIImageView *imageV;
@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor whiteColor];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationItem.title = @"我的位置";
    
    //取消
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<- 返回" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction)];

    //保存
    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc]initWithTitle:@"截图" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightAction)];
    
    //设置mapView
    self.mapView =[[MKMapView alloc]initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.scrollEnabled =YES;
    self.mapView.zoomEnabled =YES;
    self.mapView.showsScale = YES;
    self.mapView.showsCompass =YES;
    self.mapView.showsUserLocation =YES;
    [self.view addSubview:self.mapView];
    
    //设置位置管理器
    if ([CLLocationManager locationServicesEnabled]) {

        self.locManager=[[CLLocationManager alloc]init];
        self.locManager.delegate=self;
        self.locManager.desiredAccuracy=kCLLocationAccuracyBest;
        self.locManager.distanceFilter=100;
        [self.locManager requestWhenInUseAuthorization];
        [self.locManager startUpdatingLocation];
        
    }

    //设置imageV
    self.imageV=[[UIImageView alloc]initWithFrame:self.mapView.frame];
    [self.view addSubview:self.imageV];
    
    
}

-(void)leftAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightAction{

    self.imageV.image = [self captureView:self.mapView];
    __weak typeof(self) weakSelf =self;
    //弹框提示是否发送
    UIAlertController *alertVC=[UIAlertController alertControllerWithTitle:@"提示" message:@"截图保存至相册,是否发送" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *SureAction =[UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        //保存到相册
        UIImageWriteToSavedPhotosAlbum(weakSelf.imageV.image, nil, nil, nil);
        //点击确定，发送给好友并返回
        self.MyBlock(weakSelf.imageV.image);
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIAlertAction *CancleAction =[UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        //点击取消，重新截图
        weakSelf.imageV.image = nil;
        
    }];
    
    [alertVC addAction:CancleAction];
    [alertVC addAction:SureAction];
    [self presentViewController:alertVC animated:YES completion:nil];
    
}




//截图的方法，返回image ,赋值在imageView上
-(UIImage*)captureView:(UIView *)theView{
    
    CGRect rect = theView.frame;
    if ([theView isKindOfClass:[UIScrollView class]]) {
        rect.size = ((UIScrollView *)theView).contentSize;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}



#pragma mark--------------------mapView代理方法--------------------------
//更新用户位置 （当用户位置发生变化时，调用此方法）
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    //1.创建经纬度跨度
    MKCoordinateSpan span=MKCoordinateSpanMake(0.00042, 0.0037);
    //2.创建用户位置中心
    MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.location.coordinate, span);
    //3.设置用户位置中心
    [self.mapView setRegion:region animated:YES];
    
}


#pragma mark--------------------CLLocation代理方法--------------------------
//获得用户位置的经纬度
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location=[locations firstObject];//---->数组中的第一个位置的地理信息
    CLLocationCoordinate2D coordinate=location.coordinate;//--->存放经纬度的结构体
    
    NSLog(@"经度--%f,纬度--%f",coordinate.longitude ,coordinate.latitude);
    
    
    
}






















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
