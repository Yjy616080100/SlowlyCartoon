//
//  WebViewController.h
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIWebView *webView;

//URL
@property (strong, nonatomic) NSString * URL;
@end
