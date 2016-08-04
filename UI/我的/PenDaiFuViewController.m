//
//  PenDaiFuViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
// 我的盆大夫

#import "PenDaiFuViewController.h"
#import "PenDaiFuTableViewCell.h"
#import "PenDaiFuDetailViewController.h"
@interface PenDaiFuViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger Page;
    
}
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation PenDaiFuViewController
static NSString *identify=@"identify";
static NSInteger PageSize=10;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"盆大夫";
    [self initTable];
    [self requestDataIsRefresh:YES];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}

-(void)requestDataIsRefresh:(BOOL)isRefresh{
    if (isRefresh) {
        Page=1;
    }
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:Page],@"Page",[NSNumber numberWithInteger:PageSize],@"PageSize", nil];
    [HttpConnection GetMyBonsaiDoctor:dic WithBlock:^(id response, NSError *error) {
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


-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    [myTable registerNib:[UINib nibWithNibName:@"PenDaiFuTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    WS(weakSelf)
    [myTable addLegendHeaderWithRefreshingBlock:^{
        [weakSelf requestDataIsRefresh:YES];
    }];
    [myTable addLegendFooterWithRefreshingBlock:^{
        [weakSelf requestDataIsRefresh:NO];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenDaiFuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    [cell setInfo:_list[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PenDaiFuDetailViewController *ctr=[[PenDaiFuDetailViewController alloc] init];
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
