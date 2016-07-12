//
//  SendShareViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/4.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SendShareViewController.h"
#import "SentTreePictureTableViewCell1.h"
#import "SendTreePictureTableViewCell2.h"
#import "SendTreePictureTableViewCell3.h"
//#import "SentTreePictureTableViewCell2.h"
#import "ZYQAssetPickerController.h"
#import "SelectTagViewController.h"
#import "TreeSort.h"
#import "MWPhotoBrowser.h"

@interface SendShareViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,UIScrollViewAccessibilityDelegate,UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate,MWPhotoBrowserDelegate>

//@property (weak, nonatomic) IBOutlet UITableViewCell *cell1;
//@property (weak, nonatomic) IBOutlet UITableViewCell *cell2;
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property(nonatomic,strong)NSMutableArray *imgList;
@property(nonatomic,strong)UITextView *contentTV;
@property(nonatomic,strong)UITextField *titleTF;
@property(nonatomic,strong) SentTreePictureTableViewCell1 *treeHeightCell;
@property(nonatomic,strong)SendTreePictureTableViewCell2 *cell2;
@property(nonatomic,strong)SendTreePictureTableViewCell3 *cell3;
@property(nonatomic,strong)TreeSort *sort;
@property(nonatomic,strong)UILabel *popL;
@property(nonatomic,strong)NSString *IsMarksPrice;//是否明价 1-明价 0-不明价
@property(nonatomic,strong)NSString *IsMailed;//是否包邮  1-包邮 0-买家自付
@property(nonatomic,strong) NSMutableArray *imageUrls;
@property(nonatomic,strong)NSMutableArray *photos;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,strong)NSMutableDictionary *sortDic;
@end

@implementation SendShareViewController
static NSString *identifer=@"SentTreePictureTableViewCell1";
static NSString *identifer2=@"SendTreePictureTableViewCell2";
static NSString *identifer3=@"SendTreePictureTableViewCell3";
//static NSInteger Max_Pic=5;
- (void)viewDidLoad {
    [super viewDidLoad];
    [NotificationCenter addObserver:self selector:@selector(deleteLocalPicture) name:@"DeleteLocalPicture" object:nil];
     self.imageUrls=[[NSMutableArray alloc] init];
     self.imgList=[[NSMutableArray alloc] init];
    [self.view setBackgroundColor:VIEWBACKCOLOR];
    [self.myTable setBackgroundColor:VIEWBACKCOLOR];
    [self.myTable setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44-20)];
    // Do any additional setup after loading the view from its nib.
