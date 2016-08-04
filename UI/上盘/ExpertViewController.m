//
//  ExpertViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/8/2.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ExpertViewController.h"
#import "ExpertTableViewCell.h"
@interface ExpertViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *myTable;
}

@end

@implementation ExpertViewController
static NSString *identify=@"identify";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title=@"咨询专家";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishAction)];
    [self queryDataIsRefresh:YES];
}

-(void)queryDataIsRefresh:(BOOL)isRefresh{
            NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"Uid",[NSNumber numberWithInteger:1],@"Page",[NSNumber numberWithInteger:10],@"PageSize", nil];
            [HttpConnection GetExperts:dic WithBlock:^(id response, NSError *error) {
                [myTable.header endRefreshing];
                
    
            }];
    
}


-(void)initTableView{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.dataSource=self;
    myTable.delegate=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"ExpertTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    WS(weakSelf)
    [myTable addLegendHeaderWithRefreshingBlock:^{
        [weakSelf queryDataIsRefresh:YES];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExpertTableViewCell *cell=[myTable dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [myTable deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)finishAction{
    [self.navigationController popViewControllerAnimated:YES];
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
