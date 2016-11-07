//
//  ExpertViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/8/2.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ExpertViewController.h"
#import "ExpertTableViewCell.h"
#import "YPUserInfo.h"
@interface ExpertViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *myTable;
}
@property(nonatomic,strong)NSMutableArray *list;
@property(nonatomic,strong)NSString *selectUserId;
@property(nonatomic,strong)NSMutableArray *selectUserIds;
@end

@implementation ExpertViewController
static NSString *identify=@"identify";
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    self.title=@"咨询专家";
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishAction)];
    [self queryDataIsRefresh:YES];
    self.selectUserIds=[[NSMutableArray alloc] init];
}

-(void)queryDataIsRefresh:(BOOL)isRefresh{
            NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"Uid",[NSNumber numberWithInteger:1],@"Page",[NSNumber numberWithInteger:10],@"PageSize", nil];
            [HttpConnection GetExperts:dic WithBlock:^(id response, NSError *error) {
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


-(void)initTableView{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.dataSource=self;
    myTable.delegate=self;
    [myTable registerNib:[UINib nibWithNibName:@"ExpertTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    WS(weakSelf)
    [myTable addLegendHeaderWithRefreshingBlock:^{
        [weakSelf queryDataIsRefresh:YES];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
//    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ExpertTableViewCell *cell=[myTable dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    cell.index=indexPath;
    [cell setInfo:_list[indexPath.row]];
    WS(weakSelf)
    [cell setAttentionBlock:^(id sender){
        [weakSelf selectExpert:sender];
    }
    ];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [myTable deselectRowAtIndexPath:indexPath animated:NO];
}
-(void)finishAction{
    if ([_delegate respondsToSelector:@selector(selectExpert:)]) {
        [_delegate selectExpert:_selectUserIds];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)selectExpert:(NSIndexPath*)index{
    YPUserInfo *info=_list[index.row];
    info.isSelect=!info.isSelect;
    if (info.isSelect) {//选中
//        if (!_selectUserId) {
//             self.selectUserId=info.ID;
//        }
//        else{
//            if ([self.selectUserId rangeOfString:info.ID].length==0) {
//                self.selectUserId=[_selectUserId stringByAppendingString:[NSString stringWithFormat:@",%@",info.ID]];
//                NSLog(@"selectUserId2:%@",_selectUserId);
//            }
//           
//        }
        BOOL isSame=NO;
        for (NSString *temp in _selectUserIds) {
            if ([temp isEqualToString:info.ID]) {
                isSame=YES;
                break;
            }
        }
        if (!isSame) {
                  [self.selectUserIds addObject:info.ID];
        }

       
    }
    else{
        [self.selectUserIds removeObject:info.ID];
//        NSRange range = [_selectUserId rangeOfString:info.ID];
//        if (range.length) {
//           self.selectUserId=  [_selectUserId substringWithRange:range];
//        }
        NSLog(@"_selectUserId1:%@",_selectUserId);
//        NSMutableString *str=[[NSMutableString alloc] initWithString:@"123"];
//        [str ]
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
