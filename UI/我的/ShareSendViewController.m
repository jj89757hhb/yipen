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
    cell.indexPath = indexPath;
    WS(weakSelf)
    [cell setDeleteBlock:^(NSIndexPath *index){
        [weakSelf deleteInfo:index];
    }];
    return cell;
}

-(void)deleteInfo:(NSIndexPath*)indexPath{
    
    [UIAlertView bk_showAlertViewWithTitle:nil message:@"是否删除" cancelButtonTitle:@"取消" otherButtonTitles:@[@"删除"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex==1) {
            [SVProgressHUD show];
            PenJinInfo *info = _list[indexPath.row];
            NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",info.ID,@"BID", nil];
            [HttpConnection DelMyPost:dic WithBlock:^(id response, NSError *error) {
                if (!error) {
                    if ([response[@"ok"] boolValue]) {
                        [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                        [_list removeObjectAtIndex:indexPath.row];
                        [myTable reloadData];
                    }
                    else{
                        [SVProgressHUD showErrorWithStatus:response[@"reason"]];
                    }
                  
                }
                else{
                      [SVProgressHUD showErrorWithStatus:@"删除失败"];
                }
            }];
        }
        
    }];
 
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
