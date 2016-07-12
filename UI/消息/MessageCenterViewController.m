//
//  MessageCenterViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageCommentViewController.h"
#import "ChatListViewController.h"
#import "MessageExchangeViewController.h"
@interface MessageCenterViewController ()<DLTabedSlideViewDelegate>

@end

@implementation MessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=WHITEColor;
    [self initToolBar];
    self.title=@"消息";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [super hideTabBar:NO animated:NO];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [super hideTabBar:NO animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [super hideTabBar:YES animated:NO];
}
-(void)initToolBar{
    tabedSlideView=[[DLTabedSlideView alloc] init];
    [self.view addSubview:tabedSlideView];
    tabedSlideView.backgroundColor=WHITEColor;
    
    [tabedSlideView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    tabedSlideView.baseViewController = self;
    tabedSlideView.delegate=self;
    tabedSlideView.tabItemNormalColor = MIDDLEBLACK;
    //    tabedSlideView.tabItemSelectedColor = [UIColor orangeColor];
    tabedSlideView.tabbarTrackColor = BLUECOLOR;
    //    tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
    tabedSlideView.tabbarBottomSpacing = -1;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"评论" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"私信" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"交易" image:nil selectedImage:nil];
    tabedSlideView.tabbarItems = @[item1, item2,item3];
    [tabedSlideView buildTabbar];
    tabedSlideView.selectedIndex = 0;
}


-(NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 3;
}

-(UIViewController*)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            MessageCommentViewController *ctr=[[MessageCommentViewController alloc] init];
            return ctr;
        }
        case 1:
        {
            ChatListViewController *ctr=[[ChatListViewController alloc] init];
            return ctr;
        }
        case 2:
        {
            MessageExchangeViewController *ctr=[[MessageExchangeViewController alloc] init];
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
