//
//  ApplyIdentityViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/16.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ApplyIdentityViewController.h"

@interface ApplyIdentityViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    int count;
}
@property(nonatomic,strong)NSData *data1;
@property(nonatomic,strong)NSData *data2;
@property(nonatomic,strong)NSData *data3;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSString *name1;
@property(nonatomic,strong)NSString *name2;
@property(nonatomic,strong)NSString *name3;

@end

@implementation ApplyIdentityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申请认证";
    self.view.backgroundColor=WHITEColor;
    [self.sureBtn addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [self.btn1 addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn2 addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn3 addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    self.btn1.clipsToBounds=YES;
    self.btn2.clipsToBounds=YES;
    self.btn3.clipsToBounds=YES;
    self.btn1.layer.cornerRadius=5;
    self.btn2.layer.cornerRadius=5;
    self.btn3.layer.cornerRadius=5;
    self.btn1.layer.borderColor=Line_Color.CGColor;
    self.btn1.layer.borderWidth=0.5;
    self.btn2.layer.borderColor=Line_Color.CGColor;
    self.btn2.layer.borderWidth=0.5;
    self.btn3.layer.borderColor=Line_Color.CGColor;
    self.btn3.layer.borderWidth=0.5;
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    
   
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}



-(void)sureAction{
        EAccountType type=kPersonAccount;
    if ([_nameTF.text length]==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入真实姓名"];
        return;
    }
    if (!_data1) {
        [SVProgressHUD showErrorWithStatus:@"请选择一张身份证正面照"];
        return;
    }
    if (!_data2) {
        [SVProgressHUD showErrorWithStatus:@"请选择一张身份证反面照"];
        return;
    }
        count++;
   NSDictionary *dic=nil;
    if ([_infoTF.text length]) {
         dic= [[NSDictionary alloc] initWithObjectsAndKeys:_nameTF.text,@"Name",_infoTF.text,@"Certifi",[NSNumber numberWithInteger:type],@"IsBusiness",[DataSource sharedDataSource].userInfo.ID,@"UID" ,nil];
    }
    else{
        dic= [[NSDictionary alloc] initWithObjectsAndKeys:_nameTF.text,@"Name",[NSNumber numberWithInteger:type],@"IsBusiness",[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    }
    [SVProgressHUD show];
    [HttpConnection MemberCertifiPicture:dic pic1:_data1 pic2:_data2 pic3:_data3 count:count WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
//                [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                NSString *reason=[response objectForKey:@"reason"];
                if (count==1) {
                     self.name1=reason;
                    [self sureAction];//接着上传第二张、三张
                }
                else if(count==2){
                     self.name2=reason;
                    if (type==kEnterpriseAccount) {
                        [self sureAction];//接着上传第三张
                    }
                    else{
                        [SVProgressHUD show];
                        NSMutableDictionary *dic2=[[NSMutableDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_name1,@"fileName1",_name2,@"fileName2", nil];
//                        [dic2 setDictionary:dic];
                        [dic2 addEntriesFromDictionary:dic];
                        [HttpConnection MemberCertifiInfo:dic2 WithBlock:^(id response, NSError *error) {
                            if (!error) {
                                if ([[response objectForKey:@"ok"] boolValue]) {
                                    [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                                    [self.navigationController popViewControllerAnimated:YES];
                                }
                                else{
                                    [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
                                }
                            }
                            else{
                                [SVProgressHUD showErrorWithStatus:ErrorMessage];
                                  count=0;
                            }
                           
                            
                        }];
                    }
            
                   
                }
                else if(count==3){
                    self.name3=reason;
                    [SVProgressHUD show];
                    NSMutableDictionary *dic2=[[NSMutableDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_name1,@"fileName1",_name2,@"fileName2",_name3,@"fileName3", nil];
                    [dic2 addEntriesFromDictionary:dic];
                    [HttpConnection MemberCertifiInfo:dic2 WithBlock:^(id response, NSError *error) {
                        if (!error) {
                            if ([[response objectForKey:@"ok"] boolValue]) {
                                [SVProgressHUD showSuccessWithStatus:@"提交成功"];
                                [self.navigationController popViewControllerAnimated:YES];
                            }
                            else{
                                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
                            }
                        }
                        else{
                            [SVProgressHUD showErrorWithStatus:ErrorMessage];
                            count=0;
                        }
                        
                        
                    }];
                }
        
            
            }
            else{
                count=0;
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
            count=0;
        }
        
    }];
   
}

//-(void)uploadPictureMore{
//    [HttpConnection MemberCertifiPicture:dic pic1:_data1 pic2:nil pic3:nil WithBlock:^(id response, NSError *error) {
//        if (!error) {
//            if ([[response objectForKey:@"ok"] boolValue]) {
//                //                [SVProgressHUD showSuccessWithStatus:@"提交成功"];
//                NSString *reason=[response objectForKey:@"reason"];
//                self.name1=reason;
//            }
//            else{
//                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
//            }
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:ErrorMessage];
//        }
//        
//    }];
//}

-(void)selectPhoto:(UIButton*)sender{
    if ([sender isEqual:_btn1]) {
        self.type=1;
    }
    else if([sender isEqual:_btn2]){
        self.type=2;
    }
    else if([sender isEqual:_btn3]){
        self.type=3;
    }
    [self.view endEditing:YES];
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
//    [_imgList removeAllObjects];
//    [_imgList addObject:data];
//    [self uploadHead];
    if (_type==1) {
        self.data1=data;
        [_btn1 setBackgroundImage:picture forState:UIControlStateNormal];
         _btn1.contentMode=UIViewContentModeScaleAspectFill;
        
    }
    else if(_type==2){
        self.data2=data;
         [_btn2 setImage:picture forState:UIControlStateNormal];
        _btn2.contentMode=UIViewContentModeScaleAspectFill;
    }
    else if(_type==3){
        self.data3=data;
        [_btn3 setImage:picture forState:UIControlStateNormal];
        _btn3.contentMode=UIViewContentModeScaleAspectFill;

    }
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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
