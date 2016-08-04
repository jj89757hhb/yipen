//
//  MyBuyTableViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/15.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MyBuyTableViewController.h"
#import "MyBuyTableViewCell1.h"
#import "OrderDetailViewController.h"
#import <RongIMKit/RongIMKit.h>
@interface MyBuyTableViewController ()
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation MyBuyTableViewController
static NSString *identify=@"identify";
static NSInteger pageSize=10;
- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage=1;
    [self.tableView registerNib:[UINib nibWithNibName:@"MyBuyTableViewCell1" bundle:nil] forCellReuseIdentifier:identify];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    WS(weakSelf)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf queryData];
    }];
    [self queryData];
}

-(void)queryData{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:pageSize],@"PageSize",[NSNumber numberWithInteger:currentPage],@"Page", nil];
    [HttpConnection GetMyBuy:dic WithBlock:^(id response, NSError *error) {
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
    MyBuyTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    // Configure the cell...
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell setInfo:_list[indexPath.row]];
    WS(weakSelf)
    [cell setMsgBlock:^(id sender){
        [weakSelf msgAction:sender];
    }];
    cell.index=indexPath;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailViewController *ctr=[[OrderDetailViewController alloc] init];
    ctr.info=_list[indexPath.row];
    [self.navigationController pushViewController:ctr animated:YES];
}


-(void)msgAction:(NSIndexPath*)index{
    ExchangeInfo *info=  _list[index.row];
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = info.SalerID;
    //设置聊天会话界面要显示的标题
    chat.title = info.SaleUser.NickName;
    //显示聊天会话界面
    //    [self hideTabBar:YES animated:NO];
    [self.navigationController pushViewController:chat animated:YES];
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
