//
//  MySellTableViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/15.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MySellTableViewController.h"
#import "MySell1TableViewCell.h"
#import "OrderDetailViewController.h"
#import "EditExpressInfoViewController.h"
#import <RongIMKit/RongIMKit.h>
@interface MySellTableViewController ()
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation MySellTableViewController
NSString *identify=@"identify";
static NSInteger pageSize=10;
- (void)viewDidLoad {
    currentPage=1;
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"MySell1TableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self queryData];
    WS(weakSelf)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf queryData];
    }];
}


-(void)queryData{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:pageSize],@"PageSize",[NSNumber numberWithInteger:currentPage],@"Page", nil];
    [HttpConnection GetMySale:dic WithBlock:^(id response, NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (!error) {
            if (![response objectForKey:KErrorMsg]) {
                self.list=response[KDataList];
                [self.tableView reloadData];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MySell1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.indexPath=indexPath;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    WS(weakSelf)
    [cell setMsgBlock:^(id sender){
        [weakSelf msgAction:sender];
    }];
    
    [cell setSendGoodsBlock:^(id sender){
        [weakSelf editExpressInfo:sender];
    }];
    [cell setInfo:_list[indexPath.row]];
    [cell setRefundBlock:^(id sender){
        [weakSelf refundAction:sender];
    }];
    [cell updateConstraintsIfNeeded];
    [cell layoutIfNeeded];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailViewController *ctr=[[OrderDetailViewController alloc] init];
    ctr.enterType=1;
      ctr.info=_list[indexPath.row];
    [self.navigationController pushViewController:ctr animated:YES];
}

-(void)editExpressInfo:(NSIndexPath*)index{
    ExchangeInfo *info=  _list[index.row];
    EditExpressInfoViewController *ctr=[[EditExpressInfoViewController alloc] initWithNibName:nil bundle:nil];
    ctr.tranNo=info.TradingNo;
    [self.navigationController pushViewController:ctr animated:YES];
}

-(void)msgAction:(NSIndexPath*)index{
     ExchangeInfo *info=  _list[index.row];
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = info.BuyerID;
    //设置聊天会话界面要显示的标题
    chat.title = info.BuyUser.NickName;
    //显示聊天会话界面
//    [self hideTabBar:YES animated:NO];
    [self.navigationController pushViewController:chat animated:YES];
}


-(void)refundAction:(NSIndexPath*)index{
     ExchangeInfo *info=  _list[index.row];
    [SVProgressHUD show];
    Order_Status status=KRefunded;
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",info.TradingNo,@"TradingNo",[NSNumber numberWithInteger:status],@"Status",info.BuyUser.ID,@"ToUID", nil];
    [HttpConnection SendTrad:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if (!response[KErrorMsg]) {
                [SVProgressHUD showSuccessWithStatus:@"已同意退款"];
                
            }
            else{
                [SVProgressHUD showErrorWithStatus:response[KErrorMsg]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        
        
    }];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
