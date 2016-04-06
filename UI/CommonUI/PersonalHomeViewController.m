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
@interface PersonalHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PersonalHomeViewController
static NSString *identify=@"identify";
static NSString *identify2=@"identify2";
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
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
          return 220;
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
        [cell.headIV sd_setImageWithURL:[NSURL URLWithString:_userInfo.UserHeader] placeholderImage:nil];
        [cell.nameL setText:_userInfo.NickName];
        [cell.msgBtn addTarget:self action:@selector(msgAction:) forControlEvents:UIControlEventTouchUpInside];
        if ([_userInfo.IsFocus boolValue]) {
            [cell.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
            [cell.attentionBtn setUserInteractionEnabled:NO];
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
        return cell;
    }
    else{
        PersonalSendTreeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify2 forIndexPath:indexPath];
        return cell;
        
    }
    return nil;
    
}

//关注
-(void)attentionAction:(UIButton*)sender{
    //BUID
    [SVProgressHUD show];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID", _info.UID,@"BUID",nil];
    [HttpConnection Focus:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"已关注"];
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
