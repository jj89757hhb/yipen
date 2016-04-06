//
//  AboutViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/17.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *list;
@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"关于易盆";
    self.list=[[NSMutableArray alloc] initWithObjects:@"欢迎页",@"欢迎易盆",@"问题反馈",@"创作人员",@"客服热线",nil];
    [self initTable];
    copyrightL=[[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 20)];
    companyL=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(copyrightL.frame), SCREEN_WIDTH, 20)];
    copyrightL.font=[UIFont boldSystemFontOfSize:15];
     companyL.font=[UIFont systemFontOfSize:14];
    copyrightL.textColor=[UIColor darkGrayColor];
    companyL.textColor=[UIColor darkGrayColor];
    companyL.textAlignment=NSTextAlignmentCenter;
    copyrightL.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:copyrightL];
    [self.view addSubview:companyL];
    copyrightL.text=@"Copyright©2015";
    companyL.text=@"杭州森圭网络科技有限公司";
    
    self.view.backgroundColor=WHITEColor;
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    myTable.backgroundColor=WHITEColor;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 210;
    }
    else
        return 45;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@""];
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//            float width=50;
             float width=451/2;
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-width)/2, 60, width, 458/2)];
            imageView.image=[UIImage imageNamed:@"logo"];//451 × 458
        
//            UILabel *version=[[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, SCREEN_WIDTH, 20)];
            UILabel *version=[[UILabel alloc] initWithFrame:CGRectMake(0, 140, SCREEN_WIDTH, 20)];
            version.font=[UIFont systemFontOfSize:12];
            version.textColor=[UIColor darkGrayColor];
            version.text=@"版本1.1";
            version.textAlignment=NSTextAlignmentCenter;
//            cell.textLabel.text=_list[indexPath.row-1];
                [cell.contentView addSubview:imageView];
                [cell.contentView addSubview:version];
        }
        return cell;
    }
    else{
    static NSString *identify=@"identify";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
        cell.textLabel.text=_list[indexPath.row-1];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
