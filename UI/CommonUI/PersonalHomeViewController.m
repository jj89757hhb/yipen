//
//  PersonalHomeViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
// 个人主页

#import "PersonalHomeViewController.h"
#import "PersonalHomeHeadTableViewCell.h"
#import "PersonalSendTreeTableViewCell.h"
#import <RongIMKit/RongIMKit.h>
#import "FenXiangDetailViewController.h"
#import "ShareView.h"
@interface PersonalHomeViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSInteger Page;
    ShareView *_shareView;
}
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation PersonalHomeViewController
static NSString *identify=@"identify";
static NSString *identify2=@"identify2";
static NSInteger PageSize=10;
- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    [self initTable];
    NSString *param2=[NSString stringWithFormat:@"UID=%@",_info.userInfo.ID];
//    [HttpConnection getOwnerInfoWithParameter:param2 WithBlock:^(id response, NSError *error) {
//        
//    }];
    [self requestDataIsRefresh:YES];
    [self.navigationController.navigationBar setAlpha:0.6];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0-44, SCREEN_WIDTH, SCREEN_HEIGHT+44) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"PersonalHomeHeadTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    [myTable registerNib:[UINib nibWithNibName:@"PersonalSendTreeTableViewCell" bundle:nil] forCellReuseIdentifier:identify2];
    WS(weakSelf)
    [myTable addLegendHeaderWithRefreshingBlock:^{
        [weakSelf requestDataIsRefresh:YES];
    }];
    [myTable addLegendFooterWithRefreshingBlock:^{
        [weakSelf requestDataIsRefresh:NO];
    }];
}


-(void)requestDataIsRefresh:(BOOL)isRefresh{
    if (isRefresh) {
        Page=1;
    }
    if (!_userInfo.ID.length) {
        _userInfo.ID=_userInfo.UserId;
    }
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_userInfo.ID,@"UID",[NSNumber numberWithInteger:Page],@"Page",[NSNumber numberWithInteger:PageSize],@"PageSize", nil];
    [HttpConnection GetMyShareList:dic WithBlock:^(id response, NSError *error) {
        [SVProgressHUD dismiss];
        [myTable.header endRefreshing];
        [myTable.footer endRefreshing];
        if (!error) {
            if (![response objectForKey:KErrorMsg]) {
                if (Page==1) {
                    self.list=response[KDataList];
                }
                else{
                    [self.list addObjectsFromArray:response[KDataList]];
                }
                
                [myTable reloadData];
                Page++;
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



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return _list.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
//          return 220;
        return 236.5;
    }
    else{
        return 180;
    }
  
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        PersonalHomeHeadTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.attentionBtn addTarget:self action:@selector(attentionAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.bgIV setImage:[UIImage imageNamed:@"图层-12"]];
        [cell.headIV sd_setImageWithURL:[NSURL URLWithString:_userInfo.UserHeader] placeholderImage:Default_Image];
        [cell.nameL setText:_userInfo.NickName];
        [cell.msgBtn addTarget:self action:@selector(msgAction:) forControlEvents:UIControlEventTouchUpInside];
        if ([_userInfo.IsFocus boolValue]) {
            [cell.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
//            [cell.attentionBtn setUserInteractionEnabled:NO];
        }
        else{
            [cell.attentionBtn setTitle:@"关注" forState:UIControlStateNormal]
            ;
            [cell.attentionBtn setUserInteractionEnabled:YES];
        }
        if ([_userInfo.ID isEqualToString:[DataSource sharedDataSource].userInfo.ID]) {
            [cell.msgBtn setHidden:YES];
            [cell.attentionBtn setHidden:YES];
        }
//        if ([_userInfo.Levels integerValue]==1) {
        [cell.levelL setText:[NSString stringWithFormat:@"等级: LV0%@",_userInfo.Levels?_userInfo.Levels:@"1"]];
//        }
        if (![_userInfo.IsCertifi boolValue]) {
            [cell.verifyL setText:@"认证: 暂无"];
        }
        else{
              [cell.verifyL setText:[NSString stringWithFormat:@"认证: %@",_userInfo.CertifiInfo]];
        }
        cell.fansL.text=[NSString stringWithFormat:@"粉丝: %@",_userInfo.Fans?_userInfo.Fans:@"0"];
        return cell;
    }
    else{
        PersonalSendTreeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify2 forIndexPath:indexPath];
        PenJinInfo *info=_list[indexPath.row];
        if (_userInfo) {//赋值给PenJinInfo
            info.userInfo=_userInfo;
        }

        [cell setInfo:info];
        cell.index=indexPath;
        WS(weakSelf)
        [cell setShareBlock:^(id sender){
            [weakSelf shareWithIndex:sender];
        }];
        return cell;
        
    }
    return nil;
    
}

//关注
-(void)attentionAction:(UIButton*)sender{
    //BUID
    [SVProgressHUD show];
//    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID", _info.UID,@"BUID",nil];
       NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID", _userInfo.ID,@"BUID",nil];
    if (![_userInfo.IsFocus boolValue]) {
        [HttpConnection Focus:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    _userInfo.IsFocus = @"1";
                    [SVProgressHUD showSuccessWithStatus:@"已关注"];
                    [myTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                }
                else{
                    [SVProgressHUD showErrorWithStatus:[response objectForKey:@"Reason"]];
                }
            }
            else{
                [SVProgressHUD showErrorWithStatus:ErrorMessage];
            }
            
        }];
    }
    else{
        [HttpConnection CancelFocus:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    _userInfo.IsFocus = @"0";
                    [SVProgressHUD showSuccessWithStatus:@"已取消关注"];
                    [myTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
                }
                else{
                    [SVProgressHUD showErrorWithStatus:[response objectForKey:@"Reason"]];
                }
            }
            else{
                [SVProgressHUD showErrorWithStatus:ErrorMessage];
            }
            
        }];
    }
 
}

-(void)shareWithIndex:(NSIndexPath*)index{
     PenJinInfo *info=_list[index.row];
    _shareView=[[ShareView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _shareView.backgroundColor= [[UIColor blackColor] colorWithAlphaComponent:0.5];
    _shareView.imageUrls=info.Attach;
    _shareView.title = info.Title;
    _shareView.content = info.Descript;
    [[UIApplication sharedApplication].keyWindow  addSubview:_shareView];
}

-(void)msgAction:(UIButton*)sender{
    if ([_userInfo.ID isEqualToString:[DataSource sharedDataSource].userInfo.ID]) {
        return;
    }
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = _userInfo.ID;
    //设置聊天会话界面要显示的标题
    chat.title = _userInfo.NickName;
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
        return;
    }
    [myTable deselectRowAtIndexPath:indexPath animated:NO];
    FenXiangDetailViewController *ctr=[[FenXiangDetailViewController alloc] init];
    ctr.info=_list[indexPath.row];
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
