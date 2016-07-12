//
//  StoreTableViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/13.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "StoreTableViewController.h"
#import "StoreTableViewCell.h"
//#import "StoreInfo.h"
#import "ActivityInfo.h"
#import "TCStoreDetailViewController.h"
@interface StoreTableViewController ()
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation StoreTableViewController
static NSString *identify=@"identify";
static NSInteger pageSize=10;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[StoreTableViewCell class] forCellReuseIdentifier:identify];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.list=[[NSMutableArray alloc] init];
    currentPage=1;
    [self queryStoreList];
    WS(weakSelf)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
           [weakSelf queryStoreList];
    } ];
    
}

-(void)queryStoreList{
    //[{"ID":"2","CityName":"杭州"},{"ID":"3","CityName":"绍兴"},{"ID":"6","CityName":"常州"},{"ID":"7","CityName":"苏州"},{"ID":"9","CityName":"上海"}]}
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:pageSize],@"PageSize",[NSNumber numberWithInteger:currentPage],@"Page",@"2",@"CityID", nil];
    [HttpConnection GetStoreList:dic WithBlock:^(id response, NSError *error) {
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
//    return 200+100;
    ActivityInfo *info=_list[indexPath.row];
    float content_Height=0;
    content_Height+=  [CommonFun sizeWithString:info.Message font:[UIFont systemFontOfSize:content_FontSize_Store] size:CGSizeMake(SCREEN_WIDTH-10*2-10*2, MAXFLOAT)].height;
    return 200+50+content_Height;
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
    StoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    ActivityInfo *info=_list[indexPath.row];
    [cell setInfo:info];
    [cell updateConstraintsIfNeeded];
    [cell setNeedsDisplay];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TCStoreDetailViewController *ctr=[[TCStoreDetailViewController alloc] init];
    ctr.info=_list[indexPath.row];
    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
    [tabBar xmTabBarHidden:YES animated:NO];
    [self.navigationController pushViewController:ctr animated:YES];
}


/*
#pragma mark - Navigation
x
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
