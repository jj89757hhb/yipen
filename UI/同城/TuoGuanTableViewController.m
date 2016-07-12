//
//  TuoGuanTableViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/13.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "TuoGuanTableViewController.h"
#import "TuoGuanTableViewCell.h"
#import "TCTuoGuanDetailViewController.h"
@interface TuoGuanTableViewController ()
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation TuoGuanTableViewController
static NSString *identify=@"identify";
static NSInteger pageSize=10;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[TuoGuanTableViewCell class] forCellReuseIdentifier:identify];
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
    //[{"ID":"2","CityName":"杭州"},{"ID":"3","CityName":"绍兴"},{"ID":"6","CityName":"常州"},{"ID":"7","CityName":"苏州"},{"ID":"9","CityName":"上海"}]}
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:pageSize],@"PageSize",[NSNumber numberWithInteger:currentPage],@"Page",@"2",@"CityID", nil];
    [HttpConnection GetHostingGardenList:dic WithBlock:^(id response, NSError *error) {
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
    float height=0;
    //    XiangYuanTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    //       XiangYuanTableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:identify];
    //    [_prototypeCell updateConstraintsIfNeeded];
    //    [_prototypeCell setNeedsDisplay];
    //    height=[self.prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    //    return height;
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
    return _list.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TuoGuanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    //    self.prototypeCell=cell;
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    //    ActivityInfo *info=_list[indexPath.row];
    [cell setInfo:_list[indexPath.row]];
    [cell updateConstraintsIfNeeded];
    [cell setNeedsDisplay];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TCTuoGuanDetailViewController  *ctr=[[TCTuoGuanDetailViewController alloc] init];
    ctr.info=_list[indexPath.row];
    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
    [tabBar xmTabBarHidden:YES animated:NO];
    [self.navigationController pushViewController:ctr animated:YES];
}

@end
