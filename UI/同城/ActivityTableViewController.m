//
//  ActivityTableViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/13.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "ActivityTableViewCell1.h"
#import "ActivityInfo.h"
#import "YPUserInfo.h"
#import "ActivityDetailViewController.h"
#import "PersonalHomeViewController.h"
@interface ActivityTableViewController ()
@property(nonatomic,strong)NSMutableArray *list;
@end
static NSString *identify=@"identify";
static NSInteger pageSize=10;
@implementation ActivityTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[ActivityTableViewCell1 class] forCellReuseIdentifier:identify];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.list=[[NSMutableArray alloc] init];
    currentPage=1;
    [self queryActivityList];
    WS(weakSelf)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf queryActivityList];
    } ];
   
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    
}

-(void)queryActivityList{
    //[{"ID":"2","CityName":"杭州"},{"ID":"3","CityName":"绍兴"},{"ID":"6","CityName":"常州"},{"ID":"7","CityName":"苏州"},{"ID":"9","CityName":"上海"}]}
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:pageSize],@"PageSize",[NSNumber numberWithInteger:currentPage],@"Page",@"2",@"CityID", nil];
    [HttpConnection getActivtyList:dic WithBlock:^(id response, NSError *error) {
        [self.tableView.footer endRefreshing];
        [self.tableView.header endRefreshing];
        if (!error) {
//            if ([response[@"ok"] isEqualToString:@"TRUE"]) {
//                NSArray *records=response[@"records"];
//                NSMutableArray *array=[[NSMutableArray alloc] init];
//                for (NSDictionary *dic in records) {
//                    NSDictionary *activtyDic=dic[@"Activty"];
//                    ActivityInfo *info=[[ActivityInfo alloc] initWithKVCDictionary:activtyDic];
//                    NSMutableArray *Attachs=activtyDic[@"Attach"];//图片路径
//                    NSMutableArray *_Attachs=[[NSMutableArray alloc] init];
//                    for (NSDictionary *dic in  Attachs) {//解析图片地址
//                        [_Attachs addObject:dic[@"Path"]];
//                    }
//                    NSDictionary *userDic=dic[@"user"];
//                    YPUserInfo *userInfo=[[YPUserInfo alloc] initWithKVCDictionary:userDic];
//                    info.Attach=_Attachs;
//                    info.userInfo=userInfo;
//                    [array addObject:info];
//                }
//                if (currentPage==1) {
//                    [self.list removeAllObjects];
//                }
//                NSArray *temp=[[NSArray alloc] initWithArray:array];
//                [self.list addObjectsFromArray:temp];
//                [self.tableView reloadData];
//            }
//            else{
//                [SVProgressHUD showErrorWithStatus:response[@"reason"]];
//            }
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
    
    float content_Height=0;
    ActivityInfo *info=_list[indexPath.row];
    content_Height+=  [CommonFun sizeWithString:info.Message font:[UIFont systemFontOfSize:activity_Content_Size] size:CGSizeMake(SCREEN_WIDTH-10*4, MAXFLOAT)].height;
    return 200+90+content_Height;
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
    ActivityTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    ActivityInfo *info=_list[indexPath.row];
    [cell setInfo:info];
    [cell updateConstraintsIfNeeded];
    [cell setNeedsDisplay];
    [cell setClickHeadBlock:^(id sender){
        XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
        [tabBar xmTabBarHidden:YES animated:NO];
        PersonalHomeViewController *ctr=[[PersonalHomeViewController alloc] init];
//        [self hideTabBar:YES animated:NO];
        ctr.userInfo=info.userInfo;
        [self.navigationController pushViewController:ctr animated:YES];
    }];

    return cell;
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


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
    [tabBar xmTabBarHidden:YES animated:NO];
    ActivityDetailViewController *ctr=[[ActivityDetailViewController alloc] init];
//    [ctr hideTabBar:YES animated:NO];
    ctr.info=_list[indexPath.row];
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
