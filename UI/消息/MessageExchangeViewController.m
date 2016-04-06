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
@interface MessageExchangeViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MessageExchangeViewController
static NSString *identify=@"identify";
static NSString *identify2=@"identify2";
- (void)viewDidLoad {
    [super viewDidLoad];
     [self initTable];
}

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64-15) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    [myTable registerNib:[UINib nibWithNibName:@"MessageExchangeTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    [myTable registerNib:[UINib nibWithNibName:@"MessageExchange2TableViewCell" bundle:nil] forCellReuseIdentifier:identify2];
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
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row%2==0) {
        MessageExchangeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.replyPriceBtn addTarget:self action:@selector(showReplyPrice) forControlEvents:UIControlEventTouchUpInside];
    
//        [cell setReplyPriceBlock:^(id sender){
////            OfferPriceView *view=[[OfferPriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        
//          
//        }];
        return cell;
    }
    else{
        MessageExchange2TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify2 forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)showReplyPrice{
    OfferPriceView *view=[[OfferPriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [view initViewWithPrice:@"100"];
    view.backgroundColor=[BLACKCOLOR colorWithAlphaComponent:0.7];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
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
