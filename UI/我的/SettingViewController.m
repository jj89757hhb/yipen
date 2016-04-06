//
//  SettingViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/31.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SettingViewController.h"
#import "ModifyPswViewController.h"
#import "AboutViewController.h"
#import "MyWebViewViewController.h"
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else if(section==1){
        return 4;
    }
    return 1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 44;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        static NSString *identify=@"identify1";
        UIFont *font=[UIFont systemFontOfSize:16];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            cell.textLabel.font=font;
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                    cell.textLabel.text=@"清除缓存";
            UILabel *sizeL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-180, 11, 150, 20)];
            sizeL.textAlignment=NSTextAlignmentRight;
            float tmpSize = [[SDImageCache sharedImageCache] getSize];
            
            NSString *clearCacheName = tmpSize >= (1024*1024) ? [NSString stringWithFormat:@"文件大小: %.2fM",tmpSize/1024/1024.f] : [NSString stringWithFormat:@"文件大小: %.2fK",tmpSize/1024];
            sizeL.text=clearCacheName;
            sizeL.font=[UIFont systemFontOfSize:14];
            sizeL.textColor=[UIColor grayColor];
            [cell.contentView addSubview:sizeL];
//            cell.textLabel.textColor=MIDDLEBLACK;
        }
        return cell;
    }
    else{
        static NSString *identify=@"identify2";
        UIFont *font=[UIFont systemFontOfSize:16];
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
            cell.textLabel.font=font;
        }
        if(indexPath.section==1){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row==0) {
                cell.textLabel.text=@"关于我们";
                
            }
            else if(indexPath.row==1){
                cell.textLabel.text=@"给我们评价";
            }
            else if(indexPath.row==2){
                cell.textLabel.text=@"服务协议";
            }
            else if(indexPath.row==3){
                cell.textLabel.text=@"用户说明";
            }
        }
        else if(indexPath.section==2){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row==0) {
                cell.textLabel.text=@"修改密码";
            }
    
        }
        else if (indexPath.section==3){
            UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
            [btn setTitle:@"登出" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(loginOutAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:btn];
        }
        return cell;
    }
    
}
//退出
-(void)loginOutAction{
    [UIAlertView bk_showAlertViewWithTitle:nil message:@"确定退出登录?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"退出"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex==1) {
            [self.navigationController popViewControllerAnimated:NO];
            [NotificationCenter postNotificationName:KloginOutNotify object:nil];
        }
        
    }];
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [myTable  deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            AboutViewController *about=[[AboutViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:about animated:YES];
        }
        else if(indexPath.row==2){//服务协议
            MyWebViewViewController *ctr=[[MyWebViewViewController alloc] init];
            ctr.urlStr=user_agreement_Url;
            ctr.title=@"服务协议";
            [self.navigationController pushViewController:ctr animated:YES];
        }
        else if(indexPath.row==3){//用户说明
            MyWebViewViewController *ctr=[[MyWebViewViewController alloc] init];
            ctr.urlStr=user_explain_Url ;
            ctr.title=@"用户说明";
            [self.navigationController pushViewController:ctr animated:YES];
        }
    }
    else if (indexPath.section==2) {
        if (indexPath.row==0) {
            ModifyPswViewController *ctr=[[ModifyPswViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:ctr animated:YES];
        }
    }
    else if (indexPath.section==0){
        [UIAlertView bk_showAlertViewWithTitle:nil message:@"确定清除本地缓存?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"清除" ] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            if (buttonIndex==1) {
                  [[SDImageCache sharedImageCache] cleanDiskWithCompletionBlock:^{
                      [SVProgressHUD showSuccessWithStatus:@"已清除"];
                      [myTable reloadData];
                  }];
                
            }
            
        }];
        
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
