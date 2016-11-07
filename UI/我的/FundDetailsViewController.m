//
//  FundDetailsViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "FundDetailsViewController.h"
#import "FundDetailsTableViewCell.h"
@interface FundDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger Page;
}
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation FundDetailsViewController
static NSString *identify=@"identify";
static NSInteger PageSize=50;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"资金明细";
    self.list=[[NSMutableArray alloc] init];
    [self initTable];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    Page=1;
    [self requestData];

}

-(void)requestData{
    if (![DataSource sharedDataSource].userInfo.ID) {
        return;
    }
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:Page],@"Page",[NSNumber numberWithInteger:PageSize],@"PageSize", nil];
    [HttpConnection GetTradingDetail:dic WithBlock:^(id response, NSError *error) {
        [myTable.header endRefreshing];
        [myTable.footer endRefreshing];
        if (!error ) {
            if (!response[KErrorMsg]) {
                self.list=response[KDataList];
                [myTable reloadData];
            }
            else{
                [SVProgressHUD showErrorWithStatus:response[@"reason"]];
            }
            
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        
    }];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    [myTable registerNib:[UINib nibWithNibName:@"FundDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    WS(weakSelf)
    [myTable addLegendHeaderWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FundDetailsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    [cell setInfo:_list[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [myTable deselectRowAtIndexPath:indexPath animated:NO];
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
