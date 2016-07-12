//
//  AddressManagerViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "AddressManagerViewController.h"
#import "AddressTableViewCell.h"
#import "AddAddressViewController.h"
#import "AddressInfo.h"
@interface AddressManagerViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation AddressManagerViewController
static NSString *identify=@"identify";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.list=[[NSMutableArray alloc] init];
    self.title=@"收货地址";
    [self initTable];
    bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50-64, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor=WHITEColor;
    addBtn=[[UIButton alloc] initWithFrame:CGRectMake(15, 5, SCREEN_WIDTH-15*2, 40)];
    [addBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    [addBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
    [addBtn setBackgroundColor:[UIColor redColor]];
    addBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    addBtn.layer.cornerRadius=5;
    addBtn.clipsToBounds=YES;
    [bottomView addSubview:addBtn];
    [addBtn addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bottomView];
    WS(weakSelf)
    if (self.enterType==0) {
        [self setNavigationBarRightItem:@"编辑" itemImg:nil withBlock:^(id sender) {
            [weakSelf editAction];
        }];
    }
    else{
        [self setNavigationBarRightItem:@"管理" itemImg:nil withBlock:^(id sender) {
            [weakSelf manageAction];
        }];
        [bottomView setHidden:YES];
    }
   
    [self queryAddress];
    [NotificationCenter addObserver:self selector:@selector(queryAddress) name:@"queryAddress" object:nil];
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    
    
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

//查询
-(void)queryAddress{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    [HttpConnection GetAddressList:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [self.list removeAllObjects];
                NSArray *records=response[@"records"];
                for (NSDictionary *dic in records) {
                    AddressInfo *info=[[AddressInfo alloc] initWithKVCDictionary:dic];
                    [self.list addObject:info];
                }
           
                [myTable reloadData];
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
       
        
    }];
}

-(void)editAction{
    WS(weakSelf)
    if (myTable.editing) {
          myTable.editing=NO;
        [self setNavigationBarRightItem:@"编辑" itemImg:nil withBlock:^(id sender) {
            [weakSelf editAction];
        }];
    }
    else{
           myTable.editing=YES;
        [self setNavigationBarRightItem:@"完成" itemImg:nil withBlock:^(id sender) {
            [weakSelf editAction];
        }];
    }
 
}

-(void)addAddress:(UIButton*)sender{
    AddAddressViewController *ctr=[[AddAddressViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:ctr animated:YES];
}

//管理
-(void)manageAction{
//    AddAddressViewController *ctr=[[AddAddressViewController alloc] initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:ctr animated:YES];
    AddressManagerViewController *ctr=[[AddressManagerViewController alloc] init];
     [self.navigationController pushViewController:ctr animated:YES];
}


-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    [myTable registerNib:[UINib nibWithNibName:@"AddressTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
    return _list.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
    AddressInfo *info=_list[indexPath.section];
    [cell setInfo:info];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressInfo *info=_list[indexPath.section];
    if (self.enterType==0) {
        AddressInfo *info2=_list[0];
        AddAddressViewController *ctr=[[AddAddressViewController alloc] initWithNibName:nil bundle:nil];
        ctr.info=info;
        ctr.OAID=info2.ID;
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else{//返回到订单页面
        [NotificationCenter postNotificationName:@"SelectAddress" object:info];
        [self backAction];
    }
  
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [SVProgressHUD show];
     AddressInfo *info=_list[indexPath.section];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:info.ID,@"AID",[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    [HttpConnection DelAddress:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"删除成功"];
                [_list removeObjectAtIndex:indexPath.row];
                [myTable reloadData];
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
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
