//
//  ExchangeViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/15.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ExchangeViewController.h"
#import "MyBuyTableViewController.h"
#import "MySellTableViewController.h"
@interface ExchangeViewController ()<DLTabedSlideViewDelegate,DLSlideTabbarDelegate>

@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initToolBar];
    self.title=@"交易";
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
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"我卖的" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"我买的" image:nil selectedImage:nil];

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
            MySellTableViewController *ctr=[[MySellTableViewController alloc] init];
            return ctr;
        }
        case 1:
        {
            MyBuyTableViewController *ctr=[[MyBuyTableViewController alloc] init];
            return ctr;
        }
               default:
            return nil;
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
