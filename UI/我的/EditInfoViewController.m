//
//  EditInfoViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/31.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "EditInfoViewController.h"
#import "EditNameViewController.h"
#import "EditIntroduceViewController.h"
#import "SetSexViewController.h"
#import "MyQRCodeViewController.h"
#import "BindMobileViewController.h"
#import "YiPenInfoViewController.h"
#import "AddressManagerViewController.h"
#import "HZAreaPickerView.h"
@interface EditInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,HZAreaPickerDelegate>
@property(nonatomic,strong)NSMutableArray *imgList;
@property(nonatomic,strong)HZAreaPickerView *locatePicker;
@property(nonatomic,strong)NSString *area;
@end

@implementation EditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    self.title=@"编辑资料";
    self.imgList=[[NSMutableArray alloc] init];
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [myTable reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 7;
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
    if (indexPath.section==0&&indexPath.row==0) {
        
        return 65;
    }
    
    return 45;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify=@"identify1";
    UIFont *font=[UIFont systemFontOfSize:16];
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.textLabel.font=font;
    }
    cell.textLabel.textColor=MIDDLEBLACK;
    float offY=12;
    if(indexPath.section==0){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row==0) {
                cell.textLabel.text=@"头像";
                UIImageView *headIV=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-50-15-20, 7.5, 50, 50)];
                headIV.contentMode=UIViewContentModeScaleAspectFill;
                headIV.clipsToBounds=YES;
                headIV.layer.cornerRadius=25;
                [headIV sd_setImageWithURL:[NSURL URLWithString:[DataSource sharedDataSource].userInfo.UserHeader]];
                [cell.contentView addSubview:headIV];
                
            }
            else if(indexPath.row==1){
                cell.textLabel.text=@"昵称";
                UILabel *nickNameL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-180, offY, 140, 20)];
                nickNameL.font=font;
                nickNameL.textAlignment=NSTextAlignmentRight;
                nickNameL.textColor=MIDDLEBLACK;
                [cell.contentView addSubview:nickNameL];
//                nickNameL.text=@"黑键";
                nickNameL.text=[DataSource sharedDataSource].userInfo.NickName;
            }
            else if(indexPath.row==2){
                cell.textLabel.text=@"性别";
                UILabel *sexL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140, offY, 100, 20)];
                sexL.textAlignment=NSTextAlignmentRight;
                sexL.font=font;
                sexL.textColor=MIDDLEBLACK;
//                sexL.text=@"男";
                sexL.text=[DataSource sharedDataSource].userInfo.Sex;
                [cell.contentView addSubview:sexL];
            }
            else if(indexPath.row==3){
                cell.textLabel.text=@"地区";
                UILabel *addressL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140, offY, 100, 20)];
                addressL.textAlignment=NSTextAlignmentRight;
                addressL.font=font;
                addressL.textColor=MIDDLEBLACK;
//                addressL.text=@"杭州";
                if ([DataSource sharedDataSource].userInfo.cityID) {
                    addressL.text=[DataSource sharedDataSource].userInfo.cityID;
                }
                [cell.contentView addSubview:addressL];
            }
            else if(indexPath.row==4){
                cell.textLabel.text=@"我的二维码";
                float width=24;
                UIImageView *headIV=[[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-width-15-20, (45-width)/2, width, width)];
                headIV.contentMode=UIViewContentModeScaleAspectFill;
                headIV.clipsToBounds=YES;
                [headIV setImage:[UIImage imageNamed:@"二维码图标"]];
                [cell.contentView addSubview:headIV];
            }
            else if(indexPath.row==5){
                cell.textLabel.text=@"易盆号";
                UILabel *accountL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-140, offY, 100, 20)];
                accountL.textAlignment=NSTextAlignmentRight;
                accountL.font=font;
                accountL.textColor=MIDDLEBLACK;
//                accountL.text=@"123456";
                accountL.text=[DataSource sharedDataSource].userInfo.ID;
                [cell.contentView addSubview:accountL];
            }
            else if(indexPath.row==6){
                cell.textLabel.text=@"自我介绍";
                UILabel *introduceL=[[UILabel alloc] initWithFrame:CGRectMake(60, offY, (SCREEN_WIDTH-90), 20)];
                introduceL.textAlignment=NSTextAlignmentRight;
                introduceL.font=font;
                introduceL.textColor=MIDDLEBLACK;
//                introduceL.text=@"喜欢松柏";
                introduceL.text=[DataSource sharedDataSource].userInfo.Descript;
                [cell.contentView addSubview:introduceL];
            }
        }
        else if(indexPath.section==1){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row==0) {
                cell.textLabel.text=@"修改绑定手机";
                UILabel *phoneL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-155, offY, 130, 20)];
                phoneL.textAlignment=NSTextAlignmentRight;
                phoneL.font=font;
                phoneL.textColor=MIDDLEBLACK;
