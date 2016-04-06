//
//  SelectTagViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/26.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  选择标签

#import "SelectTagViewController.h"
#import "SKTagView.h"
#import "TreeSort.h"
@interface SelectTagViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) SKTagView *tagView;
@property(nonatomic,strong)NSMutableArray *list;
@property(nonatomic,strong)NSMutableArray *names;
@property(nonatomic,strong)TreeSort *selectSort;
@end

@implementation SelectTagViewController
static NSString *kTagsTableCellReuseIdentifier=@"kTagsTableCellReuseIdentifier";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"选择标签";
    self.names=[[NSMutableArray alloc] init];
    self.list=[[NSMutableArray alloc] init];
    [self initTable];
    WS(weakSelf)
    [self setNavigationBarRightItem:@"完成" itemImg:nil withBlock:^(id sender) {
        [weakSelf finishAction];
    }];
    [SVProgressHUD show];
    [self requestData];
}

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kTagsTableCellReuseIdentifier];
}
-(void)requestData{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:-1],@"Lastid", nil];
    [HttpConnection DownBaseInfo:dic WithBlock:^(id response, NSError *error) {
        [SVProgressHUD dismiss];
        if ([[response objectForKey:@"ok"] boolValue]) {
            NSArray *records=response[@"records"];
            for (NSDictionary *dic in records) {
                TreeSort *sort=[[TreeSort alloc] initWithKVCDictionary:dic];
                
               
                if ([sort.CodeDivision isEqualToString:@"品种"]) {
                     [self.list addObject:sort];
                      [self.names addObject:sort.CodeValue];
                }
              
            }
            [myTable reloadData];
            
        }
        else{
            
        }
    }];
}

-(void)finishAction{
    if (_selectBlock) {
        _selectBlock(_selectSort);
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (!cell)
    {
        if (indexPath.section==0) {
            cell = [tableView dequeueReusableCellWithIdentifier:kTagsTableCellReuseIdentifier];
        }
        
    }
    [self setupTagViewWithCell:cell withType:indexPath.section];
    [cell updateConstraintsIfNeeded];
    [cell layoutIfNeeded];//要使用这个
    //    [cell up ]
    
    //    [self configureCell:cell atIndexPath:indexPath];
    NSLog(@"height222:%f",[cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
    if (self.tagView) {
        float  height=[self.tagView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        NSLog(@"height111:%f",height);
        if (height==0) {
            height=40;
        }
        return height;
    }
    else{
        return 44;
    }
    
    //    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    if (section==0) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 20)];
        label.font=[UIFont systemFontOfSize:16];
        label.textColor=[UIColor grayColor];
        label.text=@"类别";
        [view addSubview:label];
    }
    
    return view;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTagsTableCellReuseIdentifier];
    UITableViewCell *cell=nil;
    if (indexPath.section==0) {
        cell=  [tableView dequeueReusableCellWithIdentifier:kTagsTableCellReuseIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    cell.backgroundColor=VIEWBACKCOLOR;
    UILabel *temp=[cell.contentView viewWithTag:100];
    if (temp) {
        [temp removeFromSuperview];
    }
//    if (_lastSearchList.count==0&&indexPath.section==0) {
//        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 5, SCREEN_WIDTH, 30)];
//        label.tag=100;
//        label.textAlignment=NSTextAlignmentCenter;
//        label.text=@"暂无搜索记录";
//        label.font=[UIFont systemFontOfSize:14];
//        label.textColor=DEEPBLACK;
//        [cell.contentView addSubview:label];
//    }
//    else{
        [self setupTagViewWithCell:cell withType:indexPath.section];
//    }
    return cell;
}

- (void)setupTagViewWithCell:(UITableViewCell*)cell withType:(NSInteger)type
{
    
    self.tagView = ({
        SKTagView *view = [SKTagView new];
        //        view.backgroundColor = UIColor.whiteColor;
        view.backgroundColor=Clear_Color;
        //        view.padding    = UIEdgeInsetsMake(12, 12, 12, 12);
        float offX=5;
        view.padding    = UIEdgeInsetsMake(12-offX, 12-offX, 12-offX, 12-offX);
        view.insets    = 15;
        view.lineSpace = 10;
        __weak SKTagView *weakView = view;
        view.didClickTagAtIndex = ^(NSUInteger index){//点击事情
            
            NSLog(@"index:%d",index);
            //           SKTagButton*btn= view.subviews[index];
            //            btn.layer.cornerRadius=5;
            //            btn.clipsToBounds=YES;
            //            btn.layer.borderColor=DEEPORANGECOLOR.CGColor;
            //            btn.layer.borderWidth=1;
            self.selectSort=_list[index];
            if (type==1) {
                
            }
            else if (type==0){
                
            }
            
        };
        view;
    });
    [cell.contentView addSubview:self.tagView];
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView *superView =cell.contentView;
        //        make.centerY.equalTo(superView.mas_centerY).with.offset(0);
        
        
        make.leading.equalTo(superView.mas_leading).with.offset(0);
        make.trailing.equalTo(superView.mas_trailing);
        
        //        make.top.equalTo(superView.top).offset(10);
        //        make.left.equalTo(superView.left).offset(10);
        //        make.right.equalTo(superView.right).offset(-10);
        //        make.bottom.equalTo(superView.bottom).offset(-10);
    }];
    NSMutableArray *list=nil;
    if (type==0) {//最近
        list=self.names;
    }
    //    else if (type==1){//热门
    //        list=self.hotSearchList;
    //    }
    //Add Tags
    //    [@[@"Python", @"Javascript你好阿斯达克叫啥好得很好", @"Python或多或少", @"HTML", @"Go", @"Objective-C",@"C", @"PHP"] enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SKTag *tag = [SKTag tagWithText:obj];
        tag.textColor = [UIColor darkGrayColor];
        tag.fontSize = 15;
        //tag.font = [UIFont fontWithName:@"Courier" size:15];
        float offX=5;
        tag.padding = UIEdgeInsetsMake(13.5-offX, 12.5-offX, 13.5-offX, 12.5-offX);
        //         tag.bgColor = [UIColor colorWithHexString:self.colorPool[idx % self.colorPool.count]];
        tag.bgColor=WHITEColor;
        tag.cornerRadius = 5;
        
        [self.tagView addTag:tag];
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
