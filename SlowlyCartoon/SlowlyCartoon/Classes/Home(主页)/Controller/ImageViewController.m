//
//  ImageViewController.m
//  SlowlyCartoon
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Slowly Pangpang. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageModel.h"
#import "ImageRequest.h"
#import "ImageTableViewCell.h"

@interface ImageViewController ()
<
    UITableViewDataSource,
    UITableViewDelegate,
    UIGestureRecognizerDelegate

>

@property(nonatomic,strong)UITableView *imageTableView;

@property(nonatomic,strong)NSMutableArray *imagrArray;


@property (nonatomic , assign)BOOL isHidden;

@property (nonatomic , strong)UITapGestureRecognizer * tapGesture;
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    请求不到数据换成webView HTML有数据
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.comicq.cn/index.php/Index/read/comic_id/%@/order_idx/%@.html",_onlyID,_onlyIdx]]];
    
    UIWebView * webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    
    [webView loadRequest:request];
    
    
    
    [self.view addSubview:webView];
    
   
 _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    

    _tapGesture.delegate = self;
    
    [webView addGestureRecognizer:_tapGesture];
//    添加nav
    
//    self.navigationController.navigationItem.leftBarButtonItem = [[UINavigationItem alloc]initWithTitle:@""];
    
    
//    self.imagrArray = [NSMutableArray array];
    
    
    
//    //请求数据
//    [self requestImage];
//    
//    //创建TableView
//    [self addTableView];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    NSLog(@"gestureRecognizer");
    
    if (gestureRecognizer == _tapGesture){
        
        NSLog(@"gestureRecognizer=====");
        return YES;
    }
    
    NSLog(@"gestureRecognizer---------");
    return NO;
}
- (void)tapAction:(UIGestureRecognizer *)gesture{
    
    _isHidden = !_isHidden;
    
    [self.navigationController setNavigationBarHidden:_isHidden animated:YES];
    
    [self.tabBarController.tabBar setHidden:_isHidden];
}

- (void)addTableView
{
    self.imageTableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    
    [self.imageTableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ImageTableViewCell_Identify];
    
    self.imageTableView.delegate = self;
    self.imageTableView.dataSource = self;
    [self.view addSubview:self.imageTableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.imagrArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ImageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ImageTableViewCell_Identify forIndexPath:indexPath];
    
    ImageModel *model = self.imagrArray[indexPath.row];
    
    NSString *string = [NSString stringWithFormat:@"http://r.comicq.cn%@",model.pager_pic];
    NSLog(@"%@",string);
    [cell.imageV setImageWithURL:[NSURL URLWithString:string]];
    
    return cell;
}
//解析数据
- (void)requestImage
{
    ImageRequest *request=[[ImageRequest alloc]init];
    
    [request requestImageWithID:self.onlyID pager_idx:self.onlyIdx success:^(NSDictionary *dic) {
       
        NSArray *array = [[dic objectForKey:@"data"] objectForKey:@"content_arr"];
        NSLog(@"1111111%@",dic);
        for (NSDictionary *dict in array) {
            ImageModel *model=[[ImageModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.imagrArray addObject:model];
        }
        
        //回到主线程刷新UI
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.imageTableView reloadData];
        });
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
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
