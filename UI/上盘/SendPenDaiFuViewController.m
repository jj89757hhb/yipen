//
//  SendPenDaiFuViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/19.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SendPenDaiFuViewController.h"
#import "ZYQAssetPickerController.h"
#import "TreeSort.h"
#import "SelectTagViewController.h"
#import "ExpertViewController.h"
@interface SendPenDaiFuViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UINavigationControllerDelegate, ZYQAssetPickerControllerDelegate,UIImagePickerControllerDelegate,ExpertDelegate>
@property(nonatomic,strong)UITextField *titleTF;
@property(nonatomic,strong)UITextView *contentTV;
@property(nonatomic,strong)NSMutableArray *imgList;
@property(nonatomic,strong)UILabel *popL;
@property(nonatomic,strong)TreeSort *sort;
@property(nonatomic,strong)NSMutableDictionary *sortDic;
@property(nonatomic,strong)NSString *selectUserId;
@end

@implementation SendPenDaiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imgList=[[NSMutableArray alloc] init];
    WS(weakSelf)
    [self setNavigationBarRightItem:@"完成" itemImg:nil withBlock:^(id sender) {
        [weakSelf sendAction];
    }];
    [self initTable];
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 50+100;
        }
//        return 100;
    }
    else if(indexPath.section==3){
        float offX=10;
        float width=(SCREEN_WIDTH-6*offX)/5.f;
        return width+30+15;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 1;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify=@"identify";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    }
    if (indexPath.section==0) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (indexPath.row==0) {
            self.titleTF=[[UITextField alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-10*2, 30)];
      
            _titleTF.placeholder=@"请输入标题(可不输)";
            UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_titleTF.frame), SCREEN_WIDTH, 0.5)];
            line.backgroundColor=Line_Color;
            self.contentTV=[[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(line.frame), SCREEN_WIDTH-10*2, 100)];
            
            [cell.contentView addSubview:_titleTF];
            [cell.contentView addSubview:line];
            [cell.contentView addSubview:_contentTV];
            _contentTV.font=[UIFont systemFontOfSize:16];
            _contentTV.delegate=self;
            UILabel *contentL=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 20)];
            contentL.text=@"描述疑难杂症";
            contentL.textColor=[UIColor darkGrayColor];
            contentL.font=[UIFont systemFontOfSize:14];
            self.popL=contentL;
            [_contentTV addSubview:contentL];

        }
//        else{
//
//        }
    }
    else if(indexPath.section==1){
        cell.textLabel.text=@"咨询专家(会员专享)";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    else if(indexPath.section==2){
        cell.textLabel.text=@"选择标签(必选)";
         cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        UILabel *nameL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-115, 10, 90, 20)];
        nameL.font=[UIFont systemFontOfSize:14];
        nameL.textColor=[UIColor darkGrayColor];
        nameL.textAlignment=NSTextAlignmentRight;
