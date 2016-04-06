//
//  MessageCommentViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MessageCommentViewController.h"
#import "MessageCommentTableViewCell.h"
@interface MessageCommentViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MessageCommentViewController
static NSString *identify=@"identify";
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTable];
}



-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64-15) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
    [myTable registerNib:[UINib nibWithNibName:@"MessageCommentTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
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