//   self.title=@"发布分享";
    [self.myTable registerNib:[UINib nibWithNibName:@"SentTreePictureTableViewCell1" bundle:nil]  forCellReuseIdentifier:identifer];
    [self.myTable registerNib:[UINib nibWithNibName:@"SendTreePictureTableViewCell2" bundle:nil] forCellReuseIdentifier:identifer2];
    [self.myTable registerNib:[UINib nibWithNibName:@"SendTreePictureTableViewCell3" bundle:nil] forCellReuseIdentifier:identifer3];
    WS(weakSelf)
    [self setNavigationBarRightItem:@"完成" itemImg:nil withBlock:^(id sender) {
        [weakSelf sendAction];
    }];
    
    memberBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, SCREEN_HEIGHT-50, 70, 40)];
    memberBtn.titleLabel.font=[UIFont systemFontOfSize:16];
    [memberBtn setTitle:@"开通会员" forState:UIControlStateNormal];
    [memberBtn setTitleColor:BLUECOLOR forState:UIControlStateNormal];
    [self.view addSubview:memberBtn];
    [memberBtn addTarget:self action:@selector(memberAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.IsMarksPrice=@"1";
    if(self.enterType==2){
          self.IsMailed=@"0";
    }
    else{//拍卖 默认 卖家包邮
         self.IsMailed=@"1";
    }
    

    
}

//开通会员
-(void)memberAction{
    
}

//发布
-(void)sendAction{
    NSMutableDictionary *sortDic2=[[NSMutableDictionary alloc] init];
    for (NSString *key in _sortDic) {
        TreeSort *sort=_sortDic[key];
        [sortDic2 setObject:sort.CodeValue forKey:key];//保存值
    }
    if ([_titleTF.text length]==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入标题"];
        return;
    }
    
    if ([_contentTV.text length]==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入正文"];
        return;
    }
    if (_imgList.count==0) {
        [SVProgressHUD showErrorWithStatus:@"请添加照片"];
        return;
    }
//    if (!_sort.CodeValue) {
   if (sortDic2.allValues.count==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择标签"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary *dic=nil;

    // IsAuction非拍卖传0
    if (self.enterType==1) {//分享
//        dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:_titleTF.text,@"Title",_contentTV.text,@"Message", _treeHeightCell.heightTF.text, @"Hight",_treeHeightCell.widthTF.text,@"Width",_treeHeightCell.zhijinTF.text,@"Diameter",_treeHeightCell.ageTF.text,@"Old", [DataSource sharedDataSource].userInfo.ID,@"Uid",[NSNumber numberWithInt:1],@"Type",_sort.CodeValue,@"Varieties",[NSNumber numberWithInt:0],@"IsAuction", nil];
              dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:_titleTF.text,@"Title",_contentTV.text,@"Message", _treeHeightCell.heightTF.text, @"Hight",_treeHeightCell.widthTF.text,@"Width",_treeHeightCell.zhijinTF.text,@"Diameter",_treeHeightCell.ageTF.text,@"Old", [DataSource sharedDataSource].userInfo.ID,@"Uid",[NSNumber numberWithInt:1],@"Type",[NSNumber numberWithInt:0],@"IsAuction", nil];
        if (sortDic2.allKeys.count) {
                  [dic setValuesForKeysWithDictionary:sortDic2];
        }
  
    }
    else if(self.enterType==2){//出售
        if ([_cell2.treePriceTF.text length]==0&&[_IsMarksPrice isEqualToString:@"1"]) {
              [SVProgressHUD showErrorWithStatus:@"请填写价格"];
            return;
        }
        if ([_cell2.numTF.text length]==0) {
            [SVProgressHUD showErrorWithStatus:@"请填写数量"];
            return;
        }
        if ([_IsMailed isEqualToString:@"0"] &&_cell2.expressTF.text.length==0) {//包邮
            [SVProgressHUD showErrorWithStatus:@"请填写邮费"];
            return;
        }
        
        dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:_titleTF.text,@"Title",_contentTV.text,@"Message", _treeHeightCell.heightTF.text, @"Hight",_treeHeightCell.widthTF.text,@"Width",_treeHeightCell.zhijinTF.text,@"Diameter",_treeHeightCell.ageTF.text,@"Old", [DataSource sharedDataSource].userInfo.ID,@"Uid",[NSNumber numberWithInt:2],@"Type",self.IsMarksPrice,@"IsMarksPrice",_cell2.treePriceTF.text.length?_cell2.treePriceTF.text:@"0",@"Price",_cell2.numTF.text,@"Num", _IsMailed,@"IsMailed",_cell2.expressTF.text.length?_cell2.expressTF.text:@"0",@"MailFee",[NSNumber numberWithInt:0],@"IsAuction",nil];
        
        if (sortDic2.allKeys.count) {
            [dic setValuesForKeysWithDictionary:sortDic2];
        }
    }
    else if(self.enterType==3){//拍卖
        if (_cell3.auctionPriceTF.text.length==0) {//
            [SVProgressHUD showErrorWithStatus:@"请填写起拍价"];
            return;
        }
        if (_cell3.addPriceTF.text.length==0) {//
            [SVProgressHUD showErrorWithStatus:@"请填写加价幅度"];
            return;
        }
        if ([_IsMailed isEqualToString:@"0"] &&_cell3.expressTF.text.length==0) {//包邮
            [SVProgressHUD showErrorWithStatus:@"请填写运费"];
            return;
        }
        if (!startTime) {
            [SVProgressHUD showErrorWithStatus:@"请选择开始时间"];
            return;
        }
        if (!endTime) {
            [SVProgressHUD showErrorWithStatus:@"请选择结束时间"];
            return;
        }
        if (endTime<startTime) {
            [SVProgressHUD showErrorWithStatus:@"结束时间不能小于开始时间"];
            return;
        }
        dic=[[NSMutableDictionary alloc]
        initWithObjectsAndKeys:_titleTF.text,@"Title",_contentTV.text,@"Message", _treeHeightCell.heightTF.text, @"Hight",_treeHeightCell.widthTF.text,@"Width",_treeHeightCell.zhijinTF.text,@"Diameter",_treeHeightCell.ageTF.text,@"Old", [DataSource sharedDataSource].userInfo.ID,@"Uid",[NSNumber numberWithInt:3],@"Type",_IsMailed,@"IsMailed",_cell3.expressTF.text.length?_cell3.expressTF.text:@"0",@"MailFee",_cell3.auctionPriceTF.text,@"APrice",_cell3.addPriceTF.text,@"MakeUp",[NSNumber numberWithInteger:startTime],@"AStartTime",[NSNumber numberWithInteger:endTime],@"AEndTime",[NSNumber numberWithInt:1],@"IsAuction",nil];
        if (sortDic2.allKeys.count) {
            [dic setValuesForKeysWithDictionary:sortDic2];
        }
        NSLog(@"startTime:%ld",startTime);
         NSLog(@"endTime:%ld",endTime);
    }
    

    
    imageIndex=0;
    [HttpConnection PostBasins:dic pics:_imgList WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
//                [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                NSString *bid=response[@"bid"];
                 if (_imgList.count) {
                       [SVProgressHUD showWithStatus:@"正在上传图片"];
//                     if (imageIndex>=_imgList.count) {
//                          [SVProgressHUD showSuccessWithStatus:@"发布成功"];
//                         return ;
//                     }
                
                     NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"Uid",bid,@"Bid", nil];
                     for (int index=0 ;index<_imgList.count;index++) {
                         [HttpConnection PostBasins2:dic pics:_imgList[index] WithBlock:^(id response, NSError *error) {
                             if (!error) {
                                 if ([[response objectForKey:@"ok"] boolValue]) {
                                     imageIndex++;//计算已上传的数
                                     if (imageIndex>=_imgList.count) {
                                          [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                                         [self.navigationController popViewControllerAnimated:YES];
                                     }
                          
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
                  
                 }
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
            }
            
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        
    } ];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.enterType==1) {
           return 3;
    }
    else{
        return 3;
    }

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
//           return 2+1+1;
        if(self.enterType==1){
            return 3;
        }
        else{
             return 2+1+1;
        }
    }
    return 1;
//    return 2;
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 10;
    }
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 35;
        }
        else if (indexPath.row==1){
            return 100;
        }
        else if (indexPath.row==2){
            return 120;
        }
        else if (indexPath.row==3){
            if (self.enterType==2) {
              return 80;
            }
            else{
                return 130-10;
            }
            
        }
    }
    else if (indexPath.section==1){
            return 40;
//        if (indexPath.row==0) {
//           return 40;
//        }
//        else{
//            
//            float offX=10;
//            float width=(SCREEN_WIDTH-6*offX)/5.f;
//            return width+30+15;
//        }
   
    }
    else if (indexPath.section==2){
        
        float offX=10;
        float width=(SCREEN_WIDTH-6*offX)/5.f;
        return width+30+15;
    }
  
    return 40;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {//标题
            UITableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:@"cell1"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            self.titleTF=[cell.contentView viewWithTag:200];
            return cell;
        }
        else if(indexPath.row==1){//正文
            UITableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:@"cell2"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            self.contentTV=[cell.contentView viewWithTag:300];
            self.popL=[cell.contentView viewWithTag:301];
            _contentTV.delegate=self;
            
            return cell;
        }
        
        else if(indexPath.row==2){//高度数据
            self.treeHeightCell=[tableView dequeueReusableCellWithIdentifier:identifer];
            self.treeHeightCell .selectionStyle=UITableViewCellSelectionStyleNone;
            self.treeHeightCell.backgroundColor=VIEWBACKCOLOR;
            
            return _treeHeightCell;
        }
        else{//价格
            if (self.enterType==2) {
                WS(weakSelf)
                SendTreePictureTableViewCell2 *cell=[tableView dequeueReusableCellWithIdentifier:identifer2];
                self.cell2=cell;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
//                [cell.contentView setBackgroundColor:[UIColor orangeColor]];
//                [cell setBackgroundColor:[UIColor orangeColor]];
                [cell setClick1Block:^(id sender){//不明价
                    [cell.price1L setTextColor:WHITEColor];
                    [cell.price1L setBackgroundColor:[UIColor grayColor]];
                    [cell.price2L setTextColor:BLACKCOLOR];
                    [cell.price2L setBackgroundColor:Clear_Color];
                    [cell.rmb1L setHidden:YES];
                    [cell.treePriceTF setHidden:YES];
                    cell.treePriceTF.delegate=self;
                    [cell.treePriceTF resignFirstResponder];
                    self.IsMarksPrice=@"0";
                }];
                [cell setClick2Block:^(id sender){//明价
                    [cell.price1L setTextColor:BLACKCOLOR];
                    [cell.price1L setBackgroundColor:Clear_Color];
                    [cell.price2L setTextColor:WHITEColor];
                    [cell.price2L setBackgroundColor:[UIColor grayColor]];
                    [cell.rmb1L setHidden:NO];
                    [cell.treePriceTF setHidden:NO];
                    [cell.treePriceTF becomeFirstResponder];
                           self.IsMarksPrice=@"1";
                }];
                [cell setClick3Block:^(id sender){//卖家包邮
                    [cell.expressType1L setTextColor:WHITEColor];
                    [cell.expressType1L setBackgroundColor:[UIColor grayColor]];
                    [cell.expressType2L setTextColor:BLACKCOLOR];
                    [cell.expressType2L setBackgroundColor:Clear_Color];
                    [cell.rmb2L setHidden:YES];
                    [cell.expressTF setHidden:YES];
                    [cell.expressTF resignFirstResponder];
                    self.IsMailed=@"1";
                    
                }];
                [cell setClick4Block:^(id sender){//买家自费
                    [cell.expressType1L setTextColor:BLACKCOLOR];
                    [cell.expressType1L setBackgroundColor:Clear_Color];
                    [cell.expressType2L setTextColor:WHITEColor];
                    [cell.expressType2L setBackgroundColor:[UIColor grayColor]];
                    [cell.rmb2L setHidden:NO];
                    [cell.expressTF setHidden:NO];
                    cell.expressTF.delegate=self;
                    [cell.expressTF becomeFirstResponder];
                    self.IsMailed=@"0";
                }];
                return cell;
            }
            else
                if(self.enterType==3){
                SendTreePictureTableViewCell3 *cell=[tableView dequeueReusableCellWithIdentifier:identifer3];
                    self.cell3=cell;
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                           [cell.expressTF setHidden:YES];
                [cell setClick1Block:^(id sender){//卖家包邮
                    [cell.sellExpressL setTextColor:WHITEColor];
                    [cell.sellExpressL setBackgroundColor:[UIColor grayColor]];
                    [cell.buyExpressL setTextColor:BLACKCOLOR];
                    [cell.buyExpressL setBackgroundColor:Clear_Color];
                    [cell.expressTF setHidden:YES];
                    [cell.expressTF resignFirstResponder];
//                    [self.view endEditing:YES];
                         self.IsMailed=@"1";
                    }];
                [cell setClick2Block:^(id sender){
                    [cell.sellExpressL setTextColor:BLACKCOLOR];
                    [cell.sellExpressL setBackgroundColor:Clear_Color];
                    [cell.buyExpressL setTextColor:WHITEColor];
                    [cell.buyExpressL setBackgroundColor:[UIColor grayColor]];
                    [cell.expressTF setHidden:NO];
                    cell.expressTF.delegate=self;
                    [cell.expressTF becomeFirstResponder];
                       self.IsMailed=@"0";
                    }];
                    
                    [cell setStartTimeBlock:^(id sender){
                        isStartTime=YES;
                        [self showDatePickView];
                        
                    }];
                    
                    [cell setEndTimeBlock:^(id sender){
                        isStartTime=NO;
                        [self showDatePickView];
                    }];
                
                return cell;
            }
            return nil;
        }
    }
    else if(indexPath.section==1){
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.text=@"选择标签(必选)";
        cell.textLabel.textColor=[UIColor grayColor];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UILabel *nameL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-110-110, 10, 90+100, 20)];
        nameL.font=[UIFont systemFontOfSize:14];
        nameL.textColor=[UIColor darkGrayColor];
        nameL.textAlignment=NSTextAlignmentRight;
