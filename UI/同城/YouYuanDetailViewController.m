//
//  YouYuanDetailViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/24.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "YouYuanDetailViewController.h"
#import "YouYuanDetailTableViewCell.h"
#import "InputTextBottom.h"
@interface YouYuanDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIView *bootomView;
@property(nonatomic,strong)InputTextBottom *inputTextBottom;
@property(nonatomic,strong)UIButton *collectBtn;
@property(nonatomic,strong)UIButton *commentBtn;
@property(nonatomic,strong)UIButton *joinBtn;
@end

@implementation YouYuanDetailViewController
static NSString *identifer=@"identifer";
static float BottomToolView_Height=50;
static float BottomInputView_Height=50;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"友园";
    [self initTableView];
    [self initBottomView];
    [self registerForKeyboardNotifications];
    
}

-(void)initTableView{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 400;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YouYuanDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell=[[YouYuanDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    [cell setInfo:nil];
    return cell;
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
    self.commentBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX+offX2*1+width*1, offY, width, 40)];
    [_commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [_commentBtn setTitleColor:textColor forState:UIControlStateNormal];
    _commentBtn.titleLabel.font=font;
    [_commentBtn setImage:[UIImage imageNamed:@"评论icon"] forState:UIControlStateNormal];
    [_commentBtn setTitle:@"评论" forState:UIControlStateNormal];
    //
    self.joinBtn=[[UIButton alloc] initWithFrame:CGRectMake(offX+offX2*2+width*2, offY, width, 40)];
    [_joinBtn addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchUpInside];
    [_joinBtn setTitleColor:textColor forState:UIControlStateNormal];
    _joinBtn.titleLabel.font=font;
    [_joinBtn setTitle:@"看好" forState:UIControlStateNormal];
    [_joinBtn setImage:[UIImage imageNamed:@"看好(未点)"] forState:UIControlStateNormal];
    //
    [_bootomView addSubview:_collectBtn];
    [_bootomView addSubview:_commentBtn];
    [_bootomView addSubview:_joinBtn];
    UIView *line=[[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, 0.5)];
    [_bootomView addSubview:line];
    line.backgroundColor=Line_Color;
    [self.view addSubview:_bootomView];
    //    UIView *line2=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    //    [line setBackgroundColor:Line_Color];
}

-(void)collectAction:(UIButton*)sender{
    [SVProgressHUD show];
    Collect_Type type=KCollect_YouYuan;
//    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BeID",[NSNumber numberWithInt:type],@"Type",_inputTextBottom.inputText.text,@"Message",nil];
//    [HttpConnection Comments:dic WithBlock:^(id response, NSError *error) {
//        if (!error) {
//            if ([[response objectForKey:@"ok"] boolValue]) {
//                [SVProgressHUD showSuccessWithStatus:@"评论成功"];
//                _inputTextBottom.inputText=nil;
//                [_inputTextBottom.inputText resignFirstResponder];
//            }
//            else{
//                [SVProgressHUD showSuccessWithStatus:[response objectForKey:@"Reason"]];
//            }
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:ErrorMessage];
//        }
//        
//    }];
}
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

//赞
-(void)praiseAction:(UIButton*)sender{
    
}

//发送
-(void)sendAction:(UIButton*)sender{
    if ([CommonFun isSpaceCharacter:_inputTextBottom.inputText.text]) {
        
        return;
    }
    [SVProgressHUD show];
    Collect_Type type=KCollect_YouYuan;
//    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BeID",[NSNumber numberWithInt:type],@"Type",_inputTextBottom.inputText.text,@"Message",nil];
//    [HttpConnection Comments:dic WithBlock:^(id response, NSError *error) {
//        if (!error) {
//            if ([[response objectForKey:@"ok"] boolValue]) {
//                [SVProgressHUD showSuccessWithStatus:@"评论成功"];
//                _inputTextBottom.inputText=nil;
//                [_inputTextBottom.inputText resignFirstResponder];
//            }
//            else{
//                [SVProgressHUD showSuccessWithStatus:[response objectForKey:@"Reason"]];
//            }
//        }
//        else{
//            [SVProgressHUD showErrorWithStatus:ErrorMessage];
//        }
//        
//    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_inputTextBottom.inputText resignFirstResponder];
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
