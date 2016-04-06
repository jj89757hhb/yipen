//
//  SameCityViewController.m
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "SameCityViewController.h"
#import "ActivityTableViewController.h"
#import "StoreTableViewController.h"
#import "YouYuanTableViewController.h"
#import "XiangYuanTableViewController.h"
#import "TuoGuanTableViewController.h"
#import "CityInfo.h"
#import "SendActiviyViewController.h"
#import "SendStoreViewController.h"
#import "SendPanYuanViewController.h"
#import "SendYouYuanViewController.h"
#import "SendXiangYuanViewController.h"
#import "SendTuoGuanViewController.h"
@interface SameCityViewController ()<DLSlideTabbarDelegate,DLTabedSlideViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *cityList;
@property(nonatomic,assign)SameCitySendType sendType;

@end

@implementation SameCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initToolBar];
     selectbtn=[[UIButton alloc] initWithFrame:CGRectMake(0, 2, 60, 40)];
    [selectbtn setTitle:@"城市" forState:UIControlStateNormal];
    [selectbtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    self.navigationItem.titleView=selectbtn;
    [selectbtn addTarget:self action:@selector(selectCityAction) forControlEvents:UIControlEventTouchUpInside];
    [self queryCityData];
//    WS(weakSelf)
//    [self setNavigationBarRightItem:@"发布" itemImg:nil withBlock:^(id sender) {
//        [weakSelf sendAction];
//    }];
    sendBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-120, 65, 65)];
    [sendBtn setImage:[UIImage imageNamed:@"同城发布"] forState:UIControlStateNormal];
    [self.view addSubview:sendBtn];
    [sendBtn addTarget:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hideTabBar:NO animated:NO];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    [self hideTabBar:NO animated:NO];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self hideTabBar:YES animated:NO];
    
}

-(void)sendAction{
//    SendSameCityViewController *ctr=[[SendSameCityViewController alloc] initWithNibName:nil bundle:nil];
//    ctr.sendType=_sendType;
    if (self.sendType==KSend_Activity) {
        SendActiviyViewController *ctr=[[SendActiviyViewController alloc] init];
        [self hideTabBar:YES animated:NO];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if (self.sendType==KSend_Store){//店家
        SendStoreViewController *ctr=[[SendStoreViewController alloc] init];
        ctr.title=@"发布店家";
        [self hideTabBar:YES animated:NO];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if (self.sendType==KSend_YouYuan){//友园
        SendYouYuanViewController *ctr=[[SendYouYuanViewController alloc] init];
         ctr.title=@"发布友园";
        [self hideTabBar:YES animated:NO];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if (self.sendType==KSend_XiangYuan){//享园
        SendXiangYuanViewController *ctr=[[SendXiangYuanViewController alloc] init];
         ctr.title=@"发布享园";
        [self hideTabBar:YES animated:NO];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if (self.sendType==KSend_TuoGuan){//托管
        SendTuoGuanViewController *ctr=[[SendTuoGuanViewController alloc] init];
        [self hideTabBar:YES animated:NO];
         ctr.title=@"发布托管";
        [self.navigationController pushViewController:ctr animated:YES];
    }
    
   
}

//选择城市
-(void)selectCityAction{
    if (!cityTable) {
        float offX=50;
        float width=200;
        cityTable=[[UITableView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-width)/2,64 , width, 300) style:UITableViewStyleGrouped];
        cityTable.delegate=self;
        cityTable.dataSource=self;
        [self.view addSubview:cityTable];
        cityTable.layer.borderWidth=1;
        cityTable.layer.borderColor=[UIColor lightGrayColor].CGColor;
        
    }
    else{
        if (cityTable.isHidden) {
            [cityTable setHidden:NO];
        }
        else{
            [cityTable setHidden:YES];
        }
        
    }
    [self queryCityData];
}

-(void)queryCityData{
    if (_cityList) {
        return;
    }
    NSString *param2=[NSString stringWithFormat:@"UID=%@",[DataSource sharedDataSource].userInfo.ID];
    
    [HttpConnection getDownCityWithParameter:param2 WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([response[@"ok"] isEqualToString:@"TRUE"]) {
                NSArray *records=response[@"records"];
                NSMutableArray *citys=[[NSMutableArray alloc] init];
                for (NSDictionary *dic in records) {
                    /*
                     [{"ID":"2","CityName":"杭州"},{"ID":"3","CityName":"绍兴"},{"ID":"6","CityName":"常州"},{"ID":"7","CityName":"苏州"},{"ID":"9","CityName":"上海"}]}
                     */
                    CityInfo *city=[[CityInfo alloc] initWithKVCDictionary:dic];
                    [citys addObject:city];
                    self.cityList=citys;
                    [cityTable reloadData];
                }
            }
            else{
                
                [SVProgressHUD showInfoWithStatus:response[@"reason"]];
            }
        }
        else{
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }
        
    }];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _cityList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cityTable.frame.size.width, 30)];
    view.backgroundColor=[UIColor lightGrayColor];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, cityTable.frame.size.width, 20)];
    label.text=@"热门城市";
    label.textAlignment=NSTextAlignmentCenter;
    [view addSubview:label];
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=[UIColor darkGrayColor];
    return view;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, cityTable.frame.size.width, 44)];
    view.backgroundColor=WHITEColor;
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 12, cityTable.frame.size.width, 20)];
    label.text=@"陆续上线中...";
    label.textAlignment=NSTextAlignmentCenter;
    [view addSubview:label];
    label.font=[UIFont systemFontOfSize:13];
    label.textColor=[UIColor darkGrayColor];
    return view;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify=@"identify";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        UILabel *cityL=[[UILabel alloc] initWithFrame:CGRectMake(0, 12, tableView.frame.size.width, 20)];
        [cell.contentView addSubview:cityL];
         cityL.textColor=[UIColor darkGrayColor];
        cityL.tag=100;
        cityL.textAlignment=NSTextAlignmentCenter;
    }
    UILabel *label=[cell.contentView viewWithTag:100];
    CityInfo *info=_cityList[indexPath.row];
    label.text=info.CityName;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
     CityInfo *info=_cityList[indexPath.row];
    [selectbtn setTitle:info.CityName forState:UIControlStateNormal];
    [cityTable setHidden:YES];
}

