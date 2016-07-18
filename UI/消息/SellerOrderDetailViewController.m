//
//  SellerOrderDetailViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/7/14.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SellerOrderDetailViewController.h"
#import "MySellOrderTableViewCell.h"
#import <RongIMKit/RongIMKit.h>
@interface SellerOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *myTable;
}

@end

@implementation SellerOrderDetailViewController
static NSString *identify=@"identify";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"订单详情";
    // Do any additional setup after loading the view.
    [self initTable];
}

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    myTable.delegate=self;
    myTable.dataSource=self;
    [myTable registerNib:[UINib nibWithNibName:@"MySellOrderTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    [self.view addSubview:myTable];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MySellOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    WS(weakSelf)
    [cell setMsgBlock:^(id sender){
        [weakSelf sendMsg];
    }];
    
    [cell setSendGoodsBlock:^(id sender){
//        [self editExpressInfo];
    }];
    
    [cell setExchangeInfo:_info];
    return cell;

}

-(void)sendMsg{
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = _info.BuyUser.ID;
    //设置聊天会话界面要显示的标题
    chat.title = _info.BuyUser.NickName;
    //显示聊天会话界面
//    [self hideTabBar:YES animated:NO];
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
