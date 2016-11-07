//
//  MessageExchangeViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MessageExchangeViewController.h"
#import "MessageExchangeTableViewCell.h"
#import "MessageExchange2TableViewCell.h"
#import "OfferPriceView.h"
#import "AppDelegate.h"
#import "FenXiangDetailViewController.h"
#import "ExchangeInfo.h"
#import "NegotiatePriceView.h"
#import "WillBuyViewController.h"
#import "SellerOrderDetailViewController.h"
#import "OrderDetailViewController.h"
#import "BDetail.h"

@interface MessageExchangeViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSInteger currentPage;
    
}
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation MessageExchangeViewController
static NSString *identify=@"identify";
static NSString *identify2=@"identify2";
static NSInteger pageSize = 10;
- (void)viewDidLoad {
    [super viewDidLoad];
    currentPage=1;
    [self initTable];
    [self requestDataIsRefresh:YES];
    
}

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64-15) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    [myTable registerNib:[UINib nibWithNibName:@"MessageExchangeTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    [myTable registerNib:[UINib nibWithNibName:@"MessageExchange2TableViewCell" bundle:nil] forCellReuseIdentifier:identify2];
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
        currentPage=1;
    }
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:pageSize],@"PageSize",[NSNumber numberWithInteger:currentPage],@"Page",[DataSource sharedDataSource].userInfo.ID,@"BuyerID", nil];
    [HttpConnection GetBargainingRecord:dic WithBlock:^(id response, NSError *error) {
        [myTable.footer endRefreshing];
        [myTable.header endRefreshing];
        if (!error) {
            if (![response objectForKey:KErrorMsg]) {
                if (currentPage==1) {
                    self.list=response[KDataList];
                }
                else{
                    [self.list addObjectsFromArray:response[KDataList]];
                }

                [myTable reloadData];
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 220;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
        MessageExchangeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        [cell.replyPriceBtn addTarget:self action:@selector(showReplyPrice) forControlEvents:UIControlEventTouchUpInside];
        [cell setInfo:_list[indexPath.row]];
    
//        [cell setReplyPriceBlock:^(id sender){
////            OfferPriceView *view=[[OfferPriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        
//          
//        }];
    cell.index=indexPath;
    
    [cell setOfferPriceBlock:^(id sender){
        [self offerPriceWithIndex:sender];
    }];
    [cell setReplyPriceBlock:^(id sender){
        [self showReplyPriceWithIndex:sender];
    }];
    
    [cell setBuyBlock:^(id sender){
        [self willBuyWithIndex:sender];
    }];
    
    [cell setAggreeBlock:^(id sender){
        [self aggreeWithIndex:sender];
    }];
    [cell setOrderBlock:^(id sender){
        [self orderWithIndex:sender];
    }];
    [cell setRefuseBlock:^(id sender){
        [self refuseWithIndex:sender];
    }];
    [cell updateConstraintsIfNeeded];
    [cell layoutIfNeeded];
        return cell;
//    }
//    else{
//        MessageExchange2TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify2 forIndexPath:indexPath];
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        return cell;
//    }
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FenXiangDetailViewController *ctr=[[FenXiangDetailViewController alloc] init];
    ExchangeInfo *info=_list[indexPath.row];
    info.Bonsai.userInfo=info.SaleUser;
    ctr.info=info.Bonsai;
    [self hideTabBar:YES animated:NO];
    [self.navigationController pushViewController:ctr animated:YES];
}

//买方议价 或 卖方回价
-(void)showReplyPriceWithIndex:(NSIndexPath*)index{
    ExchangeInfo *info=_list[index.row];
    NSString *msg=@"已提交议价，请耐心等待对方的答复";
    Negotiate_Type negotiate_Type=KOffer_Price_Seller;
    Buy_Result result=KNegotiate;
    BOOL isNegotiate=YES;
    if ([info.Bonsai.IsMarksPrice boolValue]) {//明价的
        if([info.Phase integerValue]==1){//明价 卖家回价
//            msg=@"已提交回价，请耐心等待对方的答复";
            negotiate_Type=KOffer_Price_Seller;
//            isNegotiate=NO;
        }
        else if([info.Phase integerValue]==2){
//            msg=@"已提交回价，请耐心等待对方的答复";
            negotiate_Type=KNegotiate_buyer;
//            isNegotiate=NO;
        }
    }
    else{
        if([info.Phase integerValue]==1){//不明价 卖家报价
            //            msg=@"已提交回价，请耐心等待对方的答复";
            negotiate_Type=KOffer_Price_Seller;
            //            isNegotiate=NO;
        }
        else if([info.Phase integerValue]==2){//议价
//            msg=@"已提交回价，请耐心等待对方的答复";
            negotiate_Type=KNegotiate_buyer;
//            isNegotiate=NO;
        }
        else if ([info.Phase integerValue]==3) {//不明价 卖家回价
         
            negotiate_Type=KNegotiate_Seller;
//               msg=@"已提交回价，请耐心等待对方的答复";
//            isNegotiate=NO;
        }
    }
    //我是卖方
    if ([info.SalerID isEqualToString:[DataSource sharedDataSource].userInfo.ID]) {
        msg=@"已提交回价，请耐心等待对方的答复";
        isNegotiate=NO;
    }
    
   
   
    NegotiatePriceView *view=[[NegotiatePriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [view initViewWithPrice:info.NAmount isNegotiate:isNegotiate];
    view.backgroundColor=[BLACKCOLOR colorWithAlphaComponent:0.7];
    [AppDelegateInstance.window addSubview:view];
  
    [view setNegotiatePriceBlock:^(id sender){
        [SVProgressHUD show];
        //tranNo  IsMark
    
        NSString  *tranNo=@"-1";//交易号,首次询价填-1，以后回价根据系统返回串号
        if ([info.TranNo integerValue]) {
            tranNo=info.TranNo;
        }
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:info.SalerID,@"toUser",info.Bonsai.ID ,@"BID",[DataSource sharedDataSource].userInfo.ID,@"fromUser",sender,@"OfferPrice",[NSNumber numberWithInt:result],@"Result", [NSNumber numberWithInt:negotiate_Type],@"Status",info.Bonsai.IsMarksPrice,@"IsMark",tranNo,@"tranNo", nil];
        WS(weakSelf)
        [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showInfoWithStatus:msg];
                    [view removeFromSuperview];
                    [weakSelf requestDataIsRefresh:YES];//即时刷新
                }
                else{
                    [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
                }
            }
            else{
                [SVProgressHUD showInfoWithStatus:ErrorMessage];
            }
            
        }];
    }];

}


//卖家报价
-(void)offerPriceWithIndex:(NSIndexPath*)index{
    OfferPriceView *view=[[OfferPriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [view initView];
    [view setBaoJiaBlock:^(id sender){
        NSLog(@"报价:%@",sender);
        [self sureOffPriceWithPrice:sender Index:index];
        [view removeFromSuperview];
        
    }];
    view.backgroundColor=[BLACKCOLOR colorWithAlphaComponent:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

-(void)sureOffPriceWithPrice:(NSString*)price Index:(NSIndexPath*)index{
    NSString * msg=@"已提交报价，请耐心等待对方的答复";
    [SVProgressHUD show];
    //tranNo  IsMark
    NSString *tranNo=@"-1";//交易号,首次询价填-1，以后回价根据系统返回串号
    Negotiate_Type negotiate_Type=KOffer_Price_Seller;
    Buy_Result result=KNegotiate;
    ExchangeInfo *info=_list[index.row];
    if ([info.TranNo integerValue]) {//有交易码就传交易码
        tranNo=info.TranNo;
    }
    WS(weakSelf)
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:info.BuyerID,@"toUser",info.Bonsai.ID,@"BID",[DataSource sharedDataSource].userInfo.ID,@"fromUser",[NSNumber numberWithInt:result],@"Result", [NSNumber numberWithInt:negotiate_Type],@"Status",info.Bonsai.IsMarksPrice,@"IsMark",tranNo,@"tranNo",price,@"OfferPrice", nil];
    [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:msg];
                  [weakSelf requestDataIsRefresh:YES];//即时刷新
            }
            else{
                [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }
        
    }];

}

//购买
-(void)willBuyWithIndex:(NSIndexPath*)index{
    ExchangeInfo *info=_list[index.row];
    WillBuyViewController *ctr=[[WillBuyViewController alloc] init];
    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
    [tabBar xmTabBarHidden:YES animated:NO];
    ctr.info=info.Bonsai;
    ctr.exchangeInfo=info;
    if ([info.Bonsai.IsMailed boolValue]) {//包邮
            ctr.totalPrice=info.NAmount;
    }
    else{
        float total=[info.NAmount floatValue]+[info.Bonsai.MailFee floatValue];
         ctr.totalPrice=[NSString stringWithFormat:@"%.2f",total];
    }

    ctr.saleUser=info.SaleUser;
//    //修改实际价格的传参
//    if ([info.NAmount integerValue]) {
//        info.Bonsai.Price=info.NAmount;
//    }

    [self.navigationController pushViewController:ctr animated:YES];
}


//接受
-(void)aggreeWithIndex:(NSIndexPath*)index{
    NSString * msg=@"您已接受此价格，请耐心等待对方的答复";
    [SVProgressHUD show];
    //tranNo  IsMark
    NSString *tranNo=@"-1";//交易号,首次询价填-1，以后回价根据系统返回串号
    Negotiate_Type negotiate_Type=KOffer_Price_Seller;
    Buy_Result result=KAgree;
    ExchangeInfo *info=_list[index.row];
    
    if (![info.Bonsai.IsMarksPrice boolValue]) {//不明价商品
        if ([info.Phase integerValue]==1) {
            negotiate_Type=KOffer_Price_Seller;
        }
        else if ([info.Phase integerValue]==2) {
            negotiate_Type=KNegotiate_buyer;
        }
        else if ([info.Phase integerValue]==3) {
            negotiate_Type=KNegotiate_Seller;
        }
        else if ([info.Phase integerValue]==4) {
            negotiate_Type=KFinal_Price;
        }
        //         msg=@"您已放弃此交易";
    }
    else{
        if ([info.Phase integerValue]==1) {
            negotiate_Type=KOffer_Price_Seller;
        }
        else if ([info.Phase integerValue]==2) {
            negotiate_Type=KNegotiate_buyer;
        }
        else if ([info.Phase integerValue]==3) {
            negotiate_Type=KNegotiate_Seller;
        }
        else if ([info.Phase integerValue]==4) {
            negotiate_Type=KFinal_Price;
        }
    }
    if ([info.TranNo integerValue]) {//有交易码就传交易码
        tranNo=info.TranNo;
    }
    WS(weakSelf)
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:info.BuyerID,@"toUser",info.Bonsai.ID,@"BID",[DataSource sharedDataSource].userInfo.ID,@"fromUser",[NSNumber numberWithInt:result],@"Result", [NSNumber numberWithInt:negotiate_Type],@"Status",info.Bonsai.IsMarksPrice,@"IsMark",tranNo,@"tranNo",info.NAmount,@"OfferPrice", nil];
    [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:msg];
                [weakSelf requestDataIsRefresh:YES];//即时刷新
            }
            else{
                [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }
        
    }];

}

