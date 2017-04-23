//
//  SendPanYuanViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/26.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SendPanYuanViewController.h"
#import "ZYQAssetPickerController.h"
#import "SelectHeightViewController.h"
#import "SelectTagViewController.h"
#import "TreeSort.h"
#import "MWPhotoBrowser.h"
@interface SendPanYuanViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,ZYQAssetPickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)NSMutableArray *imgList;
@property(nonatomic,strong)NSString *heightValue;
@property(nonatomic,strong)TreeSort *sort;
@property(nonatomic,strong)TreeSort *sort2;
@property(nonatomic,strong)NSString *changeSort;
@property(nonatomic,strong)NSNumber *heightValue2;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,strong)NSMutableArray *photos;
@end

@implementation SendPanYuanViewController

- (void)viewDidLoad {
    [NotificationCenter addObserver:self selector:@selector(deleteLocalPicture) name:@"DeleteLocalPicture" object:nil];
    self.photos=[[NSMutableArray alloc] init];
    [super viewDidLoad];
    self.imgList=[[NSMutableArray alloc] init];
    [self initTable];
    WS(weakSelf)
    [self setNavigationBarRightItem:@"完成" itemImg:nil withBlock:^(id sender) {
        [weakSelf sendAction];
    }];

    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)sendAction{
    if (!_sort.CodeValue) {
        [SVProgressHUD showErrorWithStatus:@"请选择品种"];
        return;
    }
    if (!_heightValue) {
        [SVProgressHUD showErrorWithStatus:@"请选择高度"];
        return;
    }
//    if (!_changeSort) {
//        [SVProgressHUD showErrorWithStatus:@"是否想换品种"];
//        return;
//    }
    if (![DataSource sharedDataSource].City) {
        [SVProgressHUD showErrorWithStatus:@"请获取您当前的位置"];
        return;
    }
    [SVProgressHUD show];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"Uid",_heightValue2,@"Hight",_sort.CodeValue,@"Varieties",_sort2.CodeValue?_sort2.CodeValue:@"",@"ChangeVarieties",[DataSource sharedDataSource].City,@"Location",[NSNumber numberWithFloat:[DataSource sharedDataSource].CorrdX],@"CorrdX",[NSNumber numberWithFloat:[DataSource sharedDataSource].CorrdY],@"CorrdY",nil];
//       NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"Uid",_heightValue,@"Hight",_sort.CodeValue,@"Varieties",_sort2.CodeValue,@"ChangeVarieties",[DataSource sharedDataSource].City,@"Location",[DataSource sharedDataSource].CorrdX,@"CorrdX",[DataSource sharedDataSource].CorrdY,@"CorrdY",nil];
    [HttpConnection PostBasinsFate:dic pics:_imgList WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                 [SVProgressHUD showSuccessWithStatus:@"发布成功"];
                [self.navigationController popViewControllerAnimated:YES];
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

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    [self.view addSubview:myTable];
    myTable.delegate=self;
    myTable.dataSource=self;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else{
        return 4;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 130;
    }
    else{
        return 40;
   }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UIColor *color=[UIColor darkGrayColor];
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (indexPath.section==0) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 280, 20)];
        title.text=@"上传可以交换的宝贝照片(仅一张)";
        [cell.contentView addSubview:title];
        title.textColor=color;
        float width=90;
        NSInteger count=0;
        if (_imgList.count==0) {
            count=1;
        }
        else if(_imgList.count==1){
            count=_imgList.count;
        }
        else{
            count=_imgList.count+1;
        }
        for (int i=0; i<count;i++) {
            float offX=10,offY=5+30;
            //                float width=50;
//            float width=(SCREEN_WIDTH-6*offX)/5.f;
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

        
    }
    else{
        if (indexPath.row==0) {
               cell.textLabel.text=@"宝贝品种";
            UILabel *heightL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-105, 8, 80, 20)];
            heightL.textAlignment=NSTextAlignmentRight;
            heightL.font=[UIFont systemFontOfSize:15];
            heightL.textColor=[UIColor darkGrayColor];
            heightL.text=_sort.CodeValue;
            [cell.contentView addSubview:heightL];
        }
        else if(indexPath.row==1){
             cell.textLabel.text=@"高    度";
            UILabel *heightL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-115, 8, 90, 20)];
            heightL.textAlignment=NSTextAlignmentRight;
            heightL.font=[UIFont systemFontOfSize:15];
            heightL.textColor=[UIColor darkGrayColor];
            heightL.text=_heightValue;
            [cell.contentView addSubview:heightL];
        }
        else if(indexPath.row==2){
            cell.textLabel.text=@"想换品种";
            UILabel *heightL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-115, 8, 90, 20)];
            heightL.textAlignment=NSTextAlignmentRight;
            heightL.font=[UIFont systemFontOfSize:15];
            heightL.textColor=[UIColor darkGrayColor];
