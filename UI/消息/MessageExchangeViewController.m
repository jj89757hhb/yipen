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
    [self requestData];
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
        [weakSelf requestData];
    }];
}


-(void)requestData{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:pageSize],@"PageSize",[NSNumber numberWithInteger:currentPage],@"Page",[DataSource sharedDataSource].userInfo.ID,@"BuyerID", nil];
    [HttpConnection GetBargainingRecord:dic WithBlock:^(id response, NSError *error) {
        [myTable.footer endRefreshing];
        [myTable.header endRefreshing];
        if (!error) {
            if (![response objectForKey:KErrorMsg]) {
                self.list=response[KDataList];
                [myTable reloadData];
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
        return cell;
//    }
//    else{
//        MessageExchange2TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify2 forIndexPath:indexPath];
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        return cell;
//    }
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    FenXiangDetailViewController *ctr=[[FenXiangDetailViewController alloc] init];
//    ExchangeInfo *info=_list[indexPath.row];
//    ctr.info=info.Bonsai;
//    [self.navigationController pushViewController:ctr animated:YES];
}

//买方议价 或 卖方回价
-(void)showReplyPriceWithIndex:(NSIndexPath*)index{
    ExchangeInfo *info=_list[index.row];
    NSString *msg=@"已提交议价，请耐心等待对方的答复";
    Negotiate_Type negotiate_Type=KNegotiate_buyer;
    Buy_Result result=KNegotiate;
    BOOL isNegotiate=YES;
    if ([info.Phase integerValue]==3&&![info.Bonsai.IsMarksPrice boolValue] ) {//不明价 卖家回价
        msg=@"已提交回价，请耐心等待对方的答复";
        negotiate_Type=KNegotiate_Seller;
        isNegotiate=NO;
    }
    else if([info.Phase integerValue]==1&&[info.Bonsai.IsMarksPrice boolValue] ){//明价 卖家回价
        msg=@"已提交回价，请耐心等待对方的答复";
        negotiate_Type=KNegotiate_Seller;
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
        [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showInfoWithStatus:msg];
                    [view removeFromSuperview];
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
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:info.BuyerID,@"toUser",info.Bonsai.ID,@"BID",[DataSource sharedDataSource].userInfo.ID,@"fromUser",[NSNumber numberWithInt:result],@"Result", [NSNumber numberWithInt:negotiate_Type],@"Status",info.Bonsai.IsMarksPrice,@"IsMark",tranNo,@"tranNo",price,@"OfferPrice", nil];
    [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:msg];
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
    ctr.totalPrice=info.NAmount;
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
    Negotiate_Type negotiate_Type=KNegotiate_Seller;
    Buy_Result result=KAgree;
    ExchangeInfo *info=_list[index.row];
    if ([info.TranNo integerValue]) {//有交易码就传交易码
        tranNo=info.TranNo;
    }
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:info.BuyerID,@"toUser",info.Bonsai.ID,@"BID",[DataSource sharedDataSource].userInfo.ID,@"fromUser",[NSNumber numberWithInt:result],@"Result", [NSNumber numberWithInt:negotiate_Type],@"Status",info.Bonsai.IsMarksPrice,@"IsMark",tranNo,@"tranNo",info.NAmount,@"OfferPrice", nil];
    [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:msg];
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
    Negotiate_Type negotiate_Type=KOffer_Price_Seller;
    
    Buy_Result result=Kgiveup;
    ExchangeInfo *info=_list[index.row];
    if ([info.TranNo integerValue]) {//有交易码就传交易码
        tranNo=info.TranNo;
    }
    if([info.Phase integerValue]==4&&[info.Bonsai.IsMarksPrice boolValue]){//买家放弃
        negotiate_Type=KNegotiate_buyer;
         msg=@"您已放弃此交易";
    }
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:info.BuyerID,@"toUser",info.Bonsai.ID,@"BID",[DataSource sharedDataSource].userInfo.ID,@"fromUser",[NSNumber numberWithInt:result],@"Result", [NSNumber numberWithInt:negotiate_Type],@"Status",info.Bonsai.IsMarksPrice,@"IsMark",tranNo,@"tranNo",info.Bonsai.Price,@"OfferPrice", nil];
    [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:msg];
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
    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
    [tabBar xmTabBarHidden:YES animated:NO];
    SellerOrderDetailViewController *ctr=[[SellerOrderDetailViewController alloc] init];
    ctr.info=info;
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
