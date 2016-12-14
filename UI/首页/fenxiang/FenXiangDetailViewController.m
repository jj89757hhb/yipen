//
//  FenXiangDetailViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/17.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "FenXiangDetailViewController.h"
#import "FenXiangTableViewCell.h"
#import "PersonalHomeViewController.h"
#import "InputTextBottom.h"
#import "BuyView.h"
#import "OfferPriceView.h"
#import "WillBuyViewController.h"
#import "OfferPriceTableViewCell.h"
#import "NegotiatePriceView.h"
#import "AuctionRecordTableViewCell.h"
#import "CommentInfo.h"
#import "MWPhotoBrowser.h"
#import <RongIMKit/RongIMKit.h>
#import "ShareView.h"
@interface FenXiangDetailViewController ()<UITableViewDataSource,UITableViewDelegate,FenXiangTableViewDeleagte,MWPhotoBrowserDelegate>
@property(nonatomic,strong)NSMutableArray *commentList;
@property(nonatomic,strong)NSMutableArray *auctionRecordList;//出价列表
@property(nonatomic,strong)BottomToolView *bottomToolView;
@property(nonatomic,strong)InputTextBottom *inputTextBottom;
@property(nonatomic,strong)BuyView *buyView;
@property(nonatomic,weak)NSIndexPath *indexPath;
@property(nonatomic,strong)NSMutableArray *photos;
@property(nonatomic,strong)ShareView *shareView;

@end

@implementation FenXiangDetailViewController
static NSString *identity=@"cell";
static NSString *cellIdentify=@"OfferPriceTableViewCell";
static NSString *AuctionRecord_cellIdentify=@"AuctionRecordTableViewCell";
static NSInteger pageNum=10;//每页
static float BottomInputView_Height=50;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain  target:self action:@selector(shareAction)];
    self.title=@"详情";
    self.commentList=[[NSMutableArray alloc] init];
    self.auctionRecordList=[[NSMutableArray alloc] init];
    [self initTable];
    [self requestData];
//    self.bottomToolView=[[BottomToolView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-BottomToolView_Height, SCREEN_WIDTH, BottomToolView_Height)];
    self.bottomToolView=[[BottomToolView alloc] init];

    [self.view addSubview:_bottomToolView];
    _bottomToolView.backgroundColor=WHITEColor;
    [_bottomToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(BottomToolView_Height);
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
    }];
    [_bottomToolView.praiseBtn addTarget:self action:@selector(praiseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomToolView.collectBtn addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomToolView.commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomToolView.chatBtn addTarget:self action:@selector(chatAction:) forControlEvents:UIControlEventTouchUpInside];
    [self registerForKeyboardNotifications];
    if ([_info.InfoType isEqualToString:@"2"]) {//出售
        [self initSaleView];
    }
    else if ([_info.InfoType isEqualToString:@"3"]){//拍卖
        currentPage=1;
        [self queryOfferPriceList];
    }
    [self refreshBottomView];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
    if (self.isPopKeyBoard) {
        //        [self commentAction:nil];
        [self performSelector:@selector(commentAction:) withObject:nil afterDelay:1.0];
    }
   
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)refreshBottomView{
    if ([_info.IsCollect boolValue]) {
        [_bottomToolView.collectBtn setImage:[UIImage imageNamed:@"收藏（已点）"] forState:UIControlStateNormal];
    }
    else {
        [_bottomToolView.collectBtn setImage:[UIImage imageNamed:@"收藏（未点）"] forState:UIControlStateNormal];
    }
    if ([_info.IsPraise boolValue]) {
        [_bottomToolView.praiseBtn setImage:[UIImage imageNamed:@"看好(已点)"] forState:UIControlStateNormal];
        
    }
    else{
        [_bottomToolView.praiseBtn setImage:[UIImage imageNamed:@"看好(未点)"] forState:UIControlStateNormal];
    }
   
}

-(void)queryOfferPriceList{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BID", [NSNumber numberWithInteger:pageNum],@"PageSize",[NSNumber numberWithInteger:currentPage],@"Page" ,nil];
    [HttpConnection GetAuctionRecord:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if (![response objectForKey:KErrorMsg]) {
                self.auctionRecordList=response[KDataList];
                
                [myTable reloadData];
            }
            else{
//                [SVProgressHUD showInfoWithStatus:[response objectForKey:KErrorMsg]];
            }
        }
    } ];
}