//        nameL.text=_sort.CodeValue;
        NSString *value=nil;
        NSString *lastValue=nil;
//        NSMutableString *mutableString=[[NSMutableString alloc] init];
        for (TreeSort *sort in _sortDic.allValues) {
            if (lastValue) {
                 value=   [value stringByAppendingString:[NSString stringWithFormat:@" %@",sort.CodeValue]];
            }
            else{
                value=sort.CodeValue;
            }
           
            lastValue=sort.CodeValue;
        }
        nameL.text=value;
        [cell.contentView addSubview:nameL];
        return cell;
    }
    else if(indexPath.section==2){
        if (indexPath.row==0) {
            UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
            [title setText:@"请添加照片"];
            [title setFont:[UIFont systemFontOfSize:15]];
            [title setTextColor:[UIColor grayColor]];
            [cell.contentView addSubview:title];
            UILabel *desL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 5, 90, 20)];
            [desL setText:@"非会员仅限5张"];
            desL.textAlignment=NSTextAlignmentRight;
            desL.font=[UIFont systemFontOfSize:13];
            [desL setTextColor:[UIColor grayColor]];
            [cell.contentView  addSubview:desL];
            NSInteger count=0;
            if (_imgList.count==0) {
                count=1;
            }
            else if(_imgList.count==Max_Pic){
                count=_imgList.count;
            }
            else{
                count=_imgList.count+1;
            }
            for (int i=0; i<count;i++) {
                float offX=10,offY=5+30;
//                float width=50;
                float width=(SCREEN_WIDTH-6*offX)/5.f;
                UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(offX+width*i+offX*i, offY, width, width)];
                imageView.contentMode=UIViewContentModeScaleAspectFill;
