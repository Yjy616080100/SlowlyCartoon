//
//  RootViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/12.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "RootViewController.h"

#import "HomeViewController.h"
#import "FriendViewController.h"
#import "CommunityViewController.h"
#import "MineViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setUpViewControllers];
}

#pragma MARK- 初始化 Controllers
- (void)setUpViewControllers{
    
    //    初始化 HomeViewcContoller
    [self setUpOneViewControllerWithController:[HomeViewController new] image:@"tabbar_game@2x" selectImage:@"tabbar_game_sel@2x" title:@"主页"];
    
    //    初始化 CommunityViewController
    
    [self setUpOneViewControllerWithController:[CommunityViewController new] image:@"tabbar_home@2x" selectImage:@"tabbar_home_sel@2x" title:@"社区"];
    
    //    初始化 FriendViewController
    [self setUpOneViewControllerWithController:[FriendViewController new] image:@"tabbar_room@2x" selectImage:@"tabbar_room_sel@2x" title:@"好友"];
    
    //    初始化 MineViewController
    [self setUpOneViewControllerWithController:[MineViewController new] image:@"tabbar_me@2x" selectImage:@"tabbar_me_sel@2x" title:@"个人中心"];
    
}


#pragma mark-  初始化Controller
- (void)setUpOneViewControllerWithController:(UIViewController*)VC image:(NSString*)imageName selectImage:(NSString*)selectedImageName title:(NSString*)title{
    
    
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:VC];
    
    nav.navigationBar.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:241/255.0];
    
    nav.navigationBar.barTintColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:241/255.0];
    

    VC.tabBarItem.image = [UIImage imageNamed:imageName];
    
    VC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    
    VC.title = title;
    
    [self addChildViewController:nav];
    
    
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
