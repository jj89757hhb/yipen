//
//  MyViewController.m
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "MyViewController.h"
#import "MyHeaderTableViewCell.h"
#import "SettingViewController.h"
#import "EditInfoViewController.h"
#import "ExchangeViewController.h"
#import "MemberAndLevelViewController.h"
#import "MyAccountViewController.h"
#import "PenDaiFuViewController.h"
#import "PenYuanViewController.h"
#import "SameCitySendViewController.h"
#import "AuctionViewController.h"
#import "ShareViewController.h"
#import "AttentionViewController.h"
#import "FansViewController.h"
#import "MyCollectViewController.h"
@interface MyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)MyHeaderTableViewCell *headerCell;
@end

@implementation MyViewController
static NSString *headerCellIdentify=@"MyHeaderTableViewCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    WS(weakSelf)
    [self setNavigationBarRightItem:nil itemImg:[UIImage imageNamed:@"设置"] withBlock:^(id sender) {
        [weakSelf setAction];
    }];
    [myTable addLegendHeaderWithRefreshingBlock:^{
        [weakSelf queryPersonalInfo];
    }];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [super hideTabBar:NO animated:NO];
}

-(void)initTableView{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-20) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"MyHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:headerCellIdentify];
  
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else if(section==1){
        return 3;
    }
    else if(section==2){
        return 3;
    }
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 150;
    }
    else if(indexPath.section==1){
        return 44;
    }
    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        MyHeaderTableViewCell *cell=[myTable dequeueReusableCellWithIdentifier:headerCellIdentify];
        cell.accessoryType=UITableViewCellAccessoryNone;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.editBtn addTarget:self action:@selector(editBtnAction) forControlEvents:UIControlEventTouchUpInside];
        cell.nameL.text=[DataSource sharedDataSource].userInfo.NickName;
        [cell.headIV sd_setImageWithURL:[NSURL URLWithString:[DataSource sharedDataSource].userInfo.UserHeader] placeholderImage:Default_Image];
        cell.attentionNumL.text=[DataSource sharedDataSource].userInfo.focusNum;
        cell.fansNumL.text=[DataSource sharedDataSource].userInfo.Fans;
        cell.shareNumL.text=[DataSource sharedDataSource].userInfo.ShareNum;
        [cell.levelL setImage:[UIImage imageNamed:[NSString stringWithFormat:@"lv%@",[DataSource sharedDataSource].userInfo.Levels]]];
        NSLog(@"111:%@",[DataSource sharedDataSource].userInfo.Fans);
   
        WS(weakSelf)
        [cell setMyHeaderCellBlock:^(id sender){
            if ([sender isEqual:cell.shareBtn]) {//分享
                [weakSelf shareAction];
            }
            else if([sender isEqual:cell.attentionBtn]){//关注
                [weakSelf attentionAction];
            }
            else if([sender isEqual:cell.fansBtn]){//粉丝
                [weakSelf fansAction];
            }
            
        }];
        self.headerCell=cell;
           return cell;
    }
    else{
    static NSString *identify=@"identify";
    UIFont *font=[UIFont systemFontOfSize:16];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        
        cell.textLabel.font=font;
        cell.textLabel.textColor=MIDDLEBLACK;
    }
  
    if(indexPath.section==1){
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            cell.imageView.image=[UIImage imageNamed:@"账户"];
            cell.textLabel.text=@"账户";
          
        }
        else if(indexPath.row==1){
            cell.imageView.image=[UIImage imageNamed:@"交易"];
            cell.textLabel.text=@"交易";
        }
        else if(indexPath.row==2){
            cell.imageView.image=[UIImage imageNamed:@"竞拍"];
            cell.textLabel.text=@"竞拍";
        }
    }
    else if(indexPath.section==2){
         cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            cell.imageView.image=[UIImage imageNamed:@"收藏"];
            cell.textLabel.text=@"收藏";
        }
        else if(indexPath.row==1){
            cell.imageView.image=[UIImage imageNamed:@"盆缘_我的"];
            cell.textLabel.text=@"盆缘";
        }
        else if(indexPath.row==2){
            cell.imageView.image=[UIImage imageNamed:@"盆大夫_我的"];
            cell.textLabel.text=@"盆大夫";
        }
    }
    else if(indexPath.section==3){
         cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            cell.imageView.image=[UIImage imageNamed:@"同城"];
            cell.textLabel.text=@"同城发布";
        }
    }
    else if(indexPath.section==4){
           cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            cell.imageView.image=[UIImage imageNamed:@"等级认证"];
            cell.textLabel.text=@"会员/认证/等级";
        }
    }
           return cell;
    }
 
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [myTable  deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        [self editBtnAction];
    }
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            MyAccountViewController *ctr=[[MyAccountViewController alloc] initWithNibName:nil bundle:nil];
            [self hideTabBar:YES animated:NO];;
            [self.navigationController pushViewController:ctr animated:YES];
        }
        else if (indexPath.row==1) {
            ExchangeViewController *ctr=[[ExchangeViewController alloc] init];
            [self hideTabBar:YES animated:NO];
            [self.navigationController pushViewController:ctr animated:YES];
        }
        else if(indexPath.row==2){
            AuctionViewController *ctr=[[AuctionViewController alloc] initWithNibName:nil bundle:nil];
            [self hideTabBar:YES animated:NO];
            [self.navigationController pushViewController:ctr animated:YES];
        }
    }
    else if(indexPath.section==2){
        if (indexPath.row==0) {//收藏
            MyCollectViewController *ctr=[[MyCollectViewController alloc] init];
            [self hideTabBar:YES animated:NO];
            [self.navigationController pushViewController:ctr animated:YES];
        }
        else if (indexPath.row==1) {
            PenYuanViewController *ctr=[[PenYuanViewController alloc] initWithNibName:nil bundle:nil];
            [self hideTabBar:YES animated:NO];
            [self.navigationController pushViewController:ctr animated:YES];
        }
        else if (indexPath.row==2) {
            PenDaiFuViewController *ctr=[[PenDaiFuViewController alloc] initWithNibName:nil bundle:nil];
            [self hideTabBar:YES animated:NO];
            [self.navigationController pushViewController:ctr animated:YES];
        }
    }
    else if (indexPath.section==3){
        if (indexPath.row==0) {
            SameCitySendViewController *ctr=[[SameCitySendViewController alloc] initWithNibName:nil bundle:nil];
            [self hideTabBar:YES animated:NO];
            [self.navigationController pushViewController:ctr animated:YES];
        }
    }
    else if (indexPath.section==4){
        MemberAndLevelViewController *ctr=[[MemberAndLevelViewController alloc] initWithNibName:nil bundle:nil];
        [self hideTabBar:YES animated:NO];
        [self.navigationController pushViewController:ctr animated:YES];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [super hideTabBar:NO animated:NO];
    if (![DataSource sharedDataSource].userInfo.Sex) {
        [self queryPersonalInfo];
 
    }
    _headerCell.nameL.text=[DataSource sharedDataSource].userInfo.NickName;
    [_headerCell.headIV sd_setImageWithURL:[NSURL URLWithString:[DataSource sharedDataSource].userInfo.UserHeader] placeholderImage:Default_Image];
  
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
                NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:0];
                [myTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
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

-(void)editBtnAction{
          [super hideTabBar:YES animated:NO];
    EditInfoViewController *ctr=[[EditInfoViewController alloc] initWithNibName:nil bundle:nil];
 
    [self.navigationController pushViewController:ctr animated:YES];
}

-(void)setAction{
       [super hideTabBar:YES animated:NO];
    SettingViewController *ctr=[[SettingViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:ctr animated:YES];
}


//分享
-(void)shareAction{
    ShareViewController *ctr=[[ShareViewController alloc] initWithNibName:nil bundle:nil];
     [self hideTabBar:YES animated:NO];
    [self.navigationController pushViewController:ctr animated:YES];
}


//关注
-(void)attentionAction{
    AttentionViewController *ctr=[[AttentionViewController alloc] initWithNibName:nil bundle:nil];
    [self hideTabBar:YES animated:NO];
    [self.navigationController pushViewController:ctr animated:YES];
}

//粉丝
-(void)fansAction{
    FansViewController *ctr=[[FansViewController alloc] initWithNibName:nil bundle:nil];
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
