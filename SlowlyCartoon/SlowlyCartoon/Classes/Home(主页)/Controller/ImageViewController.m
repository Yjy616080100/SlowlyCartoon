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
UITableViewDelegate
>

@property(nonatomic,strong)UITableView *imageTableView;

@property(nonatomic,strong)NSMutableArray *imagrArray;

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagrArray = [NSMutableArray array];
    
    //请求数据
    [self requestImage];
    
    //创建TableView
    [self addTableView];
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
