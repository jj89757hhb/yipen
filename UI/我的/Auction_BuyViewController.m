//
//  Auction_BuyViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "Auction_BuyViewController.h"

@interface Auction_BuyViewController ()

@end

@implementation Auction_BuyViewController
static NSInteger pageSize=10;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
}

-(void)requestData{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID", [NSNumber numberWithInteger:pageSize],@"PageSize",[NSNumber numberWithInteger:currentPage],@"Page",nil];
    [HttpConnection GetMyPurchase:dic WithBlock:^(id response, NSError *error) {
        
    }];
    
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
