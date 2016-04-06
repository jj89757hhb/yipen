//
//  OrderDetailViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailTableViewCell.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation OrderDetailViewController
static NSString *identify=@"identify";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTable];
    [self initBottomView];
    self.title=@"订单详情";
}


-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"OrderDetailTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    
}

-(void)initBottomView{
    bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor=WHITEColor;
    chatBtn=[[UIButton alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-15*2, 40)];
    [chatBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    [chatBtn setTitle:@"对话" forState:UIControlStateNormal];
    [chatBtn setBackgroundColor:BLACKCOLOR];
    chatBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    chatBtn.layer.cornerRadius=5;
    chatBtn.clipsToBounds=YES;
    [bottomView addSubview:chatBtn];
    [chatBtn addTarget:self action:@selector(chatAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomView];
}

-(void)chatAction:(UIButton*)sender{
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
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