-(void)initToolBar{
    tabedSlideView=[[DLTabedSlideView alloc] init];
    [self.view addSubview:tabedSlideView];
    tabedSlideView.backgroundColor=WHITEColor;
    
    [tabedSlideView setFrame:CGRectMake(0, 0+44+20, SCREEN_WIDTH, SCREEN_HEIGHT-64+20)];
    tabedSlideView.baseViewController = self;
    tabedSlideView.delegate=self;
    tabedSlideView.tabItemNormalColor = MIDDLEBLACK;
//    tabedSlideView.tabItemSelectedColor = [UIColor orangeColor];
    tabedSlideView.tabbarTrackColor = BLUECOLOR;
//    tabedSlideView.tabbarBackgroundImage = [UIImage imageNamed:@"tabbarBk"];
    tabedSlideView.tabbarBottomSpacing = -1;
    
    DLTabedbarItem *item1 = [DLTabedbarItem itemWithTitle:@"活动" image:nil selectedImage:nil];
    DLTabedbarItem *item2 = [DLTabedbarItem itemWithTitle:@"店家" image:nil selectedImage:nil];
       DLTabedbarItem *item3 = [DLTabedbarItem itemWithTitle:@"友园" image:nil selectedImage:nil];
       DLTabedbarItem *item4 = [DLTabedbarItem itemWithTitle:@"享园" image:nil selectedImage:nil];
       DLTabedbarItem *item5 = [DLTabedbarItem itemWithTitle:@"托管" image:nil selectedImage:nil];
    tabedSlideView.tabbarItems = @[item1, item2,item3,item4,item5];
    [tabedSlideView buildTabbar];
    tabedSlideView.selectedIndex = 0;
}

-(NSInteger)numberOfTabsInDLTabedSlideView:(DLTabedSlideView *)sender{
    return 5;
}

-(UIViewController*)DLTabedSlideView:(DLTabedSlideView *)sender controllerAt:(NSInteger)index{
    switch (index) {
        case 0:
        {
            ActivityTableViewController *ctr=[[ActivityTableViewController alloc] init];
            return ctr;
        }
        case 1:
        {
            StoreTableViewController *ctr=[[StoreTableViewController alloc] init];
            return ctr;
        }
        case 2:
        {
            YouYuanTableViewController *ctr=[[YouYuanTableViewController alloc] init];
            return ctr;
        }
        case 3:
        {
            XiangYuanTableViewController *ctr=[[XiangYuanTableViewController alloc] init];
            return ctr;
        }
        case 4:
        {
            TuoGuanTableViewController *ctr=[[TuoGuanTableViewController alloc] init];
            return ctr;
        }
        default:
            return nil;
    }

}

- (void)DLTabedSlideView:(DLTabedSlideView *)sender didSelectedAt:(NSInteger)index{
    self.sendType=index+1;
    
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
