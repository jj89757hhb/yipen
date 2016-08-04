//
//  MessageExchangeTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MessageExchangeTableViewCell.h"
#import "BDetail.h"
@implementation MessageExchangeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.aggreeBtn=[[UIButton alloc] init];
    self.aggreeBtn.layer.cornerRadius=3;
    self.aggreeBtn.clipsToBounds=YES;
    self.aggreeBtn.layer.borderWidth=0.5;
    self.aggreeBtn.layer.borderColor=GRAYCOLOR.CGColor;
    self.aggreeBtn.layer.cornerRadius=3;
    [_aggreeBtn addTarget:self action:@selector(aggreeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_aggreeBtn];
    [_aggreeBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    _aggreeBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    
    self.refuseBtn=[[UIButton alloc] init];
    self.refuseBtn.clipsToBounds=YES;
    self.refuseBtn.layer.borderWidth=0.5;
    self.refuseBtn.layer.borderColor=GRAYCOLOR.CGColor;
    self.refuseBtn.layer.cornerRadius=3;
    [self.contentView addSubview:_refuseBtn];
    [_refuseBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
     _refuseBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    
    self.replyPriceBtn=[[UIButton alloc] init];
    self.replyPriceBtn.clipsToBounds=YES;
    self.replyPriceBtn.layer.borderWidth=0.5;
    self.replyPriceBtn.layer.borderColor=GRAYCOLOR.CGColor;
    self.replyPriceBtn.layer.cornerRadius=3;
    _replyPriceBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [_replyPriceBtn addTarget:self action:@selector(replyPriceAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_replyPriceBtn];
     [_replyPriceBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    
    self.orderBtn=[[UIButton alloc] init];
    [_orderBtn addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_orderBtn];
    [_orderBtn setTitle:@"查看订单" forState:UIControlStateNormal];
    [_orderBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    [_orderBtn setBackgroundColor:RedColor];
    _orderBtn.clipsToBounds=YES;
    _orderBtn.layer.cornerRadius=3;
    _orderBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    _headIV.layer.cornerRadius=30;
    _headIV.clipsToBounds=YES;
    
    
    self.negotiatedBtn=[[UIButton alloc] init];
    [self.contentView addSubview:_negotiatedBtn];
    [_negotiatedBtn setTitle:@"已议价" forState:UIControlStateNormal];
    [_negotiatedBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    [_negotiatedBtn setBackgroundColor:GRAYCOLOR];
    _negotiatedBtn.clipsToBounds=YES;
    _negotiatedBtn.layer.cornerRadius=3;
    _negotiatedBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    
    self.negotiatedFailBtn=[[UIButton alloc] init];
    [self.contentView addSubview:_negotiatedFailBtn];
    [_negotiatedFailBtn setTitle:@"议价失败" forState:UIControlStateNormal];
    [_negotiatedFailBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    [_negotiatedFailBtn setBackgroundColor:GRAYCOLOR];
    _negotiatedFailBtn.clipsToBounds=YES;
    _negotiatedFailBtn.layer.cornerRadius=3;
    _negotiatedFailBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    
    
    self.buyBtn=[[UIButton alloc] init];
    [self.contentView addSubview:_buyBtn];
    [_buyBtn setTitle:@"购 买" forState:UIControlStateNormal];
    [_buyBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
    [_buyBtn setBackgroundColor:RedColor];
    _buyBtn.clipsToBounds=YES;
    _buyBtn.layer.cornerRadius=3;
    _buyBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [_buyBtn addTarget:self action:@selector(buyAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.offerPriceBtn=[[UIButton alloc] init];
    [self.contentView addSubview:_offerPriceBtn];
    [_offerPriceBtn setTitle:@"报 价" forState:UIControlStateNormal];
    [_offerPriceBtn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    [_offerPriceBtn setBackgroundColor:WHITEColor];
    _offerPriceBtn.clipsToBounds=YES;
    _offerPriceBtn.layer.cornerRadius=3;
    _offerPriceBtn.titleLabel.font=[UIFont systemFontOfSize:13];
    [_offerPriceBtn addTarget:self action:@selector(offerPriceAction) forControlEvents:UIControlEventTouchUpInside];
        [_offerPriceBtn setHidden:YES];
    _offerPriceBtn.layer.borderWidth=0.5;
    _offerPriceBtn.layer.borderColor=GRAYCOLOR.CGColor;
    
    [_refuseBtn addTarget:self action:@selector(refuseAction) forControlEvents:UIControlEventTouchUpInside];
    _treeIV.clipsToBounds=YES;
    _treeIV.contentMode=UIViewContentModeScaleAspectFill;
//       [_priceL setHidden:YES];
    
  
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(ExchangeInfo *)info{
    _info=info;
    _originPriceL.text=[NSString stringWithFormat:@"原价:¥%@",info.Bonsai.Price];
    if (![_info.Bonsai.IsMarksPrice boolValue]) {//不明价
        _originPriceL.text=@"原价:不明价";
    }
    _titleL.text=info.Bonsai.Title;
    _contentL.text=info.Bonsai.Descript;
    if (info.Bonsai.Attach.count) {
        [_treeIV sd_setImageWithURL:[NSURL URLWithString:info.Bonsai.Attach[0]] placeholderImage:Default_Image];
    }
    _viewL.text=[NSString stringWithFormat:@"浏览%@",info.Bonsai.BrowseNum];
    _praiseL.text=[NSString stringWithFormat:@"赞%@",info.Bonsai.PraisedNum];
    _commentL.text=[NSString stringWithFormat:@"评论%@",info.Bonsai.CommentsNum];

    NSLog(@"1111:%d",info.Result);
 
    _timeL.text=info.CreateTime;
    [_negotiatedFailBtn setHidden:YES];
    [_buyBtn setTitle:@"购 买" forState:UIControlStateNormal];
    _buyBtn.titleLabel.font=[UIFont systemFontOfSize:13];
     _replyL.text=@"接受对宝贝的议价";
    [_replyL setHidden:NO];
    //我是购买者
    if ([_info.BuyUser.ID isEqualToString:[DataSource  sharedDataSource].userInfo.ID]) {
       
        [_headIV sd_setImageWithURL:[NSURL URLWithString:info.SaleUser.UserHeader] placeholderImage:Default_Image];
        _nameL.text=info.SaleUser.NickName;
        [_buyBtn setHidden:NO];
        [_aggreeBtn setHidden:YES];
        [_refuseBtn setHidden:YES];
        [_replyPriceBtn setHidden:YES];
        [_negotiatedBtn setHidden:YES];
        [_offerPriceBtn setHidden:YES];
        [_orderBtn setHidden:YES];
        if (_info.Result==KNegotiate) {
            [_orderBtn setHidden:YES];
            [_aggreeBtn setHidden:YES];
            [_refuseBtn setHidden:YES];
            [_replyPriceBtn setHidden:YES];
            [_negotiatedBtn setHidden:NO];
            if ([_info.Phase integerValue]==1&&[_info.Bonsai.IsMarksPrice boolValue]) {//明价的：买家已经议价
                //             _replyL.text=@"对宝贝进行了议价";
                [_replyL setHidden:YES];
                [_negotiatedBtn setHidden:NO];
                _originPriceL.text=[NSString stringWithFormat:@"原价：¥%@>议价：¥%@",_info.Bonsai.Price,_info.NAmount];
                [_orderBtn setHidden:YES];
                [_aggreeBtn setHidden:YES];
                [_refuseBtn setHidden:YES];
                [_replyPriceBtn setHidden:YES];
                [_buyBtn setHidden:YES];
                
            }
            
            else  if ([_info.Phase integerValue]==1&&![_info.Bonsai.IsMarksPrice boolValue]) {//不明价的：买家已经询价
                _replyL.text=@"对宝贝进行了询价";
                [_replyL setHidden:YES];
                //            [_replyL setHidden:YES];
                [_negotiatedBtn setHidden:NO];
                _originPriceL.text=[NSString stringWithFormat:@"原价：不明价"];
                [_orderBtn setHidden:YES];
                [_aggreeBtn setHidden:YES];
                [_refuseBtn setHidden:YES];
                [_replyPriceBtn setHidden:YES];
                [_buyBtn setHidden:YES];
                [_originPriceL setHidden:YES];
                [_negotiatedBtn setTitle:@"已询价" forState:UIControlStateNormal];
                [_negotiatedBtn setHidden:NO];
                [_originPriceL setHidden:NO];
                
            }
            
            else if ([_info.Phase integerValue]==2&&![_info.Bonsai.IsMarksPrice boolValue]) {//不明价的 此时买家操作： 购买 放弃  议价
                _replyL.text=@"对宝贝进行了报价";
                [_orderBtn setHidden:YES];
                [_aggreeBtn setHidden:NO];
                [_aggreeBtn setTitle:@"购买" forState:UIControlStateNormal];
                [_aggreeBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
                [_aggreeBtn setBackgroundColor:RedColor];
                [_refuseBtn setHidden:NO];
                [_refuseBtn setTitle:@"放弃" forState:UIControlStateNormal];
                [_replyPriceBtn setHidden:NO];
                [_replyPriceBtn setTitle:@"议价" forState:UIControlStateNormal];
                [_negotiatedBtn setHidden:YES];
                [_buyBtn setHidden:YES];
                _originPriceL.text=[NSString stringWithFormat:@"报价：¥%@",_info.NAmount];
            }
            else if([_info.Phase integerValue]==3&&![_info.Bonsai.IsMarksPrice boolValue]){//不明价 买家已议价,等待卖家答复
                _replyL.text=@"对宝贝进行了议价";
                [_orderBtn setHidden:YES];
                [_aggreeBtn setHidden:YES];//xib中的隐藏
//                [_aggreeBtn setTitle:@"购买" forState:UIControlStateNormal];
                [_aggreeBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
                [_aggreeBtn setBackgroundColor:RedColor];
                [_refuseBtn setHidden:YES];
                [_refuseBtn setTitle:@"放弃" forState:UIControlStateNormal];
//                [_replyPriceBtn setTitle:@"议价" forState:UIControlStateNormal];
                [_negotiatedBtn setHidden:NO];
                [_replyPriceBtn setHidden:YES];
                [_buyBtn setHidden:YES];
//                _originPriceL.text=@"原价：不明价";
                [_originPriceL setHidden:NO];
                BDetail  *price1=nil;
                BDetail *price2=nil;
                if (_info.BDetails.count>=3) {
                    price1=_info.BDetails[1];
                    price2 =_info.BDetails[2];
                }
                _originPriceL.text=[NSString stringWithFormat:@"报价：¥%@>议价：¥%@",price1.NAmount,price2.NAmount];
                [_negotiatedBtn setTitle:@"已议价" forState:UIControlStateNormal];
                
                
            }
            
            else if([_info.Phase integerValue]==2&&[_info.Bonsai.IsMarksPrice boolValue]){//明价 卖家已回价
                _replyL.text=@"对宝贝议价进行了回价";
                [_orderBtn setHidden:YES];
                [_aggreeBtn setHidden:YES];
                [_refuseBtn setHidden:NO];
                [_replyPriceBtn setHidden:YES];
                [_negotiatedBtn setHidden:YES];
                [_buyBtn setHidden:NO];
                BDetail  *price1=nil;
                BDetail *price2=nil;
                if (_info.BDetails.count>=2) {
                    price1=_info.BDetails[0];
                    price2 =_info.BDetails[1];
                }
                _originPriceL.text=[NSString stringWithFormat:@"原价：¥%@>议价：¥%@>回价：¥%@",_info.Bonsai.Price,price1.NAmount,price2.NAmount];
                //            [_priceL setHidden:YES];
              
                
                
            }
            else if([_info.Phase integerValue]==4&&![_info.Bonsai.IsMarksPrice boolValue]){//不明价 卖家已回价
                _replyL.text=@"对宝贝议价进行了回价";
                [_orderBtn setHidden:YES];
                [_aggreeBtn setHidden:YES];
                [_refuseBtn setHidden:NO];
                [_replyPriceBtn setHidden:YES];
                [_negotiatedBtn setHidden:YES];
                [_buyBtn setHidden:NO];
                BDetail  *price1=nil;
                BDetail *price2=nil;
                BDetail *price3=nil;
                if (_info.BDetails.count>=4) {
                    price1=_info.BDetails[1];
                    price2 =_info.BDetails[2];
                    price3 =_info.BDetails[3];
                }
                _originPriceL.text=[NSString stringWithFormat:@"原价：¥%@>议价：¥%@>回价：¥%@",price1.NAmount,price2.NAmount,price3.NAmount];
                
                
            }
        }
        else if (_info.Result==Kgiveup) {
            [_orderBtn setHidden:YES];
            [_buyBtn setHidden:NO];
            [_buyBtn setTitle:@"原价购买" forState:UIControlStateNormal];
            _buyBtn.titleLabel.font=[UIFont systemFontOfSize:12];
              _replyL.text=@"拒绝对宝贝的议价";
            [_negotiatedFailBtn setHidden:NO];
            if ([_info.Phase integerValue]==2&&[_info.Bonsai.IsMarksPrice boolValue]) {
                BDetail  *price1=nil;
                BDetail *price2=nil;
                if (_info.BDetails.count>=2) {
                    price1=_info.BDetails[0];
                    price2 =_info.BDetails[1];
                }
                _originPriceL.text=[NSString stringWithFormat:@"原价:¥%@ >议价:¥%@",_info.Bonsai.Price,price1.NAmount];
            }
            else if ([_info.Phase integerValue]==3&&[_info.Bonsai.IsMarksPrice boolValue]) {
                [_orderBtn setHidden:YES];
                [_buyBtn setHidden:YES];
                  _replyL.text=@"对宝贝议价进行了回价";
                [_negotiatedBtn setTitle:@"已放弃" forState:UIControlStateNormal];
                [_negotiatedBtn setUserInteractionEnabled:NO];
                [_negotiatedBtn setHidden:NO];
                [_negotiatedFailBtn setHidden:YES];
                BDetail  *price1=nil;
                BDetail *price2=nil;
                if (_info.BDetails.count>=2) {
                    price1=_info.BDetails[0];
                    price2 =_info.BDetails[1];
                }
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@ >回价:¥%@",_info.Bonsai.Price,price1.NAmount,price2.NAmount];
            }
            else if([_info.Phase integerValue]==5&&
               ![_info.Bonsai.IsMarksPrice boolValue]){//
                [_orderBtn setHidden:YES];
                [_buyBtn setHidden:YES];
                _replyL.text=@"对宝贝议价进行了回价";
                [_negotiatedBtn setTitle:@"已放弃" forState:UIControlStateNormal];
                [_negotiatedBtn setUserInteractionEnabled:NO];
                [_negotiatedBtn setHidden:NO];
                [_negotiatedFailBtn setHidden:YES];
                BDetail *price1=nil;
                BDetail *price2=nil;
                BDetail *price3=nil;
                if (_info.BDetails.count>=2) {
                    price1=_info.BDetails[1];
                    price2 =_info.BDetails[2];
                    price3  =_info.BDetails[3];
                }
                
                   _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@ >回价:¥%@",price1.NAmount,price2.NAmount,price3.NAmount];
                [_originPriceL setHidden:NO];
                
            }
            else if([_info.Phase integerValue]==3&&
                    ![_info.Bonsai.IsMarksPrice boolValue]){//拒绝了报价
                [_orderBtn setHidden:YES];
                [_buyBtn setHidden:YES];
                _replyL.text=@"对宝贝进行了报价";
                [_negotiatedBtn setTitle:@"已放弃" forState:UIControlStateNormal];
                [_negotiatedBtn setUserInteractionEnabled:NO];
                [_negotiatedBtn setHidden:NO];
                [_negotiatedFailBtn setHidden:YES];
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@",_info.NAmount];
                [_originPriceL setHidden:NO];
                
            }
            else if([_info.Phase integerValue]==4&&
                    ![_info.Bonsai.IsMarksPrice boolValue]){//拒绝了议价
                BDetail  *price1=nil;
                BDetail *price2=nil;
                if (_info.BDetails.count>=2) {
                    price1=_info.BDetails[1];
                    price2 =_info.BDetails[2];
                }
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@",price1.NAmount,price2.NAmount];
            }
            
            
            
        }
        else if (_info.Result==KAgree) {
             _replyL.text=@"接受对宝贝的议价";
            [_orderBtn setHidden:YES];
            [_aggreeBtn setHidden:YES];
            [_refuseBtn setHidden:YES];
            [_replyPriceBtn setHidden:YES];
            [_negotiatedBtn setHidden:YES];
            
            if ([_info.Phase integerValue]==2&&[_info.Bonsai.IsMarksPrice boolValue]) {
                BDetail  *price1=nil;
                if (_info.BDetails.count>=2) {
                    price1=_info.BDetails[0];
                }
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@",_info.Bonsai.Price ,price1.NAmount];
            }
          
            if ([_info.Phase integerValue]==3&&
                ![_info.Bonsai.IsMarksPrice boolValue]) {
                [_orderBtn setHidden:YES];
                _replyL.text=@"对宝贝进行了报价";

                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@",_info.NAmount];
                [_originPriceL setHidden:NO];
            }
            if ([_info.Phase integerValue]==4&&
                ![_info.Bonsai.IsMarksPrice boolValue]) {//卖者接受了议价
                BDetail *price1=nil;
                BDetail *price2=nil;
                if (_info.BDetails.count>=3) {
                    price1=_info.BDetails[1];
                    price2 =_info.BDetails[2];
                }
                
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@",price1.NAmount,price2.NAmount];
                [_orderBtn setHidden:YES];
                _replyL.text=@"对宝贝进行了报价";
        
                [_originPriceL setHidden:NO];
            }
            
            
        }
        else if(_info.Result==KBuy){//购买
//              _replyL.text=@"购买了您的宝贝";
            [_replyL setHidden:YES];
            [_orderBtn setHidden:NO];
            [_aggreeBtn setHidden:YES];
            [_refuseBtn setHidden:YES];
            [_replyPriceBtn setHidden:YES];
            [_negotiatedBtn setHidden:YES];
            [_buyBtn setHidden:YES];
            _originPriceL.text=[NSString stringWithFormat:@"原价：¥%@",_info.Bonsai.Price];
            BDetail *price1=nil;
            BDetail *price2=nil;
            if (_info.BDetails.count>=3) {
                price1=_info.BDetails[1];
                price2 =_info.BDetails[2];
            }
            if ([_info.Phase integerValue]==3) {
                  _originPriceL.text=[NSString stringWithFormat:@"原价：¥%@ >议价：¥%@",_info.Bonsai.Price,price1.NAmount];
            }
//            _priceL.text=[NSString stringWithFormat:@"议价：¥%@",_info.NAmount];
        }
       
        else if([_info.Phase integerValue]==5&&[_info.Bonsai.IsMarksPrice boolValue]){//明价 买家直接购买的//            _replyL.text=@"对宝贝议价进行了回价";
            [_replyL setHidden:YES];
            [_orderBtn setHidden:YES];
            [_aggreeBtn setHidden:YES];
            [_refuseBtn setHidden:YES];
            [_replyPriceBtn setHidden:YES];
            [_negotiatedBtn setHidden:NO];
            [_negotiatedBtn setTitle:@"已购买" forState:UIControlStateNormal];
            [_buyBtn setHidden:YES];
            _originPriceL.text=[NSString stringWithFormat:@"原价：¥%@>总价：¥%@",_info.Bonsai.Price,_info.NAmount];
            
            
        }
        
    }
    else{//我是卖方
      
        [_headIV sd_setImageWithURL:[NSURL URLWithString:info.BuyUser.UserHeader] placeholderImage:Default_Image];
        _nameL.text=info.BuyUser.NickName;
        [_buyBtn setHidden:YES];
        [_offerPriceBtn setHidden:YES];
        if (_info.Result==KNegotiate) {
            [_orderBtn setHidden:YES];
            [_aggreeBtn setHidden:YES];
            [_refuseBtn setHidden:YES];
            [_replyPriceBtn setHidden:YES];
            [_negotiatedBtn setHidden:NO];
            
            if ([_info.Phase integerValue]==1&&[_info.Bonsai.IsMarksPrice boolValue]) {//明价的：买家已经议价
                 _replyL.text=@"对宝贝进行了议价";
                [_replyL setHidden:NO];
//                [_replyL setHidden:YES];
                [_negotiatedBtn setHidden:NO];
                _originPriceL.text=[NSString stringWithFormat:@"原价：¥%@>议价：¥%@",_info.Bonsai.Price,_info.NAmount];
                [_negotiatedBtn setHidden:YES];
                [_aggreeBtn setHidden:NO];
                [_refuseBtn setHidden:NO];
                [_replyPriceBtn setHidden:NO];
                [_buyBtn setHidden:YES];
                
            }
          else  if (![_info.Bonsai.IsMarksPrice boolValue]&&[_info.Phase integerValue]==1) {//不明价的 买家已询价
                  _replyL.text=@"对宝贝进行了询价";
                [_offerPriceBtn setHidden:NO];
                _originPriceL.text=@"原价:不明价";
              [_offerPriceBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
//                if ([_info.Phase intValue]==2) {
//                    [_offerPriceBtn setTitle:@"已报价" forState:UIControlStateNormal];
//                    [_offerPriceBtn setBackgroundColor:GRAYCOLOR];
//                    [_offerPriceBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
//                    [_offerPriceBtn setUserInteractionEnabled:NO];
//                    [_priceL setHidden:NO];
//                    _priceL.text=[NSString stringWithFormat:@"报价:¥%@",_info.NAmount];
//                }
              
            }
            else  if (![_info.Bonsai.IsMarksPrice boolValue]&&[_info.Phase integerValue]==2) {//不明价的  卖家已报价
                _replyL.text=@"对宝贝进行了询价";
                [_offerPriceBtn setHidden:NO];
                 _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@",_info.NAmount];
                  [_offerPriceBtn setTitle:@"已报价" forState:UIControlStateNormal];
                [_offerPriceBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
                [_offerPriceBtn setUserInteractionEnabled:NO];
                
            }
            
            else if (![_info.Bonsai.IsMarksPrice boolValue]&&[_info.Phase integerValue]==3) {//不明价的 买家已经议价（此时的操作:接受、拒绝、回价）
                [_aggreeBtn setHidden:NO];
                [_refuseBtn setHidden:NO];
                [_replyPriceBtn setHidden:NO];
                
                [_offerPriceBtn setHidden:YES];
                [_negotiatedBtn setHidden:YES];
                [_negotiatedFailBtn setHidden:YES];
                _replyL.text=@"对宝贝报价进行了议价";
//                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@",_info.Bonsai.Price,_info.NAmount];
                BDetail  *price1=nil;
                BDetail *price2=nil;
                if (_info.BDetails.count>=3) {
                    price1=_info.BDetails[1];
                    price2 =_info.BDetails[2];
                }
                [_originPriceL setHidden:NO];
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@",price1.NAmount,price2.NAmount];
                
            }
            
            else if (![_info.Bonsai.IsMarksPrice boolValue]&&[_info.Phase integerValue]==4) {//不明价的 卖家已经回价
                [_aggreeBtn setHidden:YES];
                [_refuseBtn setHidden:YES];
                [_replyPriceBtn setHidden:YES];
                
                [_offerPriceBtn setHidden:YES];
                [_negotiatedBtn setHidden:NO];
                [_negotiatedFailBtn setHidden:YES];
                _replyL.text=@"对宝贝报价进行了议价";
                BDetail  *price1=nil;
                BDetail *price2=nil;
                BDetail *price3=nil;
                if (_info.BDetails.count>=4) {
                    price1=_info.BDetails[1];
                    price2 =_info.BDetails[2];
                    price3 =_info.BDetails[3];
                }
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@ >回价:¥%@",price1.NAmount,price2.NAmount,price3.NAmount];
                [_originPriceL setHidden:NO];
                [_negotiatedBtn setTitle:@"已回价" forState:UIControlStateNormal];
                
            }
            
          else  if ([_info.Phase integerValue]==2&&[_info.Bonsai.IsMarksPrice boolValue]) {//明价的：买家已经议价
                _replyL.text=@"对宝贝进行了议价";
                //                [_replyL setHidden:YES];
                [_negotiatedBtn setHidden:NO];
              [_negotiatedBtn setTitle:@"已回价" forState:UIControlStateNormal];
              
              BDetail  *price1=nil;
              BDetail *price2=nil;
              if (_info.BDetails.count>=2) {
                  price1=_info.BDetails[0];
                  price2 =_info.BDetails[1];
              }
               _originPriceL.text=[NSString stringWithFormat:@"原价：¥%@>议价：¥%@>回价：¥%@",_info.Bonsai.Price,price1.NAmount,price2.NAmount];
                [_aggreeBtn setHidden:YES];
                [_refuseBtn setHidden:YES];
                [_replyPriceBtn setHidden:YES];
                [_buyBtn setHidden:YES];
                
            }
           
            else{
                  _replyL.text=@"对宝贝进行了议价";
            }
        }
        else if (_info.Result==Kgiveup) {//拒绝
            [_orderBtn setHidden:YES];
            [_buyBtn setHidden:YES];
            if ([_info.Phase integerValue]==2&&[_info.Bonsai.IsMarksPrice boolValue]) {//明价的：买家已经议价
                _replyL.text=@"对宝贝进行了议价";
                //                [_replyL setHidden:YES];
                [_negotiatedBtn setHidden:NO];
                BDetail  *price1=nil;
                BDetail *price2=nil;
                if (_info.BDetails.count>=2) {
                    price1=_info.BDetails[0];
                    price2 =_info.BDetails[1];
                }
                _originPriceL.text=[NSString stringWithFormat:@"原价：¥%@>议价：¥%@",_info.Bonsai.Price,price1.NAmount];
                [_negotiatedBtn setHidden:NO];
                [_negotiatedBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
                [_aggreeBtn setHidden:YES];
                [_refuseBtn setHidden:YES];
                [_replyPriceBtn setHidden:YES];
                [_buyBtn setHidden:YES];
                
            }
            if ([_info.Phase integerValue]==3&&[_info.Bonsai.IsMarksPrice boolValue]) {//明价的：买家已经放弃  最后一步
                _replyL.text=@"拒绝了宝贝的回价";
                //                [_replyL setHidden:YES];
                [_negotiatedBtn setHidden:NO];
                [_negotiatedBtn setHidden:NO];
                [_negotiatedBtn setTitle:@"已回价" forState:UIControlStateNormal];
                [_aggreeBtn setHidden:YES];
                [_refuseBtn setHidden:YES];
                [_replyPriceBtn setHidden:YES];
                [_buyBtn setHidden:YES];
                BDetail  *price1=nil;
                BDetail *price2=nil;
                if (_info.BDetails.count>=2) {
                    price1=_info.BDetails[0];
                    price2 =_info.BDetails[1];
                }
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@ >回价:¥%@",_info.Bonsai.Price,price1.NAmount,price2.NAmount];
                [_originPriceL setHidden:NO];
                
            }
            if ([_info.Phase integerValue]==4&&![_info.Bonsai.IsMarksPrice boolValue]) {//不明价的：卖家拒绝议价  最后一步
                _replyL.text=@"对宝贝的报价进行了议价";
                //                [_replyL setHidden:YES];
                [_negotiatedBtn setHidden:NO];
                [_negotiatedBtn setHidden:NO];
                [_negotiatedBtn setTitle:@"已拒绝" forState:UIControlStateNormal];
                [_aggreeBtn setHidden:YES];
                [_refuseBtn setHidden:YES];
                [_replyPriceBtn setHidden:YES];
                [_buyBtn setHidden:YES];
                BDetail  *price1=nil;
                BDetail *price2=nil;
                if (_info.BDetails.count>=2) {
                    price1=_info.BDetails[1];
                    price2 =_info.BDetails[2];
                }
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@",price1.NAmount,price2.NAmount];
                [_originPriceL setHidden:NO];
                
            }
            else if([_info.Phase integerValue]==5&&
                    ![_info.Bonsai.IsMarksPrice boolValue]){//不明价的：买家已经放弃  最后一步
                _replyL.text=@"拒绝了宝贝的回价";
                [_negotiatedBtn setHidden:NO];
                [_negotiatedBtn setTitle:@"已回价" forState:UIControlStateNormal];
                BDetail  *price1=nil;
                BDetail *price2=nil;
                BDetail *price3=nil;
                if (_info.BDetails.count>=4) {
                    price1=_info.BDetails[1];
                    price2 =_info.BDetails[2];
                    price3 =_info.BDetails[3];
                }
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@ >回价:¥%@",price1.NAmount,price2.NAmount,price3.NAmount];
                [_originPriceL setHidden:NO];
                [_aggreeBtn setHidden:YES];
                [_refuseBtn setHidden:YES];
                [_replyPriceBtn setHidden:YES];
                
                
            }
         
        }
        else if (_info.Result==KAgree) {
            [_orderBtn setHidden:NO];
            [_aggreeBtn setHidden:YES];
            [_refuseBtn setHidden:YES];
            [_replyPriceBtn setHidden:YES];
            [_negotiatedBtn setHidden:YES];
            if([_info.Bonsai.IsMarksPrice boolValue]&&[_info.Phase integerValue]==2){//不明价 买家已接受报价
                
                _replyL.text=@"对宝贝进行了议价";
                BDetail  *price1=nil;
                if (_info.BDetails.count>=2) {
                    price1=_info.BDetails[0];
                }
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@",_info.Bonsai.Price ,price1.NAmount];
                
            }
            if(![_info.Bonsai.IsMarksPrice boolValue]&&[_info.Phase integerValue]==3){//不明价 买家已接受报价
             
                _replyL.text=@"接受了对宝贝的报价";
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@",_info.NAmount];
                
            }
            
            if(![_info.Bonsai.IsMarksPrice boolValue]&&[_info.Phase integerValue]==4){//不明价 卖家已经接受议价
                [_offerPriceBtn setHidden:YES];
                _replyL.text=@"对宝贝报价进行了议价";
                BDetail  *price1=nil;
                BDetail *price2=nil;
                if (_info.BDetails.count>=3) {
                    price1=_info.BDetails[1];
                    price2 =_info.BDetails[2];
                }
                _originPriceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@",price1.NAmount,price2.NAmount];
                
            }
            
        }
//        else if(_info.Result==KBuy&&[_info.Phase integerValue]==5){//已经购买
         else if(_info.Result==KBuy){
            [_replyL setHidden:YES];
            [_orderBtn setHidden:YES];
            [_aggreeBtn setHidden:YES];
            [_refuseBtn setHidden:YES];
            [_replyPriceBtn setHidden:YES];
            [_negotiatedBtn setHidden:NO];
            [_negotiatedBtn setTitle:@"已购买" forState:UIControlStateNormal];
            [_buyBtn setHidden:YES];
            _originPriceL.text=[NSString stringWithFormat:@"原价：¥%@>总价：¥%@",_info.Bonsai.Price,_info.NAmount];

        }
    }
    
   
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_aggreeBtn setHidden:YES];
    [_refuseBtn setHidden:YES];
    [_replyPriceBtn setHidden:YES];
    [_orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(20);
        make.width.offset(60);
        make.height.offset(30);
        
    }];
    
    [_negotiatedFailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-70);
        make.top.offset(20);
        make.width.offset(50);
        make.height.offset(30);
        
    }];
    
    
    [_negotiatedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(20);
        make.width.offset(50);
        make.height.offset(30);
        
    }];
    
//    if([_info.Phase integerValue]==3&&![_info.Bonsai.IsMarksPrice boolValue]){
//        [_buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(-65);
//            make.top.offset(20);
//            make.width.offset(50);
//            make.height.offset(30);
//            
//        }];
//        [_refuseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(-10);
//            make.top.offset(20);
//            make.width.offset(50);
//            make.height.offset(30);
//            
//        }];
//        [_refuseBtn setTitle:@"放 弃" forState:UIControlStateNormal];
//    }
//    else
    if([_info.Phase integerValue]==2&&[_info.Bonsai.IsMarksPrice boolValue]&&_info.Result!=KAgree){
        [_buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-65);
            make.top.offset(20);
            make.width.offset(50);
            make.height.offset(30);
            
        }];
        [_refuseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-10);
            make.top.offset(20);
            make.width.offset(50);
            make.height.offset(30);
            
        }];
        [_refuseBtn setTitle:@"放 弃" forState:UIControlStateNormal];
    }
//      else if([_info.Phase integerValue]==4&&![_info.Bonsai.IsMarksPrice boolValue]){
//          [_buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//              make.right.offset(-65);
//              make.top.offset(20);
//              make.width.offset(50);
//              make.height.offset(30);
//              
//          }];
//          [_refuseBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//              make.right.offset(-10);
//              make.top.offset(20);
//              make.width.offset(50);
//              make.height.offset(30);
//              
//          }];
//          [_refuseBtn setTitle:@"放 弃" forState:UIControlStateNormal];
//      }

    else{
    [_buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(20);
        make.width.offset(50);
        make.height.offset(30);
        
    }];
//          [_refuseBtn setTitle:@"拒 绝" forState:UIControlStateNormal];
    }
    
    
    //offerPriceBtn
    [_offerPriceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(20);
        make.width.offset(50);
        make.height.offset(30);
        
    }];
    
//    if (![_info.Bonsai.IsMarksPrice boolValue]&&[_info.Phase integerValue]==3){
//        [_aggreeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(-115);
//            make.top.offset(20);
//            make.width.offset(50);
//            make.height.offset(30);
//            
//        }];
//        [_refuseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(-65);
//            make.top.offset(20);
//            make.width.offset(50);
//            make.height.offset(30);
//            
//        }];
//        [_replyPriceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(-10);
//            make.top.offset(20);
//            make.width.offset(50);
//            make.height.offset(30);
//            
//        }];
//    }
    if ([[_info.Bonsai IsMarksPrice] boolValue]) {//明价
        if ([_info.Phase integerValue]==1) {//买家议价
            [_aggreeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-125);
                make.top.offset(20);
                make.width.offset(50);
                make.height.offset(30);
                
            }];
            [_refuseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-65);
                make.top.offset(20);
                make.width.offset(50);
                make.height.offset(30);
                
            }];
            [_replyPriceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-10);
                make.top.offset(20);
                make.width.offset(50);
                make.height.offset(30);
                
            }];
             if ([_info.BuyUser.ID isEqualToString:[DataSource  sharedDataSource].userInfo.ID]) {
                 [_aggreeBtn setHidden:YES];
                 [_refuseBtn setHidden:YES];
                 [_replyPriceBtn setHidden:YES];
             }
             else{
                [_aggreeBtn setHidden:NO];
                [_refuseBtn setHidden:NO];
                [_replyPriceBtn setHidden:NO];
                 [_aggreeBtn setTitle:@"接 受" forState:UIControlStateNormal];
                 [_refuseBtn setTitle:@"拒 绝" forState:UIControlStateNormal];
                 [_replyPriceBtn setTitle:@"回 价" forState:UIControlStateNormal];
             }
        }
       else if ([_info.Phase integerValue]==2) {//买家议价
            if(_info.Result==Kgiveup){
               if ([_info.BuyUser.ID isEqualToString:[DataSource  sharedDataSource].userInfo.ID]) {
                   [_buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                       make.right.offset(-10);
                       make.top.offset(20);
                       make.width.offset(50);
                       make.height.offset(30);
                       
                   }];
                 }
                else{
                 
                }
             }
            else if(_info.Result==KNegotiate){
                if ([_info.BuyUser.ID isEqualToString:[DataSource  sharedDataSource].userInfo.ID]) {
                    [_refuseBtn setHidden:NO];
                    [_refuseBtn setTitle:@"放 弃" forState:UIControlStateNormal];
                    [_refuseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.right.offset(-10);
                        make.top.offset(20);
                        make.width.offset(50);
                        make.height.offset(30);
                        
                    }];
                }
                else{
                    
                }
            }
            
        }
       
    }
    else if (![[_info.Bonsai IsMarksPrice] boolValue]) {//不明价
       
        if ([_info.Phase integerValue]==2) {//卖家已报价
            //我是购买者
            if ([_info.BuyUser.ID isEqualToString:[DataSource  sharedDataSource].userInfo.ID]) {
            
                [_buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                     make.right.offset(-125);
                    make.top.offset(20);
                    make.width.offset(50);
                    make.height.offset(30);
                    
                }];
                [_refuseBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.right.offset(-65);
                    make.top.offset(20);
                    make.width.offset(50);
                    make.height.offset(30);
                    
                }];
                [_replyPriceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.offset(-10);
                    make.top.offset(20);
                    make.width.offset(50);
                    make.height.offset(30);
                    
                }];
                [_buyBtn setTitle:@"购 买" forState:UIControlStateNormal];
                [_replyPriceBtn setTitle:@"议 价" forState:UIControlStateNormal];
                [_refuseBtn setTitle:@"放 弃" forState:UIControlStateNormal];
                    [_buyBtn setHidden:NO];
                    [_refuseBtn setHidden:NO];
                    [_replyPriceBtn setHidden:NO];
            }
            else{//卖者
              
            }
         
        }
        else if([_info.Phase integerValue]==3){//买家已议价
            [_aggreeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-125);
                make.top.offset(20);
                make.width.offset(50);
                make.height.offset(30);
                
            }];
            [_refuseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-65);
                make.top.offset(20);
                make.width.offset(50);
                make.height.offset(30);
                
            }];
            [_replyPriceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.offset(-10);
                make.top.offset(20);
                make.width.offset(50);
                make.height.offset(30);
                
            }];
            if (_info.Result==KNegotiate) {
                if ([_info.BuyUser.ID isEqualToString:[DataSource  sharedDataSource].userInfo.ID]) {
                    [_aggreeBtn setHidden:YES];
                    [_refuseBtn setHidden:YES];
                    [_replyPriceBtn setHidden:YES];
                    
                }
                else{
                    [_aggreeBtn setTitle:@"接 受" forState:UIControlStateNormal];
                    [_refuseBtn setTitle:@"拒 绝" forState:UIControlStateNormal];
                    [_replyPriceBtn setTitle:@"回 价" forState:UIControlStateNormal];
                    
                    [_aggreeBtn setHidden:NO];
                    [_refuseBtn setHidden:NO];
                    [_replyPriceBtn setHidden:NO];
                }
              
            }
            if (_info.Result==KAgree) {
                [_buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.offset(-10);
                    make.top.offset(20);
                    make.width.offset(50);
                    make.height.offset(30);
                    
                }];
            }
          
        }
         else if([_info.Phase integerValue]==4){//
             if (_info.Result==KAgree) {
                 [_buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                     make.right.offset(-10);
                     make.top.offset(20);
                     make.width.offset(50);
                     make.height.offset(30);
                     
                 }];
             }
             if (_info.Result==KNegotiate) {//卖家回价
                 [_refuseBtn setHidden:NO];
                 [_refuseBtn setTitle:@"放 弃" forState:UIControlStateNormal];
                 [_refuseBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                     make.right.offset(-10);
                     make.top.offset(20);
                     make.width.offset(50);
                     make.height.offset(30);
                     
                 }];
                 [_buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                     make.right.offset(-65);
                     make.top.offset(20);
                     make.width.offset(50);
                     make.height.offset(30);
                     
                 }];
             }
         }
       
    }
    if (_info.Result==KBuy) {
        [_orderBtn setHidden:NO];
        
        [_aggreeBtn setHidden:YES];
        [_refuseBtn setHidden:YES];
        [_replyPriceBtn setHidden:YES];
        [_negotiatedBtn setHidden:YES];
    }
    [_originPriceL sizeToFit];
    
   
}

//议价
-(void)replyPriceAction{
    if (_replyPriceBlock) {
        _replyPriceBlock(_index);
    }
}

//查询订单
-(void)orderAction{
    if (_orderBlock) {
        _orderBlock(_index);
    }
}

-(void)buyAction{
    if (_buyBlock) {
        _buyBlock(_index);
    }
}

//报价
-(void)offerPriceAction{
    if (_offerPriceBlock) {
        _offerPriceBlock(_index);
    }
}

//接受
-(void)aggreeAction{
    if (_aggreeBlock) {
        _aggreeBlock(_index);
    }
}

//拒绝
-(void)refuseAction{
    if (_refuseBlock) {
        _refuseBlock(_index);
    }
}
@end
