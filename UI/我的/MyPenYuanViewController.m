//
//  MyPenYuanViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MyPenYuanViewController.h"
#import "MyPenYuanTableViewCell.h"
@interface MyPenYuanViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation MyPenYuanViewController
static NSString *identify=@"identify";
static NSInteger pageSize=10;
- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage=1;
    self.list=[[NSMutableArray alloc] init];
    [self initTable];
    [self requestData];
    WS(weakSelf);
    [myTable addLegendHeaderWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
}

-(void)requestData{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:currentPage],@"Page",[NSNumber numberWithInteger:pageSize],@"PageSize", nil];
    [HttpConnection GetMyBonsaiFate:dic WithBlock:^(id response, NSError *error) {
        [myTable.header endRefreshing];
        [myTable.footer endRefreshing];
        if (!error) {
            if (![response objectForKey:KErrorMsg]) {
                self.list=response[KDataList];
                [myTable reloadData];
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

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    [myTable registerNib:[UINib nibWithNibName:@"MyPenYuanTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
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
    MyPenYuanTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    PenJinInfo *info=_list[indexPath.row];
    [cell setInfo:info];
    [cell updateConstraintsIfNeeded];
    [cell layoutIfNeeded];
    cell.indexPath = indexPath;
    WS(weakSelf)
    [cell setDeleteAction:^(id sender){
        [weakSelf deleteAction:sender];
    }];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)deleteAction:(NSIndexPath*)indexPath{
//    [SVProgressHUD show];
//    PenJinInfo *info = _list[indexPath.row];
//    NSString *result=[NSString stringWithFormat:@"%@,%@,%@",info.ID,[NSNumber numberWithInteger:0],info.UID];
//    NSDictionary *dic3=[[NSDictionary alloc] initWithObjectsAndKeys:result,@"result" ,[DataSource sharedDataSource].userInfo.ID,@"UID",nil];
//    [HttpConnection PostBonsaiFate:dic3 WithBlock:^(id response, NSError *error) {
//        if (error) {
//            [SVProgressHUD showInfoWithStatus:ErrorMessage];
//        }
//        else{
//            [SVProgressHUD showInfoWithStatus:@"没有眼缘"];
//            [_list removeObjectAtIndex:indexPath.row];
//            [myTable reloadData];
//        }
//        
//    }];
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
