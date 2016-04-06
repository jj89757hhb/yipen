//
//  XiangYuanTableViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/13.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "XiangYuanTableViewController.h"
#import "XiangYuanTableViewCell.h"
#import "YouYuanDetailViewController.h"
@interface XiangYuanTableViewController ()
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation XiangYuanTableViewController

static NSString *identify=@"identify";
static NSInteger pageSize=10;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[XiangYuanTableViewCell class] forCellReuseIdentifier:identify];
    self.list=[[NSMutableArray alloc] init];
    currentPage=1;
    [self queryData];
    WS(weakSelf)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf queryData];
    } ];
    
}

-(void)queryData{
    //[{"ID":"2","CityName":"杭州"},{"ID":"3","CityName":"绍兴"},{"ID":"6","CityName":"常州"},{"ID":"7","CityName":"苏州"},{"ID":"9","CityName":"上海"}]}
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:pageSize],@"PageSize",[NSNumber numberWithInteger:currentPage],@"Page",@"4",@"CityID", nil];
    [HttpConnection getStoreList:dic WithBlock:^(id response, NSError *error) {
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (!error) {
            if ([response[@"ok"] isEqualToString:@"TRUE"]) {
                NSArray *records=response[@"records"];
                NSMutableArray *array=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in records) {
                    NSDictionary *activtyDic=dic[@"Store"];
                    ActivityInfo *info=[[ActivityInfo alloc] initWithKVCDictionary:activtyDic];
                    NSMutableArray *Attachs=activtyDic[@"Attach"];//图片路径
                    NSMutableArray *_Attachs=[[NSMutableArray alloc] init];
                    for (NSDictionary *dic in  Attachs) {//解析图片地址
                        [_Attachs addObject:dic[@"Path"]];
                    }
                    NSDictionary *userDic=dic[@"user"];
                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:userDic];
                    info.Attach=_Attachs;
                    info.userInfo=userInfo;
                    [array addObject:info];
                }
                if (currentPage==1) {
                    [self.list removeAllObjects];
                }
                NSArray *temp=[[NSArray alloc] initWithArray:array];
                [self.list addObjectsFromArray:temp];
                [self.tableView reloadData];
            }
            else{
                [SVProgressHUD showErrorWithStatus:response[@"reason"]];
            }
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200+100;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    //    return _list.count;
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XiangYuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //    ActivityInfo *info=_list[indexPath.row];
    [cell setInfo:nil];
    [cell updateConstraintsIfNeeded];
    [cell setNeedsDisplay];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YouYuanDetailViewController *ctr=[[YouYuanDetailViewController alloc] init];
    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
    [tabBar xmTabBarHidden:YES animated:NO];
    [self.navigationController pushViewController:ctr animated:YES];
}

@end
