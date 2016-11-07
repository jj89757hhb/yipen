//
//  HomeViewController.m
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "HomeViewController.h"
#import "SlideSwitchView.h"
#import "FenXiangViewController.h"
#import "GuanZhuViewController.h"
#import "PanDaiFuViewController.h"
#import "PanYuanViewController.h"
#import "TaoYiPanViewController.h"
#import "SearchTagsViewController.h"
#import "SelectTagViewController.h"
#import "TreeSort.h"
@interface HomeViewController ()<DLSlideTabbarDelegate,DLTabedSlideViewDelegate>{
    NSInteger selectIndex;
}
@property(nonatomic,strong)SlideSwitchView *switchView;
@property(nonatomic,strong)FenXiangViewController *fenXiangCtr;
@property(nonatomic,strong)GuanZhuViewController *guanZhuCtr;
@property(nonatomic,strong)PanDaiFuViewController *panDaiFuCtr;
@property(nonatomic,strong)PanYuanViewController *panYuanCtr;
@property(nonatomic,strong)TaoYiPanViewController *taoYiPanCtr;
@property(nonatomic,strong)NSMutableDictionary *sortDic;
//@property(nonatomic,strong)FenXiangViewController *ctr;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf)
    [self setNavigationBarRightItem:nil itemImg:[UIImage imageNamed:@"搜索"] withBlock:^(id sender) {
        NSLog(@"搜索");
        [weakSelf goSearch];
    }];
//    [self initViewCtr];
    [self initToolBar];
    UIImageView *logoIV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_home"]];
    [logoIV setFrame:CGRectMake(0, 0, 112/2, 83/2.f)];//112 × 83
    self.navigationItem.titleView=logoIV;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_line"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@"nav_line"];
        [super hideTabBar:NO animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage imageNamed:@""];
}
//-(void)initViewCtr{
//    self.switchView=[[SlideSwitchView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
//    self.switchView.slideSwitchViewDelegate=self;
//    self.switchView.topScrollView.backgroundColor = [UIColor whiteColor];
//    self.switchView.tabItemNormalColor = BLACKCOLOR;
//    self.switchView.tabItemSelectedColor = BLACKCOLOR;
////    self.switchView.shadowImage = [UIImage imageNamed:@"TabSelectedBackground"];
//    [self.view addSubview:_switchView];
//    self.fenXiangCtr=[[FenXiangViewController alloc] initSlideSwitchView:self.switchView];
//    self.fenXiangCtr.title=@"分享";
//    self.guanZhuCtr=[[GuanZhuViewController alloc] initSlideSwitchView:self.switchView];
//    self.guanZhuCtr.title=@"关注";
//    self.panDaiFuCtr=[[PanDaiFuViewController alloc] initSlideSwitchView:self.switchView];
//    self.panDaiFuCtr.title=@"盘大夫";
//    self.panYuanCtr=[[PanYuanViewController alloc] initSlideSwitchView:self.switchView];
//    self.panYuanCtr.title=@"盘缘";
//    self.taoYiPanCtr=[[TaoYiPanViewController alloc] initSlideSwitchView:self.switchView];
//    self.taoYiPanCtr.title=@"淘一盘";
//    [_switchView buildUI];
//    
//    
//}


-(void)initToolBar{
    tabedSlideView=[[DLTabedSlideView alloc] init];
    [self.view addSubview:tabedSlideView];
    tabedSlideView.backgroundColor=WHITEColor;
    
    [tabedSlideView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49)];
    tabedSlideView.baseViewController = self;
    tabedSlideView.delegate=self;
    tabedSlideView.tabItemNormalColor = [UIColor lightGrayColor];
    tabedSlideView.tabItemSelectedColor = [UIColor lightGrayColor];//文字选中颜色
    tabedSlideView.tabbarTrackColor = BLUECOLOR;
