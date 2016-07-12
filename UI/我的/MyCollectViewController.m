//
//  MyCollectViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MyCollectViewController.h"
#import "SameCitySendTableViewCell.h"
#import "DLTabedSlideView.h"
#import "CollectionDianJiaViewController.h"
#import "CollectionTuoGuanViewController.h"
#import "CollectionYouYuanViewController.h"
#import "CollectionActivityViewController.h"
#import "CollectionShangPenViewController.h"
#import "CollectionXiangYuanViewController.h"
@interface MyCollectViewController ()<UITableViewDelegate,UITableViewDataSource,DLSlideTabbarDelegate,DLTabedSlideViewDelegate>{
    DLTabedSlideView *tabedSlideView;
}
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation MyCollectViewController
static NSString *identify=@"identify";
static NSInteger pageSie=10;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收藏";
//    [self initTableView];
    currentPage=1;
    [self requestData];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    [self initToolBar];
    
}


-(void)initTableView{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"SameCitySendTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
}


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
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"上盆" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"活动" image:nil selectedImage:nil];
    DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"店家" image:nil selectedImage:nil];
    DLTabedbarItem *item4 = [DLTabedbarItem itemWithTitle:@"友园" image:nil selectedImage:nil];
    DLTabedbarItem *item5 = [DLTabedbarItem itemWithTitle:@"享园" image:nil selectedImage:nil];
    DLTabedbarItem *item6 = [DLTabedbarItem itemWithTitle:@"托管" image:nil selectedImage:nil];
    
    tabedSlideView.tabbarItems = @[item1, item2,item3,item4,item5,item6];
    [tabedSlideView buildTabbar];
    tabedSlideView.selectedIndex = 0;
}


- (NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 6;
}

- (UIViewController *)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            CollectionShangPenViewController *ctr=[[CollectionShangPenViewController alloc] init];
            return ctr;
        }
        case 1:
        {
            CollectionActivityViewController  *ctrl=[[CollectionActivityViewController alloc] init];
            return ctrl;
        }
        case 2:
        {
            CollectionDianJiaViewController  *ctrl=[[CollectionDianJiaViewController alloc] init];
            return ctrl;
            
        }
        case 3:
        {
            
            CollectionYouYuanViewController   *ctrl=[[CollectionYouYuanViewController alloc] init];
            return ctrl;
        }
        case 4:
        {
            CollectionXiangYuanViewController  *ctrl=[[CollectionXiangYuanViewController alloc] init];
            return ctrl;
        }
        case 5:
        {
            CollectionTuoGuanViewController  *ctrl=[[CollectionTuoGuanViewController alloc] init];
            return ctrl;
        }
        default:
            return nil;
    }
    
}




-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return _list.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SameCitySendTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    return cell;
}

-(void)requestData{
    Collect_Type collectType=KCollect_Penjin;
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:currentPage],@"Page",[NSNumber numberWithInteger:pageSie],@"PageSize" ,[NSNumber numberWithInteger:collectType],@"Type",nil];
    
    [HttpConnection GetMyCollect:dic WithBlock:^(id response, NSError *error) {
        
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
