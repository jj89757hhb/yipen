//
//  SelectHeightViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/2.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SelectHeightViewController.h"

@interface SelectHeightViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *list;
@property(nonatomic,strong)NSString *heightValue;
@end

@implementation SelectHeightViewController
static NSString *identify=@"identify";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择高度";
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf goBackAction];
    }];
    /*
     10cm之内
     10cm-30cm
     30cm-60cm
     60cm-100cm
     100cm以上
     */
    self.list=[[NSMutableArray alloc] initWithObjects:@"10cm之内",@"10cm-30cm",@"30cm-60cm",@"60cm-100cm",@"100cm以上", nil];
    [self initTable];
    // Do any additional setup after loading the view.
    
    
}

-(void)goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:identify];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _list.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    cell.textLabel.text=_list[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self setSelectBlock:_list[indexPath.row]];
    if (_selectBlock) {
        
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:indexPath.row+1],@"heightValue2",_list[indexPath.row],@"heightValue", nil];
//        _selectBlock(_list[indexPath.row]);
        _selectBlock(dic);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