//                imageView.layer.cornerRadius=2;
//                imageView.layer.borderColor=[UIColor grayColor].CGColor;
//                imageView.layer.borderWidth=1;
            
                imageView.tag=100+i;
              
                imageView.clipsToBounds=YES;
                [cell.contentView addSubview:imageView];
                [imageView setUserInteractionEnabled:YES];
                UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
                [imageView addGestureRecognizer:tap];
                if (_imgList.count&&i<_imgList.count) {
                    imageView.image=[UIImage imageWithData:_imgList[i]];
                }
                else{
                    imageView.image=[UIImage imageNamed:@"+"];
                    imageView.tag=150;
                }
             
            }
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            [cell.contentView setBackgroundColor:VIEWBACKCOLOR];
            return cell;
            
        }
        else{
          
        }
        
    }

    return nil;
   
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1) {
        SelectTagViewController *ctr=[[SelectTagViewController alloc] init];
        [ctr setSelectBlock:^(id sender){
            self.sortDic=sender;
            for (NSString *key in _sortDic.allKeys) {//值
                id temp=[_sortDic objectForKey:key];
                if (![temp isMemberOfClass:[TreeSort class]]) {//过滤掉为空的对象
                    [_sortDic removeObjectForKey:key];
                }
            }
       
            NSIndexSet *sections=[NSIndexSet  indexSetWithIndex:1];
            [self.myTable reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
        }];
        [self.navigationController pushViewController:ctr animated:YES];
        if (indexPath.row==1) {
            
        }
    }
}


