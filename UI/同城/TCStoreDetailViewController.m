//
//  StoreDetailViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "TCStoreDetailViewController.h"
#import "TCStoreDetailTableViewCell.h"
#import "ActivityCommentTableViewCell.h"
#import "InputTextBottom.h"
#import "MWPhotoBrowser.h"
#import "StoreBottomView.h"
@interface TCStoreDetailViewController ()<UITableViewDelegate,UITableViewDataSource,MWPhotoBrowserDelegate>
@property(nonatomic,strong)UIView *bootomView;
@property(nonatomic,strong)InputTextBottom *inputTextBottom;
@property(nonatomic,strong)UIButton *collectBtn;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,strong)UIButton *praiseBtn;
@property(nonatomic,strong)NSMutableArray * photos;
@end

@implementation TCStoreDetailViewController
static NSString *identifer=@"identifer";
static NSString *identifer2=@"identifer2";
static NSString *identifer3=@"identifer3";
static float BottomToolView_Height=50;
static float BottomInputView_Height=50;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"店家";
    [self initTableView];
//    [self initBottomView];
    [self registerForKeyboardNotifications];
    
}

-(void)initTableView{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    myTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    [myTable registerClass:[TCStoreDetailTableViewCell class] forCellReuseIdentifier:identifer];
    [myTable registerClass:[ActivityCommentTableViewCell class] forCellReuseIdentifier:identifer2];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1+1+1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return _info.Comment.count;
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
//            return 400;
        ActivityInfo *info=_info;
        float content_Height=0;
        content_Height+=  [CommonFun sizeWithString:info.Message font:[UIFont systemFontOfSize:content_FontSize_StoreDetail] size:CGSizeMake(SCREEN_WIDTH-10*2-10*2, MAXFLOAT)].height;
        return 310+content_Height;
    }
    else if(indexPath.section==2){
        return 60;
    }
    return 30;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        TCStoreDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setInfo:_info];
        [cell setAttentionBlock:^(id sender){
            [self attentionAction:nil];
        }];
        return cell;
    }
    else if(indexPath.section==1){
        ActivityCommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer2 forIndexPath:indexPath];
        cell.indexPath=indexPath;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell setInfo:_info.Comment[indexPath.row]];
     
        return cell;
    }
    else if(indexPath.section==2){
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer3]
        ;
        if (!cell) {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer3];
            StoreBottomView *bottom=[[StoreBottomView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
            [bottom setInfo:_info];
            [cell addSubview:bottom];
            WS(weakSelf)
            [bottom setCommentBlock:^(id sender){
                [weakSelf commentAction:nil];
            }];
            
            [bottom setPraiseBlock:^(id sender){
                [weakSelf praiseAction:nil];
            }];
            
            [bottom setCollectBlock:^(id sender){
                [weakSelf collectAction:nil];
            }];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    return nil;
}



-(void)attentionAction:(id)info{
    [SVProgressHUD show];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.userInfo.ID,@"BUID", nil];
    [HttpConnection Focus:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:@"已关注"];
                _info.userInfo.IsFocus=@"1";
                [myTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                
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

- (void)registerForKeyboardNotifications
{
    //    [[NSNotificationCenter defaultCenter] addObserver:self
    //                                             selector:@selector(keyboardWasShown:)
    //                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* userInfo = [aNotification userInfo];
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    CGFloat keyboardTop = keyboardRect.origin.y;
    CGRect newTextViewFrame = self.view.bounds;
    newTextViewFrame.size.height = keyboardTop - self.view.bounds.origin.y;
    
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];
    
    //    [_inputTextBottom setFrame:CGRectMake(_inputTextBottom.frame.origin.x, _inputTextBottom.frame.origin.y-kbSize.height, _inputTextBottom.frame.size.width, _inputTextBottom.frame.size.height)];
    [_inputTextBottom setFrame:CGRectMake(_inputTextBottom.frame.origin.x, SCREEN_HEIGHT-BottomInputView_Height-kbSize.height-64, _inputTextBottom.frame.size.width, _inputTextBottom.frame.size.height)];
    
    
    [UIView commitAnimations];
    //    [_inputTextBottom setHidden:NO];
    
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    //    _inputTextBottom.contentInset = contentInsets;
    //    _inputTextBottom.scrollIndicatorInsets = contentInsets;
    [_bootomView setHidden:NO];
    [_inputTextBottom setHidden:YES];
    //    NSDictionary* userInfo = [aNotification userInfo];
    //
    //    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //    NSTimeInterval animationDuration;
    //    [animationDurationValue getValue:&animationDuration];
    //
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDuration:animationDuration];
    //
    //    textView.frame = self.view.bounds;
    //
    //    [UIView commitAnimations];
    
}



