//
//  PanDaiFuViewController.m
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "PanDaiFuViewController.h"
#import "PJPenDaiFuTableViewCell.h"
#import "CommentInfo.h"
#import "PenDaiFuDetailViewController.h"
#import "PersonalHomeViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "PenDaiFuDetailViewController.h"
@interface PanDaiFuViewController ()<PJPenDaiFuTableViewCellDeleagte>
@property (nonatomic, strong)SlideSwitchView *slideSwitchView;
@property (nonatomic, strong)AIMultiDelegate *multiDelegate;
@property(nonatomic,strong)NSMutableArray *list;
@property(nonatomic,weak)NSIndexPath *indexPath;
@end

@implementation PanDaiFuViewController
static NSString *identify=@"identify";
static NSInteger pageNum=10;
- (instancetype)initSlideSwitchView:(SlideSwitchView *)slideSwitchView{
    self = [super init];
    if (self) {
        _slideSwitchView = slideSwitchView;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.list=[[NSMutableArray alloc] init];

    [self.tableView registerClass:[PJPenDaiFuTableViewCell class] forCellReuseIdentifier:identify];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    WS(weakSelf)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    [self requestData];
}


-(void)requestData{
    currentPage=1;
    //Type=3 淘一盆
    //    NSString *param=[NSString stringWithFormat:@"UID=%@&Page=%ld&PageSize=%ld",[DataSource sharedDataSource].userInfo.ID,currentPage,pageNum];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:currentPage],@"Page",[NSNumber numberWithInteger:pageNum],@"PageSize",@"4",@"Type",@"",SenShu,@"",LeiBie,@"",ChanDi,@"",PinZhong,@"",ShuXin,@"",ChiCun,@"",QiTa, nil];
    [HttpConnection GetBonsaiList:dic WithBlock:^(id response, NSError *error) {
        [self.tableView.header endRefreshing];
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



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenJinInfo *info=_list[indexPath.row];
    float comment_Height=0;
    float offY_Comment=4;
    if (info.Comment.count) {//计算评论高度
        for (int i=0; i<info.Comment.count; i++) {
            CommentInfo *comment=info.Comment[i];
            comment_Height+=  [CommonFun sizeWithString:comment.Message font:[UIFont systemFontOfSize:comment_FontSize] size:CGSizeMake(SCREEN_WIDTH-15-10*2, MAXFLOAT)].height;
            comment_Height+=offY_Comment;
        }
        comment_Height-=2;
        
    }
    return 400+30+BottomToolView_Height+comment_Height;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PJPenDaiFuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    cell.indexPath=indexPath;
    [cell setInfo:_list[indexPath.row]];
    [cell setClickBlock:^(id sender){
        NSLog(@"点击头像");
        //           self.indexPath=indexPath;
        
        [self gotoPersonalHome:_list[indexPath.row]];
        
    }];
    [cell setPraiseBlock:^(id sender){
        NSLog(@"setPraiseBlock");
        self.indexPath=indexPath;
        [self praisedAction:_list[indexPath.row]];
    }];
    
    [cell setCollectBlock:^(id sender){
        NSLog(@"setCollectBlock");
        self.indexPath=indexPath;
        [self collectAction:_list[indexPath.row]];
    }];
    
    [cell setCommentBlock:^(id sender){
        NSLog(@"setCommentBlock");
    }];
    
    [cell setChatBlock:^(id sender){
        NSLog(@"setChatBlock");
        self.indexPath=indexPath;
        [self msgAction:_list[indexPath.row]];
    }];
    
    [cell setAttentionBlock:^(id sender){
        self.indexPath=indexPath;
        [self attentionAction:_list[indexPath.row]];
    }];
    [cell updateConstraintsIfNeeded];
    [cell layoutIfNeeded];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}


-(void)gotoDetailView:(NSIndexPath *)indexPath{
    PenDaiFuDetailViewController *ctr=[[PenDaiFuDetailViewController alloc] init];
    ctr.info=_list[indexPath.row];
    [self hideTabBar:YES animated:NO];
    [self.navigationController pushViewController:ctr animated:YES];
}

-(void)msgAction:(PenJinInfo*)info{
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = info.UID;
    //设置聊天会话界面要显示的标题
    chat.title = info.userInfo.NickName;
    //显示聊天会话界面
    [self hideTabBar:YES animated:NO];
    [self.navigationController pushViewController:chat animated:YES];
}



//收藏 取消收藏
-(void)collectAction:(PenJinInfo*)info{
    [SVProgressHUD show];
    Collect_Type type=KCollect_Penjin;
    if (![info.IsCollect boolValue]) {
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",info.ID,@"BeID",@"1",@"Type", nil];
        [HttpConnection Collection:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                [SVProgressHUD showInfoWithStatus:@"已收藏"];
                info.IsCollect=@"1";
                [self reloadTableAtIndex];
            }
            else{
                [SVProgressHUD showErrorWithStatus:ErrorMessage];
            }
            
        }];
    }
    else{
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",info.ID,@"BeID",@"1",@"Type", nil];
        [HttpConnection DelCollect:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                [SVProgressHUD showInfoWithStatus:@"已取消收藏"];
                info.IsCollect=@"0";
                [self reloadTableAtIndex];
            }
            else{
                [SVProgressHUD showErrorWithStatus:ErrorMessage];
            }
            
        }];
    }
}


-(void)attentionAction:(PenJinInfo*)info{
    [SVProgressHUD show];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",info.userInfo.ID,@"BUID", nil];
    [HttpConnection Focus:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:@"已关注"];
                info.userInfo.IsFocus=@"1";
                [self reloadTableAtIndex];
                
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        
    }];
}

//赞
-(void)praisedAction:(PenJinInfo*)info{
    [SVProgressHUD show];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",info.ID,@"BeID",@"1",@"Type", info.userInfo.ID,@"buid",nil];
    [HttpConnection Praised:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:@"已赞"];
                info.IsPraise=@"1";
                [self reloadTableAtIndex];
                
            }
            else{
                 [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        
    }];
}

-(void)gotoPersonalHome:(PenJinInfo*)info{
    PersonalHomeViewController *ctr=[[PersonalHomeViewController alloc] init];
    ctr.userInfo=info.userInfo;
    [self hideTabBar:YES animated:NO];
    [self.navigationController pushViewController:ctr animated:YES];
}


-(void)reloadTableAtIndex{
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:_indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PenDaiFuDetailViewController *ctr=[[PenDaiFuDetailViewController alloc] init];
    ctr.info=_list[indexPath.row];
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