-(void)initSaleView{
    self.buyView=[[BuyView alloc] init];
//    NSInteger enterType=
    self.buyView.enterType = [_info.IsMarksPrice boolValue]? 0:1;
    [self.view addSubview:_buyView];
    [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(buyView_Height);
        make.bottom.offset(-(BottomToolView_Height));
    }];
    [_buyView.negotiateBtn addTarget:self action:@selector(negotiateAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buyView.askPriceBtn addTarget:self action:@selector(negotiateAction:) forControlEvents:UIControlEventTouchUpInside];
    [_buyView.buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)shareAction{
        _shareView=[[ShareView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _shareView.backgroundColor= [[UIColor blackColor] colorWithAlphaComponent:0.5];
       _shareView.imageUrls=_info.Attach;
        [[UIApplication sharedApplication].keyWindow  addSubview:_shareView];
}
-(void)initAuctionView{
//    self.buyView=[[BuyView alloc] init];
//    [self.view addSubview:_buyView];
//    [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.offset(0);
//        make.right.offset(0);
//        make.height.offset(buyView_Height);
//        make.bottom.offset(-(BottomToolView_Height));
//    }];
//    [_buyView.negotiateBtn addTarget:self action:@selector(negotiateAction) forControlEvents:UIControlEventTouchUpInside];
//    [_buyView.buyBtn addTarget:self act
    
}


//议价 或 询价
-(void)negotiateAction:(UIButton *)sender{
    if ([[DataSource sharedDataSource].userInfo.ID isEqualToString:_info.UID]) {
        [SVProgressHUD showInfoWithStatus:@"不能购买自己的商品"];
        return;
    }
    Negotiate_Type negotiate_Type=KAsk_Price_buyer;
    Buy_Result result=KNegotiate;
    NSString *msg=@"已提交议价，请耐心等待对方的答复";
    if ([sender isEqual:_buyView.askPriceBtn]) {//询价
//        negotiate_Type=KAsk_Price_buyer;
        msg=@"已提交询价，请耐心等待对方的答复";
        [SVProgressHUD show];
        //tranNo  IsMark
        int tranNo=-1;//交易号,首次询价填-1，以后回价根据系统返回串号
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_info.userInfo.ID,@"toUser",_info.ID,@"BID",[DataSource sharedDataSource].userInfo.ID,@"fromUser",[NSNumber numberWithInt:result],@"Result", [NSNumber numberWithInt:negotiate_Type],@"Status",_info.IsMarksPrice,@"IsMark",[NSNumber numberWithInt:tranNo],@"tranNo",@"0",@"OfferPrice", nil];
        [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showInfoWithStatus:msg];
                }
                else{
                    [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
                }
            }
            else{
                [SVProgressHUD showInfoWithStatus:ErrorMessage];
            }
            
        }];

    }
    else{
        NegotiatePriceView *view=[[NegotiatePriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [view initViewWithPrice:_info.Price isNegotiate:YES];
        view.backgroundColor=[BLACKCOLOR colorWithAlphaComponent:0.7];
        [AppDelegateInstance.window addSubview:view];
        [view setNegotiatePriceBlock:^(id sender){
            [SVProgressHUD show];
            //tranNo  IsMark
            
            int tranNo=-1;//交易号,首次询价填-1，以后回价根据系统返回串号
            NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_info.userInfo.ID,@"toUser",_info.ID,@"BID",[DataSource sharedDataSource].userInfo.ID,@"fromUser",sender,@"OfferPrice",[NSNumber numberWithInt:result],@"Result", [NSNumber numberWithInt:negotiate_Type],@"Status",_info.IsMarksPrice,@"IsMark",[NSNumber numberWithInt:tranNo],@"tranNo", nil];
            [HttpConnection PostBargaining:dic WithBlock:^(id response, NSError *error) {
                if (!error) {
                    if ([[response objectForKey:@"ok"] boolValue]) {
                        [SVProgressHUD showInfoWithStatus:msg];
                        [view removeFromSuperview];
                    }
                    else{
                        [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
                    }
                }
                else{
                    [SVProgressHUD showInfoWithStatus:ErrorMessage];
                }
                
            }];
        }];

    }
   }

//购买
-(void)buyAction{
    if ([[DataSource sharedDataSource].userInfo.ID isEqualToString:_info.UID]) {
        [SVProgressHUD showInfoWithStatus:@"不能购买或询价自己的商品"];
        return;
    }
    WillBuyViewController *ctr=[[WillBuyViewController alloc] init];
    ctr.info=_info;
    ctr.saleUser=_info.userInfo;
    ctr.totalPrice=[NSString stringWithFormat:@"%.2f",[_info.Price floatValue] + [_info.MailFee floatValue]];
    [self.navigationController pushViewController:ctr animated:YES];
}


//点赞
-(void)praiseAction:(UIButton*)sender{
    [SVProgressHUD show];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BeID",@"1",@"Type",_info.userInfo.ID,@"buid", nil];
    if (![_info.IsPraise boolValue]) {
        [HttpConnection Praised:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showInfoWithStatus:@"已赞"];
                    _info.IsPraise=@"1";
                    [self refreshBottomView];
                    
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
    else {
        
        [HttpConnection CancelPraised:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showInfoWithStatus:@"取消看好"];
                    _info.IsPraise=@"0";
                    [self refreshBottomView];
                    
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

-(void)collectAction:(UIButton*)sender{
    [SVProgressHUD show];
    if (![_info.IsCollect boolValue]) {
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BeID",@"1",@"Type", nil];
        [HttpConnection Collection:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                [SVProgressHUD showInfoWithStatus:@"已收藏"];
                _info.IsCollect=@"1";
                [self refreshBottomView];
            }
            else{
                [SVProgressHUD showErrorWithStatus:ErrorMessage];
            }
            
        }];
    }
    else{
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BeID",@"1",@"Type", nil];
        [HttpConnection DelCollect:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                [SVProgressHUD showInfoWithStatus:@"已取消收藏"];
                _info.IsCollect=@"0";
                [self refreshBottomView];
            }
            else{
                [SVProgressHUD showErrorWithStatus:ErrorMessage];
            }
            
        }];
    };
    
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
    
    [_bottomToolView setHidden:YES];
}

