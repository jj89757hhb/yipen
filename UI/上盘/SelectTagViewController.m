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
@property (strong, nonatomic) SKTagView *tagView1;
@property (strong, nonatomic) SKTagView *tagView2;
@property (strong, nonatomic) SKTagView *tagView3;
@property (strong, nonatomic) SKTagView *tagView4;
@property (strong, nonatomic) SKTagView *tagView5;
@property (strong, nonatomic) SKTagView *tagView6;
@property (strong, nonatomic) SKTagView *tagView7;
@property(nonatomic,strong)NSMutableArray *list1;
@property(nonatomic,strong)NSMutableArray *list2;
@property(nonatomic,strong)NSMutableArray *list3;
@property(nonatomic,strong)NSMutableArray *list4;
@property(nonatomic,strong)NSMutableArray *list5;
@property(nonatomic,strong)NSMutableArray *list6;
@property(nonatomic,strong)NSMutableArray *list7;
@property(nonatomic,strong)NSMutableArray *names;
@property(nonatomic,strong)TreeSort *selectSort1;
@property(nonatomic,strong)TreeSort *selectSort2;
@property(nonatomic,strong)TreeSort *selectSort3;
@property(nonatomic,strong)TreeSort *selectSort4;
@property(nonatomic,strong)TreeSort *selectSort5;
@property(nonatomic,strong)TreeSort *selectSort6;
@property(nonatomic,strong)TreeSort *selectSort7;
@end

@implementation SelectTagViewController
static NSString *kTagsTableCellReuseIdentifier1=@"kTagsTableCellReuseIdentifier1";
static NSString *kTagsTableCellReuseIdentifier2=@"kTagsTableCellReuseIdentifier2";
static NSString *kTagsTableCellReuseIdentifier3=@"kTagsTableCellReuseIdentifier3";
static NSString *kTagsTableCellReuseIdentifier4=@"kTagsTableCellReuseIdentifier4";
static NSString *kTagsTableCellReuseIdentifier5=@"kTagsTableCellReuseIdentifier5";
static NSString *kTagsTableCellReuseIdentifier6=@"kTagsTableCellReuseIdentifier6";
static NSString *kTagsTableCellReuseIdentifier7=@"kTagsTableCellReuseIdentifier7";
- (void)viewDidLoad {
    [super viewDidLoad];
    [NotificationCenter addObserver:self selector:@selector(reloadTableAtIndex) name:@"reloadTableAtIndex" object:nil];
    self.names=[[NSMutableArray alloc] init];//废弃
    self.list1=[[NSMutableArray alloc] init];
    self.list2=[[NSMutableArray alloc] init];
        self.list3=[[NSMutableArray alloc] init];
        self.list4=[[NSMutableArray alloc] init];
        self.list5=[[NSMutableArray alloc] init];
        self.list6=[[NSMutableArray alloc] init];
        self.list7=[[NSMutableArray alloc] init];
    [self initTable];
    WS(weakSelf)
    if (self.enterType==0) {
           self.title=@"搜索标签";
        [self setNavigationBarRightItem:@"搜索" itemImg:nil withBlock:^(id sender) {
            [weakSelf finishAction];
        }];
    }
    else{
           self.title=@"选择标签";
    [self setNavigationBarRightItem:@"完成" itemImg:nil withBlock:^(id sender) {
        [weakSelf finishAction];
        
    }];
    }
    [SVProgressHUD show];
    [self requestData];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [DataSource sharedDataSource].selectCounter=0;
}