//    tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
//    tabedSlideView.tabbarBottomSpacing = -1;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"分享" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"关注" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"淘一盆" image:nil selectedImage:nil];
    DLTabedbarItem *item4 = [DLTabedbarItem itemWithTitle:@"盆大夫" image:nil selectedImage:nil];
    DLTabedbarItem *item5 = [DLTabedbarItem itemWithTitle:@"盆缘" image:nil selectedImage:nil];

    tabedSlideView.tabbarItems = @[item1, item2,item3,item4,item5];
    [tabedSlideView buildTabbar];
    tabedSlideView.selectedIndex = 0;
}

- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 5;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    selectIndex=index;
    switch (index) {
        case 0:
        {
            self.fenXiangCtr =[[FenXiangViewController alloc] init];
            return _fenXiangCtr;
        }
        case 1:
        {
            self.guanZhuCtr =[[GuanZhuViewController alloc] init];
            return _guanZhuCtr;
        }
        case 2:
        {
            self.taoYiPanCtr =[[TaoYiPanViewController alloc] init];
            return _taoYiPanCtr;
           
        }
        case 3:
        {
         
            self.panDaiFuCtr=[[PanDaiFuViewController alloc] init];
            return _panDaiFuCtr;
        }
        case 4:
        {
            self.panYuanCtr =[[PanYuanViewController alloc] init];
            return _panYuanCtr;
        }
        default:
            return nil;
    }
    
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//
//}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [super hideTabBar:NO animated:NO];
}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
//    [tabBar xmTabBarHidden:YES animated:NO];
//}



//- (NSUInteger)numberOfTab:(SlideSwitchView *)view
//{
//    return 5;
//}
//
//- (UIViewController *)slideSwitchView:(SlideSwitchView *)view viewOfTab:(NSUInteger)number
//{
//    if (number == 0) {
//        return _fenXiangCtr;
//    }
//    else if (number == 1) {
//        return _guanZhuCtr;
//    }
//    else if (number == 2) {
//        return _panDaiFuCtr;
//    }
//    else if (number == 3) {
//        return _panYuanCtr;
//    }
//    else if (number==4){
//        return _taoYiPanCtr;
//    }
//    else {
//        return nil;
//    }
//}

- (void)slideSwitchViewSubVCDragUp:(SlideSwitchView *)view
{
}

- (void)slideSwitchViewSubVCDragDown:(SlideSwitchView *)view
{
}

- (void)slideSwitchView:(SlideSwitchView *)view didselectTab:(NSUInteger)number{
    
}

//搜索标签
-(void)goSearch{
//    SearchTagsViewController *searchCtr=[[SearchTagsViewController alloc] init];
//    searchCtr.hidesBottomBarWhenPushed=YES;
//    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
//    [tabBar xmTabBarHidden:YES animated:NO];
    WS(weakSelf)
    [super hideTabBar:YES animated:NO];
    SelectTagViewController *ctr=[[SelectTagViewController alloc] init];
    ctr.enterType=0;
    [ctr setSelectBlock:^(id sender){
        self.sortDic=sender;
        for (NSString *key in _sortDic.allKeys) {//值
//            NSLog(@"标签ket:%@",key);
            id temp=[_sortDic objectForKey:key];
            if (![temp isMemberOfClass:[TreeSort class]]) {//过滤掉为空的对象
                NSLog(@"空对象啊");
                [_sortDic removeObjectForKey:key];
            }
        }
        if (selectIndex==0) {
            _fenXiangCtr.selectSort=_sortDic;
            [_fenXiangCtr requestDataIsRefresh:YES];
        }
        else if (selectIndex==1) {
            _guanZhuCtr.selectSort=_sortDic;
            [_guanZhuCtr requestDataIsRefresh:YES];
        }
        else if (selectIndex==2) {
            _taoYiPanCtr.selectSort=_sortDic;
            [_taoYiPanCtr requestDataIsRefresh:YES];
        }
        else if (selectIndex==3) {
            _panDaiFuCtr.selectSort=_sortDic;
            [_panDaiFuCtr requestDataIsRefresh:YES];
        }
   
//        NSIndexSet *sections=[NSIndexSet  indexSetWithIndex:2];
//        [myTable reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
    }];
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
