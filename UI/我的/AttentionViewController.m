//
//  AttentionViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/19.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "AttentionViewController.h"
#import "AttentionTableViewCell.h"
#import "PersonalHomeViewController.h"
@interface AttentionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation AttentionViewController
static NSString *identify=@"identify";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.list=[[NSMutableArray alloc] init];
    self.title=@"关注";
    [self initTableView];
    [self requestData];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];

    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)requestData{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    [HttpConnection GetFocus:dic WithBlock:^(id response, NSError *error) {
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
        [myTable.header endRefreshing];
        
    }];
}

-(void)initTableView{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"AttentionTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    WS(weakSelf)
    [myTable addLegendHeaderWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [myTable reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0&&indexPath.row==0) {
//        
//        return 60;
//    }
    
    return 70;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttentionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    [cell setInfo:_list[indexPath.row]];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    YPUserInfo *info=_list[indexPath.row];
    info.ID=info.BeID;//又是数据不统一！！！
    PersonalHomeViewController *ctr=[[PersonalHomeViewController alloc] init];
    ctr.userInfo=info;
    [self hideTabBar:YES animated:NO];
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
