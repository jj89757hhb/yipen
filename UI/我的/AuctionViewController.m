//
//  AuctionViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "AuctionViewController.h"
#import "Auction_BuyViewController.h"
#import "Auction_SaleViewController.h"
@interface AuctionViewController ()<UITableViewDataSource,UITableViewDelegate,DLSlideTabbarDelegate,DLTabedSlideViewDelegate>

@end

@implementation AuctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"竞拍";
    [self initToolBar];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)initToolBar{
    tabedSlideView=[[DLTabedSlideView alloc] init];
    [self.view addSubview:tabedSlideView];
    tabedSlideView.backgroundColor=WHITEColor;
    
    [tabedSlideView setFrame:CGRectMake(0, 0+44+20, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tabedSlideView.baseViewController = self;
    tabedSlideView.delegate=self;
    tabedSlideView.tabItemNormalColor = MIDDLEBLACK;
    //    tabedSlideView.tabItemSelectedColor = [UIColor orangeColor];
    tabedSlideView.tabbarTrackColor = BLUECOLOR;
    //    tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
    tabedSlideView.tabbarBottomSpacing = -1;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"竞卖" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"竞买" image:nil selectedImage:nil];
    tabedSlideView.tabbarItems = @[item1, item2];
    [tabedSlideView buildTabbar];
    tabedSlideView.selectedIndex = 0;
}


-(NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 2;
}

-(UIViewController*)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            Auction_SaleViewController *ctr=[[Auction_SaleViewController alloc] initWithNibName:nil bundle:nil];
            return ctr;
        }
        case 1:
        {
            Auction_BuyViewController *ctr=[[Auction_BuyViewController alloc] initWithNibName:nil bundle:nil];
            return ctr;
        }
        default:
            return nil;
    }
    
}

- (void)DLTabedSlideView:(DLTabedSlideView *)sender didSelectedAt:(NSInteger)index{
    //    self.sendType=index+1;
    
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