//底部工具条
-(void)initBottomView{
    float offX=10;
    float offY=5;
    float width=80;
    float offX2=(SCREEN_WIDTH-offX*2-width*3)/3;
    UIFont *font=[UIFont systemFontOfSize:13];
    UIColor *textColor=GRAYCOLOR;
    self.bootomView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-BottomToolView_Height-64, SCREEN_WIDTH, BottomToolView_Height)];
    _bootomView.backgroundColor=WHITEColor;
    self.collectBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX, offY, width, 40)];
    [_collectBtn addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_collectBtn setTitleColor:textColor forState:UIControlStateNormal];
    _collectBtn.titleLabel.font=font;
    [_collectBtn setImage:[UIImage imageNamed:@"收藏（未点）"] forState:UIControlStateNormal];
    [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
   self.commentBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX+offX2*1+width*1, offY, width, 40)];
    [_commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [_commentBtn setTitleColor:textColor forState:UIControlStateNormal];
    _commentBtn.titleLabel.font=font;
    [_commentBtn setImage:[UIImage imageNamed:@"评论icon"] forState:UIControlStateNormal];
    [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    //
   self.praiseBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX+offX2*2+width*2, offY, width, 40)];
    [_praiseBtn addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchUpInside];
    [_praiseBtn setTitleColor:textColor forState:UIControlStateNormal];
    _praiseBtn.titleLabel.font=font;
    [_praiseBtn setTitle:@"看好" forState:UIControlStateNormal];
    [_praiseBtn setImage:[UIImage imageNamed:@"看好(未点)"] forState:UIControlStateNormal];
    //
    [_bootomView addSubview:_collectBtn];
    [_bootomView addSubview:_commentBtn];
    [_bootomView addSubview:_praiseBtn];
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0.5)];
    [_bootomView addSubview:line];
    line.backgroundColor=Line_Color;
    [self.view addSubview:_bootomView];
    //    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    //    [line setBackgroundColor:Line_Color];
    if ([_info.IsCollect boolValue]) {
        [_collectBtn setImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
        [_collectBtn setUserInteractionEnabled:NO];
    }
    if ([_info.IsPraise boolValue]) {
         [_praiseBtn setImage:[UIImage imageNamed:@"看好"] forState:UIControlStateNormal];
    }
}

