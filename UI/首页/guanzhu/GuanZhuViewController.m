//
//  GuanZhuViewController.m
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "GuanZhuViewController.h"
#import "PenJinInfo.h"
#import "CommentInfo.h"
#import "FenXiangTableViewCell.h"
#import "PersonalHomeViewController.h"
#import "FenXiangDetailViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "TreeSort.h"
@interface GuanZhuViewController ()<FenXiangTableViewDeleagte>
@property (nonatomic, strong)SlideSwitchView *slideSwitchView;
@property (nonatomic, strong)AIMultiDelegate *multiDelegate;
@property(nonatomic,strong)NSMutableArray *list;
@property(nonatomic,strong)NSIndexPath *indexPath;
@end

@implementation GuanZhuViewController
static NSString *identity=@"identity";
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
    currentPage=1;
    [SVProgressHUD show];
    [self requestDataIsRefresh:YES];
    [self.tableView registerClass:[FenXiangTableViewCell class] forCellReuseIdentifier:identity];
    WS(weakSelf)
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        currentPage=1;
        [weakSelf requestDataIsRefresh:YES];
    }];
    
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        [weakSelf requestDataIsRefresh:NO];
    }];


}


-(void)requestDataIsRefresh:(BOOL)isRefresh{
    if (isRefresh) {
          currentPage=1;
    }
    NSString *senShu=@"";
    NSString *leiBie=@"";
    NSString *chanDi=@"";
    NSString *pinZhong=@"";
    NSString *shuXin=@"";
    NSString *chiCun=@"";
    NSString *qiTa=@"";
    if (_selectSort.allKeys) {//选择了搜索
        if ([_selectSort.allKeys[0] isEqualToString:SenShu]) {
            TreeSort *sort=_selectSort[SenShu];
            senShu=sort.CodeValue;
        }
        else if ([_selectSort.allKeys[0] isEqualToString:LeiBie]) {
            TreeSort *sort=_selectSort[LeiBie];
            leiBie=sort.CodeValue;
        }
        else if ([_selectSort.allKeys[0] isEqualToString:ChanDi]) {
            TreeSort *sort=_selectSort[ChanDi];
            chanDi=sort.CodeValue;
        }
        else if ([_selectSort.allKeys[0] isEqualToString:PinZhong]) {
            TreeSort *sort=_selectSort[PinZhong];
            pinZhong=sort.CodeValue;
        }
        else if ([_selectSort.allKeys[0] isEqualToString:ShuXin]) {
            TreeSort *sort=_selectSort[ShuXin];
            shuXin=sort.CodeValue;
        }
        else if ([_selectSort.allKeys[0] isEqualToString:ChiCun]) {
            TreeSort *sort=_selectSort[ChiCun];
            chiCun=sort.CodeValue;
        }
        else if ([_selectSort.allKeys[0] isEqualToString:QiTa]) {
            TreeSort *sort=_selectSort[QiTa];
            qiTa=sort.CodeValue;
        }
    }
    
    
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:currentPage],@"Page",[NSNumber numberWithInteger:pageNum],@"PageSize",@"2",@"Type",senShu,SenShu,leiBie,LeiBie,chanDi,ChanDi,pinZhong,PinZhong,shuXin,ShuXin,chiCun,ChiCun,qiTa,QiTa, nil];
    [HttpConnection GetBonsaiList:dic WithBlock:^(id response, NSError *error) {
        [SVProgressHUD dismiss];
        [self.tableView.header endRefreshing];
        [self.tableView.footer endRefreshing];
        if (!error) {
            if (![response objectForKey:KErrorMsg]) {
                if (currentPage==1) {
                    self.list=response[KDataList];
                }
                else{
                    [self.list addObjectsFromArray:response[KDataList]];
                }
                
                [self.tableView reloadData];
                currentPage++;
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
    float content_Height=0;
    if (info.Comment.count) {//计算评论高度
        for (int i=0; i<info.Comment.count; i++) {
            CommentInfo *comment=info.Comment[i];
            comment_Height+=  [CommonFun sizeWithString:comment.Message font:[UIFont systemFontOfSize:comment_FontSize] size:CGSizeMake(SCREEN_WIDTH-15-10*2, MAXFLOAT)].height;
            comment_Height+=offY_Comment;
        }
        comment_Height-=2;
        
    }
    if (info.Descript.length) {
        content_Height+= [CommonFun sizeWithString:info.Descript font:[UIFont systemFontOfSize:content_FontSize] size:CGSizeMake(SCREEN_WIDTH-15-10*2, MAXFLOAT)].height;
    }
    return 380+30+BottomToolView_Height+comment_Height+content_Height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FenXiangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identity];
    [cell setInfo:_list[indexPath.row]];
    cell.indexPath=indexPath;
    cell.delegate=self;
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
        [self willComment:nil];
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
    return  cell;
    
}

-(void)willComment:(id)sender {
    FenXiangDetailViewController *ctr=[[FenXiangDetailViewController alloc] init];
    ctr.isPopKeyBoard=YES;
    ctr.info=_list[_indexPath.row];
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
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",info.ID,@"BeID",@"1",@"Type",info.userInfo.ID,@"buid", nil];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FenXiangDetailViewController *ctr=[[FenXiangDetailViewController alloc] init];
    ctr.info=_list[indexPath.row];
    [self hideTabBar:YES animated:NO];
    [self.navigationController pushViewController:ctr animated:YES];
}

-(void)reloadTableAtIndex{
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:_indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)gotoDetailView:(NSIndexPath *)indexPath{
    FenXiangDetailViewController *ctr=[[FenXiangDetailViewController alloc] init];
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
