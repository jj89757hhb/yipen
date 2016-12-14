//
//  YouYuanTableViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/13.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "YouYuanTableViewController.h"
#import "YouYuanTableViewCell.h"
#import "YouYuanDetailViewController.h"
@interface YouYuanTableViewController ()

@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation YouYuanTableViewController
static NSString *identify=@"identify";
static NSInteger pageSize=10;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[YouYuanTableViewCell class] forCellReuseIdentifier:identify];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.list=[[NSMutableArray alloc] init];
    currentPage=1;
    [self queryData];
    WS(weakSelf)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf queryData];
    } ];
    
}

-(void)queryData{
     NSString *cityID = [DataSource sharedDataSource].cityInfo.ID?[DataSource sharedDataSource].cityInfo.ID:HangZou_Id;
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:pageSize],@"PageSize",[NSNumber numberWithInteger:currentPage],@"Page",cityID,@"CityID", nil];
    [HttpConnection GetFriendsList:dic WithBlock:^(id response, NSError *error) {
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
    ActivityInfo *info=_list[indexPath.row];
    float content_Height=0;
     content_Height+=  [CommonFun sizeWithString:info.Message font:[UIFont systemFontOfSize:content_FontSize_YouYuan] size:CGSizeMake(SCREEN_WIDTH-10*2-10*2, MAXFLOAT)].height;
    return Tree_Height_SameCity+60+content_Height+80;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
//    return _list.count;
    return _list.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YouYuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    ActivityInfo *info=_list[indexPath.row];
    [cell setInfo:_list[indexPath.row]];
    [cell updateConstraintsIfNeeded];
    [cell setNeedsDisplay];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YouYuanDetailViewController *ctr=[[YouYuanDetailViewController alloc] init];
    ctr.info=_list[indexPath.row];
    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
    [tabBar xmTabBarHidden:YES animated:NO];
    [self.navigationController pushViewController:ctr animated:YES];
}

@end