//收藏
-(void)collectAction:(UIButton*)sender{
    [SVProgressHUD show];
    Collect_Type type=KCollect_DianJia;
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BeID",[NSNumber numberWithInt:type],@"Type",_inputTextBottom.inputText.text,@"Message",nil];
    if (![_info.IsCollect boolValue]) {
        [HttpConnection Collection:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showSuccessWithStatus:@"已收藏"];
                    _info.IsCollect=@"1";
                    NSIndexSet *set=[NSIndexSet indexSetWithIndex:2];
                    [myTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                    
                }
                else{
                    [SVProgressHUD showSuccessWithStatus:[response objectForKey:@"reason"]];
                }
            }
            else{
                [SVProgressHUD showErrorWithStatus:ErrorMessage];
            }
            
        }];
    }
    else{
        [HttpConnection DelCollect:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showSuccessWithStatus:@"已取消收藏"];
                    _info.IsCollect=@"0";
                    NSIndexSet *set=[NSIndexSet indexSetWithIndex:2];
                    [myTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                    
                }
                else{
                    [SVProgressHUD showSuccessWithStatus:[response objectForKey:@"reason"]];
                }
            }
            else{
                [SVProgressHUD showErrorWithStatus:ErrorMessage];
            }
            
        }];
    }
  
}
-(void)commentAction:(UIButton*)sender{
    if (!_inputTextBottom) {
        self.inputTextBottom=[[InputTextBottom alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-BottomInputView_Height-64, SCREEN_WIDTH, BottomInputView_Height)];
        [self.view addSubview:_inputTextBottom];
        _inputTextBottom.backgroundColor=WHITEColor;
        [_inputTextBottom.inputText becomeFirstResponder];
        [_inputTextBottom.sendBtn addTarget:self action:@selector(sendAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else{
        
        [_inputTextBottom setHidden:NO];
        [_inputTextBottom.inputText becomeFirstResponder];
        //        [_inputTextBottom setFrame:CGRectMake(0, SCREEN_HEIGHT-BottomInputView_Height, SCREEN_WIDTH, BottomInputView_Height)];
    }
    
    [_bootomView setHidden:YES];

}

//赞
-(void)praiseAction:(UIButton*)sender{
  
    Collect_Type type=KCollect_DianJia;
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BeID",[NSNumber numberWithInteger:type],@"Type",_info.userInfo.ID,@"buid", nil];
    if (![_info.IsPraise boolValue]) {
          [SVProgressHUD show];
        [HttpConnection Praised:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showInfoWithStatus:@"已赞"];
                    _info.IsPraise=@"1";
                    NSIndexSet *set=[NSIndexSet indexSetWithIndex:2];
                    [myTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                    //                [self reloadTableAtIndex];
                    //                    [_praiseBtn setImage:[UIImage imageNamed:@"看好(已点)"] forState:UIControlStateNormal];
                    
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
    else{
//        [HttpConnection Praised:dic WithBlock:^(id response, NSError *error) {
//            if (!error) {
//                if ([[response objectForKey:@"ok"] boolValue]) {
//                    [SVProgressHUD showInfoWithStatus:@"已取消赞"];
//                    _info.IsPraise=@"1";
//                    NSIndexSet *set=[NSIndexSet indexSetWithIndex:2];
//                    [myTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
//                    //                [self reloadTableAtIndex];
//                    //                    [_praiseBtn setImage:[UIImage imageNamed:@"看好(已点)"] forState:UIControlStateNormal];
//                    
//                }
//                else{
//                    [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
//                }
//            }
//            else{
//                [SVProgressHUD showErrorWithStatus:ErrorMessage];
//            }
//            
//        }];
    }
   

}

//发送
-(void)sendAction:(UIButton*)sender{
    if ([CommonFun isSpaceCharacter:_inputTextBottom.inputText.text]) {
        
        return;
    }
    [SVProgressHUD show];
    Collect_Type type=KCollect_DianJia;
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BeID",[NSNumber numberWithInt:type],@"Type",_inputTextBottom.inputText.text,@"Message",nil];
    [HttpConnection Comments:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"评论成功"];
                CommentInfo *commentInfo=[[CommentInfo alloc] init];
                commentInfo.NickName=[DataSource sharedDataSource].userInfo.NickName;
                commentInfo.Message=_inputTextBottom.inputText.text;
                [_info.Comment addObject:commentInfo];
                [myTable reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
                _inputTextBottom.inputText.text=nil;
                [_inputTextBottom.inputText resignFirstResponder];
            }
            else{
                [SVProgressHUD showSuccessWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        
    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_inputTextBottom.inputText resignFirstResponder];
}


- (NSInteger)numberOfItems
{
    return _info.Attach.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:[_info.Attach objectAtIndex:index]]];
    //              placeholderImage:[UIImage imageNamed:@"Default_course"]];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSMutableArray *temp=[[NSMutableArray alloc] init];
    for (int i=0;i<_info.Attach.count;i++) {
        [temp addObject:[MWPhoto photoWithURL:[NSURL URLWithString:_info.Attach[i]]]];
    }
    
    self.photos=temp;
    [self showBrowserWithIndex:index];
}


-(void)showBrowserWithIndex:(NSInteger)index{
    
    //    self.thumbs = thumbs;
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
    [browser setCurrentPhotoIndex:index];
    
    [self.navigationController pushViewController:browser animated:YES];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
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
