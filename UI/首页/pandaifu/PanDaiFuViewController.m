//
//  PanDaiFuViewController.m
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "PanDaiFuViewController.h"
#import "PJPenDaiFuTableViewCell.h"
#import "CommentInfo.h"
@interface PanDaiFuViewController ()
@property (nonatomic, strong)SlideSwitchView *slideSwitchView;
@property (nonatomic, strong)AIMultiDelegate *multiDelegate;
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation PanDaiFuViewController
static NSString *identify=@"identify";
static NSInteger pageNum=10;
- (instancetype)initSlideSwitchView:(SlideSwitchView *)slideSwitchView{
    self = [super init];
    if (self) {
        _slideSwitchView = slideSwitchView;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    self.list=[[NSMutableArray alloc] init];
    // Do any additional setup after loading the view.
//    if (_slideSwitchView) {
//        _multiDelegate = [[AIMultiDelegate alloc] init];
//        [_multiDelegate addDelegate:self];
//        [_multiDelegate addDelegate:_slideSwitchView];
//        self.tableView.delegate = (id)_multiDelegate;
//    }
    [self.tableView registerClass:[PJPenDaiFuTableViewCell class] forCellReuseIdentifier:identify];
    WS(weakSelf)
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf requestData];
    }];
    [self requestData];
}


-(void)requestData{
    currentPage=1;
    //Type=3 淘一盆
    //    NSString *param=[NSString stringWithFormat:@"UID=%@&Page=%ld&PageSize=%ld",[DataSource sharedDataSource].userInfo.ID,currentPage,pageNum];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",[NSNumber numberWithInteger:currentPage],@"Page",[NSNumber numberWithInteger:pageNum],@"PageSize",@"4",@"Type", nil];
    [HttpConnection GetBonsaiList:dic WithBlock:^(id response, NSError *error) {
        [self.tableView.header endRefreshing];
        if (!error) {
            if (![response objectForKey:KErrorMsg]) {
                self.list=response[KDataList];
                [self.tableView reloadData];
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



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PenJinInfo *info=_list[indexPath.row];
    float comment_Height=0;
    if (info.Comment.count) {//计算评论高度
        for (int i=0; i<info.Comment.count; i++) {
            CommentInfo *comment=info.Comment[i];
            comment_Height+=  [CommonFun sizeWithString:comment.Message font:[UIFont systemFontOfSize:comment_FontSize] size:CGSizeMake(SCREEN_WIDTH-15+10*2, MAXFLOAT)].height;
        }
        
    }
    return 400+50+BottomToolView_Height+comment_Height;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PJPenDaiFuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    return cell;
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