-(void)reloadTableAtIndex{
    [myTable reloadSections:[NSIndexSet indexSetWithIndex:[DataSource sharedDataSource].lastSection] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kTagsTableCellReuseIdentifier1];
    if (self.enterType==0||self.enterType==2) {
        [myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kTagsTableCellReuseIdentifier2];
        [myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kTagsTableCellReuseIdentifier3];
        [myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kTagsTableCellReuseIdentifier4];
        [myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kTagsTableCellReuseIdentifier5];
        [myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kTagsTableCellReuseIdentifier6];
        [myTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kTagsTableCellReuseIdentifier7];
    }

}
-(void)requestData{
    /*
     生熟
    类别
    产地
    品种
    树型
    尺寸
    其它
     */
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:-1],@"Lastid", nil];
    [HttpConnection DownBaseInfo:dic WithBlock:^(id response, NSError *error) {
        [SVProgressHUD dismiss];
        if ([[response objectForKey:@"ok"] boolValue]) {
            NSArray *records=response[@"records"];
            for (NSDictionary *dic in records) {
                TreeSort *sort=[[TreeSort alloc] initWithKVCDictionary:dic];
               
                if (self.enterType==1) {
                    if([sort.CodeDivision isEqualToString:@"品种"]){
                        [self.list1 addObject:sort];
                    }
                }
                else{
                if([sort.CodeDivision isEqualToString:@"生熟"]){
                     [self.list1 addObject:sort];
                }
                else if([sort.CodeDivision isEqualToString:@"类别"]){
                     [self.list2 addObject:sort];
                }
                else if([sort.CodeDivision isEqualToString:@"产地"]){
                     [self.list3 addObject:sort];
                }
                else if ([sort.CodeDivision isEqualToString:@"品种"]) {
                    [self.list4 addObject:sort];
                    //                      [self.names addObject:sort.CodeValue];
                }
//                else if([sort.CodeDivision isEqualToString:@"树型"]){
                else if([sort.CodeDivision isEqualToString:@"树形"]){
                     [self.list5 addObject:sort];
                }
                else if([sort.CodeDivision isEqualToString:@"尺寸"]){
                     [self.list6 addObject:sort];
                }
                
//                else if([sort.CodeDivision isEqualToString:@"其它"]){
                else if([sort.CodeDivision isEqualToString:@"其他"]){
                     [self.list7 addObject:sort];
                }
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
//        _selectBlock(_selectSort1);
//         _selectBlock(_selectSort4);
        if (self.enterType==0) {//搜索
            NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:_selectSort1?_selectSort1:@"",SenShu,_selectSort2?_selectSort2:@"",LeiBie,_selectSort3?_selectSort3:@"",ChanDi,_selectSort4?_selectSort4:@"",PinZhong,_selectSort5?_selectSort5:@"",ShuXin,_selectSort6?_selectSort6:@"",ChiCun, _selectSort7?_selectSort7:@"",QiTa,nil];
            _selectBlock(dic);
        }
        else if (self.enterType==1) {//盆缘
             _selectBlock(_selectSort1);
        }
        else{
        NSMutableDictionary *dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:_selectSort1?_selectSort1:@"",SenShu,_selectSort2?_selectSort2:@"",LeiBie,_selectSort3?_selectSort3:@"",ChanDi,_selectSort4?_selectSort4:@"",PinZhong,_selectSort5?_selectSort5:@"",ShuXin,_selectSort6?_selectSort6:@"",ChiCun, _selectSort7?_selectSort7:@"",QiTa,nil];
          _selectBlock(dic);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
    [DataSource sharedDataSource].lastSection=0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSString *cellIndentify=nil;
    SKTagView *tagView=nil;
    if (indexPath.section==0) {
        cellIndentify=kTagsTableCellReuseIdentifier1;
    }
    else if (indexPath.section==1) {
        cellIndentify=kTagsTableCellReuseIdentifier2;
    }
    else if (indexPath.section==2) {
        cellIndentify=kTagsTableCellReuseIdentifier3;
    }
    else if (indexPath.section==3) {
        cellIndentify=kTagsTableCellReuseIdentifier4;
    }
    else if (indexPath.section==4) {
        cellIndentify=kTagsTableCellReuseIdentifier5;
    }
    else if (indexPath.section==5) {
        cellIndentify=kTagsTableCellReuseIdentifier6;
    }
    else if (indexPath.section==6) {
        cellIndentify=kTagsTableCellReuseIdentifier7;
    }
 
    if (!cell)
    {
            cell = [tableView dequeueReusableCellWithIdentifier:cellIndentify];
        
    }
    [self setupTagViewWithCell:cell withType:indexPath.section];
    if (indexPath.section==0) {
        tagView=_tagView1;
    }
    else if (indexPath.section==1) {
        tagView=_tagView2;
    }
    else if (indexPath.section==2) {
        tagView=_tagView3;
    }
    else if (indexPath.section==3) {
        tagView=_tagView4;
    }
    else if (indexPath.section==4) {
        tagView=_tagView5;
    }
    else if (indexPath.section==5) {
        tagView=_tagView6;
    }
    else if (indexPath.section==6) {
        tagView=_tagView7;
    }
    [cell updateConstraintsIfNeeded];
    [cell layoutIfNeeded];//要使用这个
    //    [self configureCell:cell atIndexPath:indexPath];
//    NSLog(@"height222:%f",[cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height);
    if (tagView) {
        float  height=[tagView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        NSLog(@"height111:%f",height);
        if (height==0) {
            height=44;
        }
//        if (indexPath.section==3) {
//            return 280;
//        }
//        else if (indexPath.section==4) {
//            return 160;
//        }
        return height;
    }
    else{
        return 44;
    }
    
    //    return [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 1;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.enterType==1) {
        return 1;
    }
    return 1+6;
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
        if (self.enterType==1) {
            label.text=@"品种";
        }
        else{
            label.text=@"生熟";
        }
  
        [view addSubview:label];
    }
    if (section==1) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 20)];
        label.font=[UIFont systemFontOfSize:16];
        label.textColor=[UIColor grayColor];
        label.text=@"类别";
        [view addSubview:label];
    }
    if (section==2) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 20)];
        label.font=[UIFont systemFontOfSize:16];
        label.textColor=[UIColor grayColor];
        label.text=@"产地";
        [view addSubview:label];
    }
    if (section==3) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 20)];
        label.font=[UIFont systemFontOfSize:16];
        label.textColor=[UIColor grayColor];
        label.text=@"品种";
        [view addSubview:label];
    }
    if (section==4) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 20)];
        label.font=[UIFont systemFontOfSize:16];
        label.textColor=[UIColor grayColor];
        label.text=@"树型";
        [view addSubview:label];
    }
    if (section==5) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 20)];
        label.font=[UIFont systemFontOfSize:16];
        label.textColor=[UIColor grayColor];
        label.text=@"尺寸";
        [view addSubview:label];
    }
    if (section==6) {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 120, 20)];
        label.font=[UIFont systemFontOfSize:16];
        label.textColor=[UIColor grayColor];
        label.text=@"其它";
        [view addSubview:label];
    }
    
    return view;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kTagsTableCellReuseIdentifier];
    UITableViewCell *cell=nil;
    NSString *cellIndentify=nil;
    if (indexPath.section==0) {
        cellIndentify=kTagsTableCellReuseIdentifier1;
    }
    else if (indexPath.section==1) {
        cellIndentify=kTagsTableCellReuseIdentifier2;
    }
    else if (indexPath.section==2) {
        cellIndentify=kTagsTableCellReuseIdentifier3;
    }
    else if (indexPath.section==3) {
        cellIndentify=kTagsTableCellReuseIdentifier4;
    }
    else if (indexPath.section==4) {
        cellIndentify=kTagsTableCellReuseIdentifier5;
    }
    else if (indexPath.section==5) {
        cellIndentify=kTagsTableCellReuseIdentifier6;
    }
    else if (indexPath.section==6) {
        cellIndentify=kTagsTableCellReuseIdentifier7;
    }