//发送
-(void)sendAction:(UIButton*)sender{
    if ([CommonFun isSpaceCharacter:_inputTextBottom.inputText.text]) {
        
        return;
    }
    [SVProgressHUD show];
    Collect_Type type=KCollect_Penjin;
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BeID",[NSNumber numberWithInt:type],@"Type",_inputTextBottom.inputText.text,@"Message",nil];
    [HttpConnection Comments:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
                [SVProgressHUD showSuccessWithStatus:@"评论成功"];
                CommentInfo *info=[[CommentInfo alloc] init];
                info.Message= _inputTextBottom.inputText.text;
                info.NickName=[DataSource sharedDataSource].userInfo.NickName;
                [self.info.Comment addObject:info];
                [myTable reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
                [_inputTextBottom.inputText resignFirstResponder];
                   _inputTextBottom.inputText.text=@"";
              
          
                
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

-(void)chatAction:(UIButton*)sender{
    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = _info.UID;
    //设置聊天会话界面要显示的标题
    chat.title = _info.userInfo.NickName;
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-BottomToolView_Height) style:UITableViewStyleGrouped];
    [myTable registerClass:[FenXiangTableViewCell class] forCellReuseIdentifier:identity];
    [myTable registerNib:[UINib nibWithNibName:@"OfferPriceTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentify];
    [myTable registerNib:[UINib nibWithNibName:@"AuctionRecordTableViewCell" bundle:nil] forCellReuseIdentifier:AuctionRecord_cellIdentify];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    
}

-(void)requestData{
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([_info.InfoType isEqualToString:@"3"]) {//拍卖
           return 3;
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else if (section==1){
    if ([_info.InfoType isEqualToString:@"3"]) {//拍卖
        return 1;
    }
    else{
        return _commentList.count;

       }
    }
    else if(section==2){//拍卖记录
        return _auctionRecordList.count;
    }
    return _commentList.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        float comment_Height=0;
        float content_Height=0;
        if (_info.Comment.count) {//计算评论高度
            for (int i=0; i<_info.Comment.count; i++) {
                CommentInfo *comment=_info.Comment[i];
                comment_Height+=  [CommonFun sizeWithString:comment.Message font:[UIFont systemFontOfSize:comment_FontSize] size:CGSizeMake(SCREEN_WIDTH-15+10*2, MAXFLOAT)].height;
            }
            
        }
        if (_info.Descript.length) {
            content_Height+= [CommonFun sizeWithString:_info.Descript font:[UIFont systemFontOfSize:content_FontSize] size:CGSizeMake(SCREEN_WIDTH-15-10*2, MAXFLOAT)].height;
        }
            return 380+50+comment_Height+content_Height;
    }
     else if (indexPath.section==1){
         if ([_info.InfoType isEqualToString:@"3"]) {//拍卖
             return 120;
         }
           return 50;
     }
    else if(indexPath.section==2){//拍卖记录
        return 65;
    }
    return 50;

}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        FenXiangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identity];
        cell.delegate=self;
        cell.indexPath=indexPath;
        cell.isDetail=YES;
        [cell setInfo:_info];
        [cell setClickBlock:^(id sender){
            NSLog(@"点击头像");
//              self.indexPath=indexPath;
            PersonalHomeViewController *ctr=[[PersonalHomeViewController alloc] init];
            //        [self hideTabBar:YES animated:NO];
            ctr.userInfo=_info.userInfo;
            [self hideTabBar:YES animated:NO];
            [self.navigationController pushViewController:ctr animated:YES];
            
        }];
        [cell setAttentionBlock:^(id sender){
            [self attentionAction:_info];
        }];
        
        [cell setCommentBlock:^(id sender){
            NSLog(@"setCommentBlock");
        }];
        
//        [cell setChatBlock:^(id sender){
//            NSLog(@"setChatBlock");
////            self.indexPath=indexPath;
//            [self msgAction:nil];
//        }];
        [cell updateConstraintsIfNeeded];
        [cell layoutIfNeeded];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return  cell;
    }
    else {
        if ([_info.InfoType isEqualToString:@"3"]) {//拍卖
            if (indexPath.section==1) {
                OfferPriceTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentify forIndexPath:indexPath];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                [cell setInfo:_info];
                [cell.offerPriceBtn addTarget:self action:@selector(priceAction) forControlEvents:UIControlEventTouchUpInside];
                return cell;
            }
            else{
                AuctionRecordTableViewCell *cell=[tableView  dequeueReusableCellWithIdentifier:AuctionRecord_cellIdentify forIndexPath:indexPath];
                cell.selectionStyle=UITableViewCellSelectionStyleNone;
                cell.indexPath=indexPath;
                [cell setRecord:_auctionRecordList[indexPath.row]];
                return cell;
            }
            
        }
        else{
            
         
            UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
            if (!cell) {
                cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            }
            return cell;
        }
    
    }
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)msgAction:(PenJinInfo*)info{

    //新建一个聊天会话View Controller对象
    RCConversationViewController *chat = [[RCConversationViewController alloc]init];
    //设置会话的类型，如单聊、讨论组、群聊、聊天室、客服、公众服务会话等
    chat.conversationType = ConversationType_PRIVATE;
    //设置会话的目标会话ID。（单聊、客服、公众服务会话为对方的ID，讨论组、群聊、聊天室为会话的ID）
    chat.targetId = info.UID;
    //设置聊天会话界面要显示的标题
    chat.title = info.userInfo.NickName;
    //显示聊天会话界面
    [self.navigationController pushViewController:chat animated:YES];
}

