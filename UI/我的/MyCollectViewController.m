//
//  MyCollectViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MyCollectViewController.h"
#import "SameCitySendTableViewCell.h"
@interface MyCollectViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation MyCollectViewController
static NSString *identify=@"identify";
static NSInteger pageSie=10;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收藏";
    [self initTableView];
    currentPage=1;
    [self requestData];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}


-(void)initTableView{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"SameCitySendTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return _list.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SameCitySendTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    return cell;
}

-(void)requestData{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:currentPage],@"Page",[NSNumber numberWithInteger:pageSie],@"PageSize" ,nil];
    
    [HttpConnection GetMyCollect:dic WithBlock:^(id response, NSError *error) {
        
    }];
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