//            heightL.text=_changeSort;
            heightL.text=_sort2.CodeValue;
            [cell.contentView addSubview:heightL];
        }
        else if(indexPath.row==3){
            cell.textLabel.text=@"你的位置";
            UILabel *locationL=[[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-115-40, 8, 90+40, 20)];
            locationL.textAlignment=NSTextAlignmentRight;
            locationL.font=[UIFont systemFontOfSize:15];
            locationL.textColor=[UIColor darkGrayColor];
            if ([DataSource sharedDataSource].City.length==0) {
                locationL.text=@"未获得到定位信息";
            }
            else{
                locationL.text=[DataSource sharedDataSource].City;
            }
            [cell.contentView addSubview:locationL];
        }
        cell.textLabel.textColor=color;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            selectType=0;
            SelectTagViewController *ctr=[[SelectTagViewController alloc] init];
            ctr.enterType=1;
            [ctr setSelectBlock:^(id sender){
                self.sort=sender;
                
                NSIndexSet *sections=[NSIndexSet  indexSetWithIndex:1];
                [myTable reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
            }];
            [self.navigationController pushViewController:ctr animated:YES];
        }
        else if (indexPath.row==1) {
            SelectHeightViewController *ctr=[[SelectHeightViewController alloc] init];
            [ctr setSelectBlock:^(id sender){
                self.heightValue=[sender objectForKey:@"heightValue"];
                self.heightValue2=[sender objectForKey:@"heightValue2"];
                
                NSIndexSet *sections=[NSIndexSet  indexSetWithIndex:1];
                [myTable reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
            }];
            
            [self.navigationController pushViewController:ctr animated:YES];
        }
        else if (indexPath.row==2){
            selectType=1;
            SelectTagViewController *ctr=[[SelectTagViewController alloc] init];
            ctr.enterType=1;
            [ctr setSelectBlock:^(id sender){
                self.sort2=sender;
                
                NSIndexSet *sections=[NSIndexSet  indexSetWithIndex:1];
                [myTable reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
            }];
            [self.navigationController pushViewController:ctr animated:YES];
            WS(weakSelf)
//            UIActionSheet *actionSheet=[UIActionSheet bk_actionSheetWithTitle:@"是否想换品种"];
//            [actionSheet bk_addButtonWithTitle:NSLocalizedString(@"想换", nil) handler:^{
//                self.changeSort=@"想换";
//                NSIndexSet *sections=[NSIndexSet  indexSetWithIndex:1];
//                [myTable reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
//    
//                
//            }];
//            [actionSheet bk_addButtonWithTitle:NSLocalizedString(@"不想换", nil) handler:^{
//                self.changeSort=@"不想换";
//                NSIndexSet *sections=[NSIndexSet  indexSetWithIndex:1];
//                [myTable reloadSections:sections withRowAnimation:UITableViewRowAnimationNone];
//
//            }];
//            [actionSheet bk_setCancelButtonWithTitle:NSLocalizedString(@"取消", nil) handler:nil];
//            [actionSheet showInView:self.view];
        }
        
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

-(void)photoAction{
    ZYQAssetPickerController *picker = [[ZYQAssetPickerController alloc] init];
    picker.maximumNumberOfSelection = 1;
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
                if (_imgList.count < 1 + 1) {
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
            if (_imgList.count == 1 + 1) {
                [_imgList removeObjectAtIndex:_imgList.count -1];
                //                [self.imageDatas
                
            }
            
        });
    });
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
        [myTable reloadData];
        
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