//    if (indexPath.section==0) {
        cell=  [tableView dequeueReusableCellWithIdentifier:cellIndentify];
//    }
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
    SKTagView *tagView=nil;
  
    tagView = ({
        SKTagView *view = [SKTagView new];
        view.section=type;
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
       
            if (type==0) {
                     self.selectSort1=_list1[index];
            }
            else if (type==1){
                self.selectSort2=_list2[index];
            }
            else if (type==2){
                self.selectSort3=_list3[index];
            }
            else if (type==3){
                self.selectSort4=_list4[index];
            }
            else if (type==4){
                self.selectSort5=_list5[index];
            }
            else if (type==5){
                self.selectSort6=_list6[index];
            }
            else if (type==6){
                self.selectSort7=_list7[index];
            }
//            else if (type==7){
//                self.selectSort1=_list1[index];
//            }
            
            
        };
        view;
    });
    if (type==0) {
        self.tagView1= tagView;
    }
    else if (type==1) {
        self.tagView2= tagView;
    }
    else if (type==2) {
         self.tagView3= tagView;
    }
    else if (type==3) {
         self.tagView4= tagView;
    }
    else if (type==4) {
         self.tagView5= tagView;
    }
    else if (type==5) {
        self.tagView6= tagView;
    }
    else if (type==6) {
         self.tagView7= tagView;
    }
    [cell.contentView addSubview:tagView];
    [tagView mas_makeConstraints:^(MASConstraintMaker *make) {
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
//        list=self.names;
         list=self.list1;
    }
    else if(type==1){
        list=self.list2;
    }
    else if(type==2){
        list=self.list3;
    }
    else if(type==3){
        list=self.list4;
    }
    else if(type==4){
        list=self.list5;
    }
    else if(type==5){
        list=self.list6;
    }
    else if(type==6){
        list=self.list7;
    }
    [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        TreeSort *sort=obj;
//        SKTag *tag = [SKTag tagWithText:obj];
        SKTag *tag = [SKTag tagWithText:sort.CodeValue];
        tag.textColor = [UIColor darkGrayColor];
        tag.fontSize = 15;
        //tag.font = [UIFont fontWithName:@"Courier" size:15];
        float offX=5;
        tag.padding = UIEdgeInsetsMake(13.5-offX, 12.5-offX, 13.5-offX, 12.5-offX);
        //         tag.bgColor = [UIColor colorWithHexString:self.colorPool[idx % self.colorPool.count]];
        tag.bgColor=WHITEColor;
        tag.cornerRadius = 5;
        
        [tagView addTag:tag];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [DataSource sharedDataSource].selectCounter=0;
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