/*弹出日期选择器*/
-(void)showDatePickView
{
    [self quitDatePickerView];
    UIView *slideView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 216+44)];
    slideView.backgroundColor = [UIColor whiteColor];
    datepicker = [[UIDatePicker alloc] init];
    //添加事件
    [datepicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
    datepicker.frame = CGRectMake(0, 44, SCREEN_WIDTH, 216);
    datepicker.tag = 101;
    datepicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    datepicker.datePickerMode = UIDatePickerModeDateAndTime;
    datepicker.minimumDate=[NSDate new];
    [slideView addSubview:datepicker];
    UIView *dateToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    dateToolBar.backgroundColor = VIEWBACKCOLOR;
    [slideView addSubview:dateToolBar];
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitBtn setBackgroundImage:[UIImage imageNamed:@"quit"] forState:UIControlStateNormal];
    quitBtn.frame = CGRectMake(15, 10, 55, 25);
    [quitBtn addTarget:self action:@selector(quitDatePickerView) forControlEvents:UIControlEventTouchUpInside];
    
    [quitBtn setTintColor:DEEPORANGECOLOR];
    [quitBtn setTitleColor:DEEPORANGECOLOR forState:UIControlStateNormal];
    [quitBtn setTitle:@"完成" forState:UIControlStateNormal];
    [dateToolBar addSubview:quitBtn];
    
    _svm = [[SlidingViewManager alloc] initWithInnerView:slideView containerView:self.view];
    [_svm slideViewIn];
}

/*退出日期选取器*/
-(void)quitDatePickerView
{
    [_svm slideViewOut];
}