//拒绝
-(void)refuseWithIndex:(NSIndexPath*)index{
    NSString * msg=@"您已拒绝此价格";
    [SVProgressHUD show];
    //tranNo  IsMark
    NSString *tranNo=@"-1";//交易号,首次询价填-1，以后回价根据系统返回串号

    
    Buy_Result result=Kgiveup;
    ExchangeInfo *info=_list[index.row];
    Negotiate_Type negotiate_Type=KOffer_Price_Seller;//明价商品、卖家拒绝
    if (![info.Bonsai.IsMarksPrice boolValue]) {//不明价商品
        if ([info.Phase integerValue]==1) {
            negotiate_Type=KOffer_Price_Seller;
        }
        else if ([info.Phase integerValue]==2) {
             negotiate_Type=KNegotiate_buyer;
        }
        else if ([info.Phase integerValue]==3) {
             negotiate_Type=KNegotiate_Seller;
        }
        else if ([info.Phase integerValue]==4) {
             negotiate_Type=KFinal_Price;
        }
//         msg=@"您已放弃此交易";
    }
    else{
        if ([info.Phase integerValue]==1) {
            negotiate_Type=KOffer_Price_Seller;
        }
        else if ([info.Phase integerValue]==2) {
            negotiate_Type=KNegotiate_buyer;
        }
        else if ([info.Phase integerValue]==3) {
            negotiate_Type=KNegotiate_Seller;
        }
        else if ([info.Phase integerValue]==4) {
            negotiate_Type=KFinal_Price;
        }
    }
    if ([info.TranNo integerValue]) {//有交易码就传交易码
        tranNo=info.TranNo;
    }
    NSString *price=nil;
    if (info.BDetails.count>=2) {
        BDetail *bDetail=info.BDetails[info.BDetails.count-2];
        price=bDetail.NAmount;//获取最后一个价格
    }
    else{
        price=info.Bonsai.Price;
    }
   
    
//    if([info.Phase integerValue]==4&&[info.Bonsai.IsMarksPrice boolValue]){//买家放弃
////        negotiate_Type=KNegotiate_buyer;
//         msg=@"您已放弃此交易";
//    }
    WS(weakSelf)
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:info.BuyerID,@"toUser",info.Bonsai.ID,@"BID",[DataSource sharedDataSource].userInfo.ID,@"fromUser",[NSNumber numberWithInt:result],@"Result", [NSNumber numberWithInt:negotiate_Type],@"Status",info.Bonsai.IsMarksPrice,@"IsMark",tranNo,@"tranNo",price,@"OfferPrice", nil];
    [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:msg];
                  [weakSelf requestDataIsRefresh:YES];//即时刷新
            }
            else{
                [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }
        
    }];

}

//查看订单
-(void)orderWithIndex:(NSIndexPath*)index{
    ExchangeInfo *info=_list[index.row];
    if ([info.SalerID isEqualToString:[DataSource sharedDataSource].userInfo.ID]) {//我是卖家
        XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
        [tabBar xmTabBarHidden:YES animated:NO];
        SellerOrderDetailViewController *ctr=[[SellerOrderDetailViewController alloc] init];
        ctr.info=info;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else{
        OrderDetailViewController *ctr=[[OrderDetailViewController alloc] init];
        ctr.enterType=0;
        ctr.info=_list[index.row];
        [self.navigationController pushViewController:ctr animated:YES];
    }
  
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