//                phoneL.text=@"18857871640";
                phoneL.text=[DataSource sharedDataSource].userInfo.Mobile;
                [cell.contentView addSubview:phoneL];
            }
            
        }
        else if (indexPath.section==2){
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row==0) {
                cell.textLabel.text=@"收货地址";
            }
        }
        return cell;

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.locatePicker.delegate) {
        [self cancelLocatePicker];
        return;
    }
    [myTable  deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
            [self selectHead];
        }
        else if (indexPath.row==1) {
            EditNameViewController *ctr=[[EditNameViewController alloc] initWithNibName:nil bundle:nil];
            [ctr setChangeNameBlock:^(id sender){
                [self modifyName:sender];
            }];
            [self.navigationController pushViewController:ctr animated:YES];
        }
     
        else if (indexPath.row==2){
            SetSexViewController *ctr=[[SetSexViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:ctr animated:YES];
        }
        else if (indexPath.row==3){
            [self showAreaPicker];
        }
        else if (indexPath.row==4){
            MyQRCodeViewController *ctr=[[MyQRCodeViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:ctr animated:YES];
        }
        else if (indexPath.row==5){
            YiPenInfoViewController *ctr=[[YiPenInfoViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:ctr animated:YES];
        }
        else if (indexPath.row==6){
            EditIntroduceViewController *ctr=[[EditIntroduceViewController alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:ctr animated:YES];
        }
    }
    else if(indexPath.section==1){
        BindMobileViewController *ctr=[[BindMobileViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(indexPath.section==2){
        AddressManagerViewController *ctr=[[AddressManagerViewController alloc] init];
        [self.navigationController pushViewController:ctr animated:YES];
        
        
    }
}

-(void)selectHead{
    WS(weakSelf)
    UIActionSheet *actionSheet=[UIActionSheet bk_actionSheetWithTitle:@"头像"];
    [actionSheet bk_addButtonWithTitle:NSLocalizedString(@"拍照", nil) handler:^{
        [weakSelf cameraAction];
        
    }];
    [actionSheet bk_addButtonWithTitle:NSLocalizedString(@"从相册选择", nil) handler:^{
        [weakSelf photoAction];
    }];
    [actionSheet bk_setCancelButtonWithTitle:NSLocalizedString(@"取消", nil) handler:nil];
    [actionSheet showInView:self.view];

}


//弹出地址选择器
-(void)showAreaPicker{
    if (self.locatePicker.delegate) {
        return;
    }
    
    [self cancelLocatePicker];
    self.locatePicker = [[HZAreaPickerView alloc] initWithStyle:HZAreaPickerWithStateAndCity delegate:self];
    [self.locatePicker showInView:self.view];
}

-(void)cancelLocatePicker
{
    [self.locatePicker cancelPicker];
    self.locatePicker.delegate = nil;
    self.locatePicker = nil;
}


-(void)pickerDidChaneStatus:(HZAreaPickerView *)picker
{
    
    NSLog(@"地址：%@",[NSString stringWithFormat:@"%@ %@ %@", picker.locate.state, picker.locate.city, picker.locate.district]);
    
}
//点击完成按钮
-(void)pickerFinish:(HZAreaPickerView *)picker{
    self.area=[NSString stringWithFormat:@"%@ %@", picker.locate.state, picker.locate.city];
    NSLog(@"area11:%@",_area);
    [self cancelLocatePicker];
    
    [SVProgressHUD show];
    //    NSString *nickName=[NSString stringWithFormat:@"Desc=%@&UID=%@",_textView.text,[DataSource sharedDataSource].userInfo.ID];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:self.area,@"CityId",[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    
    [HttpConnection editUserInfoWithParameter:dic pics:nil WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([response[@"ok"] isEqualToString:@"TRUE"]) {
                [SVProgressHUD showInfoWithStatus:@"修改成功"];
                [DataSource sharedDataSource].userInfo.cityID=self.area;
                NSIndexSet *indexSet=[NSIndexSet indexSetWithIndex:0];
                [myTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
            }
            else{
                [SVProgressHUD showErrorWithStatus:response[@"reason"]];
            }
            
            
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
    }];
    
    
    
}

//取消
-(void)pickerCancel:(HZAreaPickerView *)picker{
    [self cancelLocatePicker];
}

-(void)cameraAction{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
        imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}


-(void)photoAction{
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.delegate = self;
    
    imagePickerController.allowsEditing = YES;
    
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *picture = [info objectForKey:UIImagePickerControllerEditedImage];
    NSData *data=UIImageJPEGRepresentation(picture, compressionQuality);
    [_imgList removeAllObjects];
    [_imgList addObject:data];
    [self uploadHead];
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

-(void)uploadHead{
//    NSString *param=[NSString stringWithFormat:@"UID=%@",[DataSource sharedDataSource].userInfo.ID];
    NSDictionary *param=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    [HttpConnection editUserInfoWithParameter:param pics:_imgList WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([response[@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:@"上传成功"];
                //刷新个人资料
                 NSString *param2=[NSString stringWithFormat:@"UID=%@",[DataSource sharedDataSource].userInfo.ID];
                [HttpConnection getOwnerInfoWithParameter:param2 WithBlock:^(id response, NSError *error) {
                    [myTable reloadData];
                    
                }];
//                [DataSource sharedDataSource].userInfo.Descript=_textView.text;
//                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                [SVProgressHUD showErrorWithStatus:response[@"reason"]];
            }
            
            
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }

    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}




-(void)modifyName:(NSString*)name{
    if ([name length]==0) {
        return;
    }
   }
@end
