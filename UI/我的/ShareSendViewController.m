//
//  ShareSendViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/19.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ShareSendViewController.h"
#import "CollectionPenJingCell.h"
#import "FenXiangDetailViewController.h"
@interface ShareSendViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger Page;
    UITableView *myTable;

}
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation ShareSendViewController
static NSInteger PageSize=10;
static NSString *identify=@"identify";
- (void)viewDidLoad {
    [super viewDidLoad];
    Page=1;
    [self initTableView];
    // Do any additional setup after loading the view from its nib.
    [self requestDataIsRefresh:YES];
}

-(void)initTableView{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-20) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"CollectionPenJingCell" bundle:nil] forCellReuseIdentifier:identify];
    WS(weakSelf)
    [myTable addLegendHeaderWithRefreshingBlock:^{
        [weakSelf requestDataIsRefresh:YES];
    }];
    [myTable addLegendFooterWithRefreshingBlock:^{
        [weakSelf requestDataIsRefresh:NO];
    }];
}


-(void)requestDataIsRefresh:(BOOL)isRefresh{
    if (isRefresh) {
        Page=1;
    }
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:Page],@"Page",[NSNumber numberWithInteger:PageSize],@"PageSize", nil];
    [HttpConnection GetMyShareList:dic WithBlock:^(id response, NSError *error) {
        [SVProgressHUD dismiss];
        [myTable.header endRefreshing];
        [myTable.footer endRefreshing];
        if (!error) {
            if (![response objectForKey:KErrorMsg]) {
                if (Page==1) {
                    self.list=response[KDataList];
                }
                else{
                    [self.list addObjectsFromArray:response[KDataList]];
                }
                
                [myTable reloadData];
                Page++;
            }
            else{
                
                [SVProgressHUD showInfoWithStatus:[response objectForKey:KErrorMsg]];
            }
        }
        else{
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }
        
        
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CollectionPenJingCell *cell = [myTable dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    [cell setInfo:_list[indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [myTable deselectRowAtIndexPath:indexPath animated:NO];
    FenXiangDetailViewController *ctr=[[FenXiangDetailViewController alloc] init];
    ctr.info=_list[indexPath.row];
    [self.navigationController pushViewController:ctr animated:YES];
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
