//
//  SendStoreViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SendStoreViewController.h"
#import "ZYQAssetPickerController.h"
#import "SendStoreTableViewCell.h"
@interface SendStoreViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UINavigationControllerDelegate, ZYQAssetPickerControllerDelegate>
@property(nonatomic,strong)NSMutableArray *imgList;
@property(nonatomic,strong)SendStoreTableViewCell *sendCell;
@end

@implementation SendStoreViewController
static NSString *identify=@"identify";
//static NSInteger Max_Pic=5;
- (void)viewDidLoad {
    [super viewDidLoad];
    WS(weakSelf)
    [self setNavigationBarRightItem:@"完成" itemImg:nil withBlock:^(id sender) {
        [weakSelf sendAction];
    }];
    [self initTable];
    self.imgList=[[NSMutableArray alloc] init];
}

-(void)sendAction{
    
}


-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"SendStoreTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 44*4+80;
    }
    else{
        float offX=10;
        float width=(SCREEN_WIDTH-6*offX)/5.f;
        return width+30+15;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        SendStoreTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.contentTV.delegate=self;
        self.sendCell=cell;
        return cell;
    }
    else{
        UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
            imageView.layer.cornerRadius=2;
            imageView.tag=100+i;
            imageView.layer.borderColor=[UIColor grayColor].CGColor;
            imageView.layer.borderWidth=1;
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
    return nil;
    
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
                    [[SDImageCache sharedImageCache] storeImage:tempImg forKey:[NSString stringWithFormat:@"send_Cache_%d",i] toDisk:YES completion:^{
                        
                    }];
                    
                    //                    [self.imageDatas insertObject:data atIndex:_imageDatas.count];
                }
                
                
            });
            
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [self.photoIV setHidden:YES];
            //            [self initCollectionView];
            [myTable reloadData];
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_imgList.count == [CommonFun upLoadPictureNum] + 1) {
                [_imgList removeObjectAtIndex:_imgList.count -1];
                //                [self.imageDatas
                
            }
            
        });
    });
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length]) {
        [_sendCell.popL setHidden:YES];
    }
    else{
        [_sendCell.popL setHidden:NO];
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
