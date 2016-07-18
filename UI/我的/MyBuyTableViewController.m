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
@interface MyBuyTableViewController ()

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
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyBuyTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    
    // Configure the cell...
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OrderDetailViewController *ctr=[[OrderDetailViewController alloc] init];
    [self.navigationController pushViewController:ctr animated:YES];
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
