//
//  MyAccountViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MyAccountViewController.h"
#import "FundDetailsViewController.h"
#import "WithdrawViewController.h"
#import "SetPayPsw1ViewController.h"
#import "ManagerWithdrawViewController.h"
#import "RechargeViewController.h"
@interface MyAccountViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"账户";
    [self initTable];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    [self queryPersonalInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(queryPersonalInfo) name:@"queryPersonalInfo2" object:nil];
}

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 160;
    }
    return 45;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *identify=@"identify2";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UILabel *numL=[[UILabel alloc] initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, 20)];
        numL.textColor=[UIColor redColor];
//        numL.text=@"¥20";
        ;
        numL.text=[NSString stringWithFormat:@"¥%@",[DataSource sharedDataSource].userInfo.Balance];
        numL.textAlignment=NSTextAlignmentCenter;
        numL.font=[UIFont boldSystemFontOfSize:22];
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(numL.frame)+5, SCREEN_WIDTH, 20)];
        label.text=@"余额";
        label.font=[UIFont systemFontOfSize:14];
        label.textColor=[UIColor darkGrayColor];
        label.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:numL];
        [cell.contentView addSubview:label];
        UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+10, SCREEN_WIDTH, 0.5)];
        line.backgroundColor=Line_Color;
        [cell.contentView addSubview:line];
        UIFont *font=[UIFont systemFontOfSize:16];
        UIButton *rechargeBtn=[[UIButton alloc] initWithFrame:CGRectMake(0,CGRectGetMaxY(line.frame)+1,SCREEN_WIDTH/2,45)];
        [rechargeBtn setTitle:@"充值" forState:UIControlStateNormal];
        [rechargeBtn addTarget:self action:@selector(rechargeAction) forControlEvents:UIControlEventTouchUpInside];
        UIButton * withdrawBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, rechargeBtn.frame.origin.y, SCREEN_WIDTH/2, 45)];
          [withdrawBtn setTitle:@"提现" forState:UIControlStateNormal];
        [cell.contentView addSubview:rechargeBtn];
        [cell.contentView addSubview:withdrawBtn];
        [withdrawBtn addTarget:self action:@selector(withdrawAction) forControlEvents:UIControlEventTouchUpInside];
        rechargeBtn.titleLabel.font=font;
        withdrawBtn.titleLabel.font=font;
        [rechargeBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        [withdrawBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
        UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,CGRectGetMaxY(line.frame)+10, 0.5, 20)];
        line2.backgroundColor=Line_Color;
        [cell.contentView addSubview:line2];
        return cell;
    }
    else{
    static NSString *identify=@"identify";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section==1) {
            cell.textLabel.text=@"资金明细";
        }
        else if (indexPath.section==2){
              cell.textLabel.text=@"管理提现账号";
        }
        else if(indexPath.section==3){
              cell.textLabel.text=@"设置支付密码";
        }
    return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1){
        FundDetailsViewController *ctr=[[FundDetailsViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:ctr animated:YES];

    }
    else if (indexPath.section==2){
        ManagerWithdrawViewController *ctr=[[ManagerWithdrawViewController alloc] initWithNibName:nil bundle:nil];
         [self.navigationController pushViewController:ctr animated:YES];
    }
    else if (indexPath.section==3){
        SetPayPsw1ViewController *ctr=[[SetPayPsw1ViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:ctr animated:YES];
    }
}

//提现
-(void)withdrawAction{
    WithdrawViewController *ctr=[[WithdrawViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:ctr animated:YES];
}

//充值
-(void)rechargeAction{
    RechargeViewController *ctr=[[RechargeViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:ctr animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)queryPersonalInfo{
    if (![DataSource sharedDataSource].userInfo.ID) {
        [myTable.header endRefreshing];
        return;
    }
    NSString *param=[NSString stringWithFormat:@"UID=%@",[DataSource sharedDataSource].userInfo.ID];
    [HttpConnection getOwnerInfoWithParameter:param WithBlock:^(id response, NSError *error) {
        [myTable.header endRefreshing];
        if (!error) {
            if ([[response objectForKey:@"ok"] isEqualToString:@"TRUE"]) {
//                NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:0];
//                [myTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
                [myTable reloadData];
            }
            else{
                [SVProgressHUD showInfoWithStatus:[response objectForKey:@"Reason"]];
            }
        }
        else{
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }
        
    }];
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