//关注 取消关注
-(void)attentionAction:(PenJinInfo*)pinfo{
    [SVProgressHUD show];
    YPUserInfo *info = pinfo.userInfo;
    if (![info.IsFocus boolValue]) {
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",info.ID,@"BUID", nil];
        [HttpConnection Focus:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showInfoWithStatus:@"已关注"];
                    info.IsFocus=@"1";
                    [myTable reloadData];
                    
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
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",info.ID,@"BUID", nil];
        [HttpConnection CancelFocus:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showInfoWithStatus:@"已取消关注"];
                    info.IsFocus=@"0";
                    [myTable reloadData];
                    
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
//    [UIView beginAnimations:nil context:NULL];
//    [UIView setAnimationDuration:animationDuration];
//    [_inputTextBottom setFrame:CGRectMake(_inputTextBottom.frame.origin.x, SCREEN_HEIGHT-BottomInputView_Height-kbSize.height-64, _inputTextBottom.frame.size.width, _inputTextBottom.frame.size.height)];
//
//    [UIView commitAnimations];
//    [UIView animateWithDuration:animationDuration animations:^{
//          [_inputTextBottom setFrame:CGRectMake(_inputTextBottom.frame.origin.x, SCREEN_HEIGHT-BottomInputView_Height-kbSize.height-64, _inputTextBottom.frame.size.width, _inputTextBottom.frame.size.height)];
//    }];
    [UIView animateWithDuration:animationDuration animations:^{
         [_inputTextBottom setFrame:CGRectMake(_inputTextBottom.frame.origin.x, SCREEN_HEIGHT-BottomInputView_Height-kbSize.height-64, _inputTextBottom.frame.size.width, _inputTextBottom.frame.size.height)];
    } completion:^(BOOL finished) {
       
    }];
    
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    //    _inputTextBottom.contentInset = contentInsets;
    //    _inputTextBottom.scrollIndicatorInsets = contentInsets;
    [_bottomToolView setHidden:NO];
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

//出价
-(void)priceAction{
    
    OfferPriceView *view=[[OfferPriceView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [view initViewWithPrice:_info.APrice];
    view.MakeUp=_info.MakeUp;
    
    view.backgroundColor=[BLACKCOLOR colorWithAlphaComponent:0.7];
    [AppDelegateInstance.window addSubview:view];
    WS(weakSelf)
    [view setOfferPriceBlock:^(id sender){
        if ([sender floatValue]<[_info.APrice floatValue]) {
            [SVProgressHUD showInfoWithStatus:@"出价不能低于当前最高价"];
            return ;
        }
        [SVProgressHUD show];
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BID",sender, @"OfferPrice", nil];
        [HttpConnection PostAuction:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                     [SVProgressHUD showInfoWithStatus:@"出价成功"];
                    [view removeFromSuperview];
                    [weakSelf queryOfferPriceList];//再次刷新
                }
                else{
                     [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
                }
               
            }
            else{
                [SVProgressHUD showInfoWithStatus:ErrorMessage];
            }
        }];
    }];
    
    [view setAddPriceBlock:^(id sender){
        [SVProgressHUD show];
        float priceF=[_info.APrice floatValue]+[_info.MakeUp floatValue];
        NSString *price=[NSString stringWithFormat:@"%f",priceF];
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BID",price, @"OfferPrice", nil];
        [HttpConnection PostAuction:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([[response objectForKey:@"ok"] boolValue]) {
                    [SVProgressHUD showInfoWithStatus:@"出价成功"];
                }
                else{
                    [SVProgressHUD showInfoWithStatus:[response objectForKey:@"reason"]];
                }
                
            }
            else{
                [SVProgressHUD showInfoWithStatus:ErrorMessage];
            }
        }];

    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
       [_inputTextBottom.inputText resignFirstResponder];
}


//-(void)praisedAction:(PenJinInfo*)info{
//    [SVProgressHUD show];
//    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",info.ID,@"BeID",@"1",@"Type",info.userInfo.ID,@"buid", nil];
//    if (![info.IsPraise boolValue]) {
//        [HttpConnection Praised:dic WithBlock:^(id response, NSError *error) {
//            if (!error) {
//                if ([[response objectForKey:@"ok"] boolValue]) {
//                    [SVProgressHUD showInfoWithStatus:@"看好"];
//                    info.IsPraise=@"1";
//                    [self reloadTableAtIndex];
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
//    }
//    else{
//        [HttpConnection CancelPraised:dic WithBlock:^(id response, NSError *error) {
//            if (!error) {
//                if ([[response objectForKey:@"ok"] boolValue]) {
//                    [SVProgressHUD showInfoWithStatus:@"取消看好"];
//                    info.IsPraise=@"0";
//                    [self reloadTableAtIndex];
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
//    }
//  
//}


-(void)reloadTableAtIndex{
//    [myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:_indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)tapImageViewWithCellIndex:(NSIndexPath *)indexPath imageIndex:(NSInteger)index{
//    self.photos=_info.Attach;
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