//选择时间
-(void) datePickerDateChanged:(UIDatePicker *)paramDatePicker{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm"];
        [dateFormatter setDateFormat:@"MM.dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:paramDatePicker.date];
    
    NSInteger  timeStamp= [paramDatePicker.date timeIntervalSince1970];
    if (isStartTime) {
        _cell3.startTimeL.text=strDate;
        startTime=timeStamp;
        
    }
    else{
        _cell3.endTimeL.text=strDate;
        endTime=timeStamp;
    }
    
    
}


//选择照片
-(void)tapAction:(UITapGestureRecognizer*)sender{
    UIImageView *imageView=sender.view;
    if (imageView.tag==150) {
          [self tapAction];
    }
    else{
        [self showBigImageWithIndex:imageView.tag-100];
    }
}


-(void)tapAction{
    WS(weakSelf)
    UIActionSheet *actionSheet=[UIActionSheet bk_actionSheetWithTitle:@"选择照片"];
    [actionSheet bk_addButtonWithTitle:NSLocalizedString(@"相册", nil) handler:^{
        [weakSelf photoAction];
        
    }];
    [actionSheet bk_addButtonWithTitle:NSLocalizedString(@"拍照", nil) handler:^{
        [weakSelf cameraAction];
    }];
    [actionSheet bk_setCancelButtonWithTitle:NSLocalizedString(@"取消", nil) handler:nil];
    [actionSheet showInView:self.view];
}
-(void)showBigImageWithIndex:(NSInteger)index{
    self.currentIndex=index;
    NSMutableArray *temp=[[NSMutableArray alloc] init];
//    [temp addObject:[NSString stringWithFormat:@"send_Cache_%ld",index]];
     [temp addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"send_Cache_%ld",index]]]];
//    for (int i=0;i<_info.Attach.count;i++) {
//        [temp addObject:[MWPhoto photoWithURL:[NSURL URLWithString:_info.Attach[i]]]];
//    }
    
    self.photos=temp;
//    index=0;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
    // Create browser
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:0];
    browser.enterType=1;
    
    [self.navigationController pushViewController:browser animated:YES];
}

-(void)deleteLocalPicture{
    if (_imgList.count>_currentIndex) {
    [_imgList removeObjectAtIndex:_currentIndex];
        [_myTable reloadData];
    
    }

}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}


-(void)photoAction{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = Max_Pic;
    picker.assetsFilter = [ALAssetsFilter allPhotos];
    picker.showEmptyGroups=NO;
    picker.delegate=self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset*)evaluatedObject valueForProperty:ALAssetPropertyDuration] doubleValue];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    
    [self presentViewController:picker animated:YES completion:NULL];
}

-(void)cameraAction{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    //    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *picture = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *data=UIImageJPEGRepresentation(picture, compressionQuality);
    [_imgList addObject:data];
//    [self.photoIV setHidden:YES];
//    [self initCollectionView];
    [_myTable reloadData];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


-(void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        for (int i=0; i<assets.count; i++) {
            
            ALAsset *asset=assets[i];
            UIImage *tempImg=[UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
            dispatch_async(dispatch_get_main_queue(), ^{
                //  [_imgList insertObject:tempImg atIndex:_imgList.count-1];
                if (_imgList.count < Max_Pic + 1) {
                    //                    [_imgList insertObject:tempImg atIndex:0];
                    NSData *data=UIImageJPEGRepresentation(tempImg, compressionQuality);
                    [_imgList addObject:data];
                    [[SDImageCache sharedImageCache] storeImage:tempImg forKey:[NSString stringWithFormat:@"send_Cache_%d",i] toDisk:YES];                    //                    [self.imageDatas insertObject:data atIndex:_imageDatas.count];
                }
                
                
            });
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.photoIV setHidden:YES];
//            [self initCollectionView];
                [_myTable reloadData];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_imgList.count == Max_Pic + 1) {
                [_imgList removeObjectAtIndex:_imgList.count -1];
                //                [self.imageDatas
                
            }
            
        });
    });
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length]) {
        [_popL setHidden:YES];
    }
    else{
        [_popL setHidden:NO];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
   

}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
     [_myTable setContentOffset:CGPointMake(0,0)];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (SCREEN_HEIGHT<=1136) {
        [_myTable setContentOffset:CGPointMake(0, 100)];
    }
    return YES;
}

-(void)dealloc{
    [NotificationCenter removeObserver:self];
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
