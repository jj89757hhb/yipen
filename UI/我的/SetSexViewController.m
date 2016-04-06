//
//  SetSexViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/13.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SetSexViewController.h"

@interface SetSexViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SetSexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择性别";
    [self initTableView];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)initTableView{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    //    [myTable registerNib:[UINib nibWithNibName:@"MyHeaderTableViewCell" bundle:nil] forCellReuseIdentifier:headerCell];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify=@"identify";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
  
    if (indexPath.row==0) {
        cell.textLabel.text=@"男";
        if ([[DataSource sharedDataSource].userInfo.Sex isEqualToString:@"男"]) {
              cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
    }
    else if(indexPath.row==1){
        cell.textLabel.text=@"女";
        if ([[DataSource sharedDataSource].userInfo.Sex  isEqualToString:@"女"]) {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    cell.selected=YES;
    if (indexPath.row==0) {
        [self modifySex:@"男"];
    }
    else{
        [self modifySex:@"女"];
    }
//    [self.navigationController popViewControllerAnimated:YES];
}

-(void)modifySex:(NSString*)sex{
    [SVProgressHUD show];
//    NSString *nickName=[NSString stringWithFormat:@"Sex=%@&UID=%@",sex,[DataSource sharedDataSource].userInfo.ID];
     NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:sex,@"Sex",[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    
    [HttpConnection editUserInfoWithParameter:dic pics:nil WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([response[@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:@"修改成功"];
                [DataSource sharedDataSource].userInfo.Sex=sex;
               [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                [SVProgressHUD showErrorWithStatus:response[@"Reason"]];
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
