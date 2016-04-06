//
//  ActivityDetailViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/26.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ImagePlayerView.h"
#import "HeaderTableViewCell.h"
#import "ActivityDetailTableViewCell.h"
#import "ActivityCommentTableViewCell.h"
#import "InputTextBottom.h"
#import "MWPhotoBrowser.h"
@interface ActivityDetailViewController ()<UITableViewDataSource,UITableViewDelegate,ImagePlayerViewDelegate,MWPhotoBrowserDelegate>
@property (nonatomic, strong)ImagePlayerView *bannerView;
@property(nonatomic,strong)UIButton *collectBtn;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,strong)UIButton *joinBtn;
@property(nonatomic,strong)UIView *bootomView;
@property(nonatomic,strong)InputTextBottom *inputTextBottom;
@property(nonatomic,strong)NSMutableArray * photos;
@end

@implementation ActivityDetailViewController
static float BottomToolView_Height=50;
static float BottomInputView_Height=50;
static NSString *identify1=@"identify1";
static NSString *identify3=@"identify3";
static NSString *identify4=@"identify4";
static float banner_Height=150;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTable];
    self.title=@"活动详情";
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    [self initBottomView];
    [self registerForKeyboardNotifications];
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
    [_inputTextBottom setFrame:CGRectMake(_inputTextBottom.frame.origin.x, SCREEN_HEIGHT-BottomInputView_Height-kbSize.height, _inputTextBottom.frame.size.width, _inputTextBottom.frame.size.height)];
   
    
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
    self.bootomView=[[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-BottomToolView_Height, SCREEN_WIDTH, BottomToolView_Height)];
    _bootomView.backgroundColor=WHITEColor;
    self.collectBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX, offY, width, 40)];
    [_collectBtn addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_collectBtn setTitleColor:textColor forState:UIControlStateNormal];
    _collectBtn.titleLabel.font=font;
    [_collectBtn setImage:[UIImage imageNamed:@"收藏（未点）"] forState:UIControlStateNormal];
    [_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
    UIButton *commentBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX+offX2*1+width*1, offY, width, 40)];
    [commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [commentBtn setTitleColor:textColor forState:UIControlStateNormal];
    commentBtn.titleLabel.font=font;
    [commentBtn setImage:[UIImage imageNamed:@"评论icon"] forState:UIControlStateNormal];
    [commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    self.commentBtn=commentBtn;
    //
    UIButton *joinBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX+offX2*2+width*2, offY, width, 40)];
    [joinBtn addTarget:self action:@selector(joinAction:) forControlEvents:UIControlEventTouchUpInside];
    [joinBtn setTitleColor:textColor forState:UIControlStateNormal];
    joinBtn.titleLabel.font=font;
    [joinBtn setTitle:@"参加" forState:UIControlStateNormal];
    [joinBtn setImage:[UIImage imageNamed:@"参加"] forState:UIControlStateNormal];
    self.joinBtn=joinBtn;
    //
    [_bootomView addSubview:_collectBtn];
    [_bootomView addSubview:_commentBtn];
    [_bootomView addSubview:joinBtn];
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0.5)];
    [_bootomView addSubview:line];
    line.backgroundColor=Line_Color;
    [self.view addSubview:_bootomView];
//    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
//    [line setBackgroundColor:Line_Color];
}


//收藏
-(void)collectAction:(UIButton*)sender{
    [SVProgressHUD show];
    Collect_Type type=KCollect_Activity;
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID ,@"BID" ,[NSNumber numberWithInt:type],@"Type",nil];
    [HttpConnection Collection:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"已收藏"];
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"Reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
       
        
    }];
}

//评论
-(void)commentAction:(UIButton*)sender{
    if (!_inputTextBottom) {
        self.inputTextBottom=[[InputTextBottom alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-BottomInputView_Height, SCREEN_WIDTH, BottomInputView_Height)];
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


//发送
-(void)sendAction:(UIButton*)sender{
    if ([CommonFun isSpaceCharacter:_inputTextBottom.inputText.text]) {
        
        return;
    }
    [SVProgressHUD show];
    Collect_Type type=KCollect_Activity;
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BeID",[NSNumber numberWithInt:type],@"Type",_inputTextBottom.inputText.text,@"Message",nil];
    [HttpConnection Comments:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"评论成功"];
                _inputTextBottom.inputText=nil;
                [_inputTextBottom.inputText resignFirstResponder];
            }
            else{
                [SVProgressHUD showSuccessWithStatus:[response objectForKey:@"Reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        
    }];
}

//参加
-(void)joinAction:(UIButton*)sender{

}
-(void)backAction{
    myTable.delegate=nil;
    myTable.dataSource=nil;
//    [_bannerView  removeObserver:self forKeyPath:@"bounds"];
    _bannerView.imagePlayerViewDelegate=nil;
    _bannerView=nil;
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)initTable{
//    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"HeaderTableViewCell" bundle:nil] forCellReuseIdentifier:identify1];
    [myTable registerClass:[ActivityDetailTableViewCell class] forCellReuseIdentifier:identify3];
    [myTable registerClass:[ActivityCommentTableViewCell class] forCellReuseIdentifier:identify4];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 65;
    }
    else if(indexPath.section==1){
        return banner_Height;
    }
    else if(indexPath.section==2){
        return 150+50;
    }
    return 45;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 3;
    return 2+1+1;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *identify2=@"identify2";
 
    if (indexPath.section==0) {
        HeaderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify1 forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//        HeaderTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify1];
//        if (!cell) {
//            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"HeaderTableViewCell" owner:nil options:nil];
//            cell = [nibs lastObject];
//        }
        return cell;
    }
    else if(indexPath.section==1){
        UITableViewCell *cell2=[tableView dequeueReusableCellWithIdentifier:identify2];
        if (!cell2) {
            cell2=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify2];
            cell2.selectionStyle=UITableViewCellSelectionStyleNone;
            [self initBanner];
            [cell2.contentView addSubview:_bannerView];
        }
        return cell2;
    }
    else if(indexPath.section==2){
        ActivityDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify3 forIndexPath:indexPath];
        [cell setInfo:_info];
        [cell setNeedsLayout];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell updateConstraintsIfNeeded];
        return cell;
    }
    else if(indexPath.section==3){
        ActivityCommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify4 forIndexPath:indexPath];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_inputTextBottom.inputText resignFirstResponder];
}
-(void)initBanner{
//    if (!_bannerView) {
        _bannerView = [[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 180)];
        _bannerView.imagePlayerViewDelegate = self;
        _bannerView.scrollInterval = 4.0f;
        _bannerView.pageControlPosition = ICPageControlPosition_BottomCenter;
        _bannerView.frame=CGRectMake(0, 0, SCREEN_WIDTH, banner_Height);
//    }
 
    [_bannerView reloadData];
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

-(void)dealloc{
 
    
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