//        nameL.text=_sort.CodeValue;
        NSString *value=nil;
        NSString *lastValue=nil;
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
    }
    else if(indexPath.section==3){
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 20)];
        [title setText:@"请添加照片"];
        [title setFont:[UIFont systemFontOfSize:15]];
        [title setTextColor:[UIColor grayColor]];
        [cell.contentView addSubview:title];
        UILabel *desL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-100, 5, 90, 20)];
        [desL setText:No_Memeber_Picture_Msg];
        desL.textAlignment=NSTextAlignmentRight;
        desL.font=[UIFont systemFontOfSize:13];
        [desL setTextColor:[UIColor grayColor]];
        [cell.contentView  addSubview:desL];
        NSInteger count=0;
        if (_imgList.count==0) {
            count=1;
        }
        else if(_imgList.count==[CommonFun upLoadPictureNum]){
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
//            imageView.layer.cornerRadius=2;
//            imageView.layer.borderColor=[UIColor grayColor].CGColor;
//            imageView.layer.borderWidth=1;
            imageView.tag=100+i;
            imageView.contentMode=UIViewContentModeScaleAspectFill;
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
//        [cell.contentView setBackgroundColor:VIEWBACKCOLOR];
        return cell;
    }
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        SelectTagViewController *ctr=[[SelectTagViewController alloc] init];
        ctr.enterType=2;
        [ctr setSelectBlock:^(id sender){
            self.sortDic=sender;
            for (NSString *key in _sortDic.allKeys) {//值
                id temp=[_sortDic objectForKey:key];
                if (![temp isMemberOfClass:[TreeSort class]]) {//过滤掉为空的对象
                    [_sortDic removeObjectForKey:key];
                }
            }
            
            NSIndexSet *sections=[NSIndexSet  indexSetWithIndex:2];
            [myTable reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
        }];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(indexPath.section==1){
//        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"Uid",[NSNumber numberWithInteger:1],@"Page",[NSNumber numberWithInteger:10],@"PageSize", nil];
//        [HttpConnection GetExperts:dic WithBlock:^(id response, NSError *error) {
//            
//        }];
        if (![[DataSource sharedDataSource].userInfo.RoleType isEqualToString:@"1"]&&![[DataSource sharedDataSource].userInfo.RoleType isEqualToString:@"2"]) {
            [UIAlertView bk_showAlertViewWithTitle:nil message:@"您还未开通会员、请先开通会员再尝试" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                
            }];
            return;
        }
        [self queryExpert];
    }
}


//查询专家
-(void)queryExpert{
    ExpertViewController *ctr=[[ExpertViewController alloc] init];
    ctr.delegate=self;
    [self.navigationController pushViewController:ctr animated:YES];
}
//代理
-(void)selectExpert:(NSMutableArray *)experts{
    NSLog(@"experts11:%@",experts);
    for (int i=0; i<experts.count; i++) {
        if (i==0) {
            self.selectUserId=experts[0];
        }
        else{
            self.selectUserId=[_selectUserId stringByAppendingString:[NSString stringWithFormat:@",%@",experts[i]]];
        }
    }
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
//        [SVProgressHUD showErrorWithStatus:@"请选择标签"];
//        return;
//    }
    if (sortDic2.allValues.count==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择标签"];
        return;
    }
    [SVProgressHUD show];
    NSMutableDictionary *dic=nil;
    // IsAuction非拍卖传0
    dic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:_titleTF.text,@"Title",_contentTV.text,@"Message", [DataSource sharedDataSource].userInfo.ID,@"Uid",[NSNumber numberWithInt:5],@"Type",[NSNumber numberWithInt:0],@"IsAuction", nil];
    if (sortDic2.allKeys.count) {
        [dic setValuesForKeysWithDictionary:sortDic2];
    }
    if (_selectUserId) {
        [dic setObject:_selectUserId forKey:@"Experts"];
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
                                         [NotificationCenter postNotificationName:@"DismissSendView" object:nil];
                                      
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


//选择照片
-(void)tapAction:(UITapGestureRecognizer*)sender{
    UIImageView *imageView=sender.view;
    if (imageView.tag==150) {
        [self tapAction];
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

-(void)photoAction{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = [CommonFun upLoadPictureNum];
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
    [myTable reloadData];
    
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
                if (_imgList.count < [CommonFun upLoadPictureNum] + 1) {
                    //                    [_imgList insertObject:tempImg atIndex:0];
                    NSData *data=UIImageJPEGRepresentation(tempImg, compressionQuality);
                    [_imgList addObject:data];
                          [[SDImageCache sharedImageCache] storeImage:tempImg forKey:[NSString stringWithFormat:@"send_Cache_%d",i] toDisk:YES];  
                    //                    [self.imageDatas insertObject:data atIndex:_imageDatas.count];
                }
                
                
            });
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.photoIV setHidden:YES];
            //            [self initCollectionView];
//            [myTable reloadData];
            [myTable reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationNone];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_imgList.count == [CommonFun upLoadPictureNum] + 1) {
                [_imgList removeObjectAtIndex:_imgList.count -1];
                //                [self.imageDatas
                
            }
            
        });
    });
}


-(void)textViewDidChange:(UITextView *)textView{
    if ([textView.text length]) {
        [_popL setHidden:YES];
    }
    else{
        [_popL setHidden:NO];
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
