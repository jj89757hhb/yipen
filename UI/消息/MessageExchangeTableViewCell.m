//
//  MessageExchangeTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/23.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MessageExchangeTableViewCell.h"

@implementation MessageExchangeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.aggreeBtn.layer.cornerRadius=3;
    self.aggreeBtn.clipsToBounds=YES;
    self.aggreeBtn.layer.borderWidth=0.5;
    self.aggreeBtn.layer.borderColor=GRAYCOLOR.CGColor;
    self.aggreeBtn.layer.cornerRadius=3;
    
    self.refuseBtn.clipsToBounds=YES;
    self.refuseBtn.layer.borderWidth=0.5;
    self.refuseBtn.layer.borderColor=GRAYCOLOR.CGColor;
    self.refuseBtn.layer.cornerRadius=3;
    
    self.replyPriceBtn.clipsToBounds=YES;
    self.replyPriceBtn.layer.borderWidth=0.5;
    self.replyPriceBtn.layer.borderColor=GRAYCOLOR.CGColor;
    self.replyPriceBtn.layer.cornerRadius=3;
    [_replyPriceBtn addTarget:self action:@selector(replyPriceAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.orderBtn=[[UIButton alloc] init];
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
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(ExchangeInfo *)info{
    _info=info;
    _priceL.text=[NSString stringWithFormat:@"议价:%@",info.NAmount];
    _originPriceL.text=[NSString stringWithFormat:@"原价:%@",info.Bonsai.Price];
    _titleL.text=info.Bonsai.Title;
    _contentL.text=info.Bonsai.Descript;
    if (info.Bonsai.Attach.count) {
        [_treeIV sd_setImageWithURL:[NSURL URLWithString:info.Bonsai.Attach[0]] placeholderImage:Default_Image];
    }
    _viewL.text=[NSString stringWithFormat:@"浏览%@",info.Bonsai.BrowseNum];
    _praiseL.text=[NSString stringWithFormat:@"赞%@",info.Bonsai.PraisedNum];
    _commentL.text=[NSString stringWithFormat:@"评论%@",info.Bonsai.CommentsNum];
    [_orderBtn addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchUpInside];
    NSLog(@"1111:%d",info.Result);
 
    _timeL.text=info.CreateTime;

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
        }
        else if (_info.Result==Kgiveup) {
            [_orderBtn setHidden:YES];
            [_buyBtn setHidden:YES];
        }
        else if (_info.Result==KAgree) {
             _replyL.text=@"接受对宝贝的议价";
            [_orderBtn setHidden:YES];
            [_aggreeBtn setHidden:YES];
            [_refuseBtn setHidden:YES];
            [_replyPriceBtn setHidden:YES];
            [_negotiatedBtn setHidden:YES];
            
        }
        else{
            
        }
        if ([_info.Phase integerValue]==2&&![_info.Bonsai.IsMarksPrice boolValue]) {//不明价的 此时买家操作： 购买 放弃  议价
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
            [_priceL setHidden:YES];
        }
        else if([_info.Phase integerValue]==3&&![_info.Bonsai.IsMarksPrice boolValue]){//不明价 买家已议价
              _replyL.text=@"对宝贝进行了报价";
            [_orderBtn setHidden:YES];
            [_aggreeBtn setHidden:YES];
            [_refuseBtn setHidden:YES];
            [_replyPriceBtn setHidden:YES];
            [_negotiatedBtn setHidden:NO];
            [_buyBtn setHidden:YES];
            _originPriceL.text=[NSString stringWithFormat:@"报价：¥%@",_info.NAmount];
//            [_priceL setHidden:YES];
            _priceL.text=[NSString stringWithFormat:@"议价：¥%@",_info.NAmount];
            
            
        }
    }
    else{
      
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
            if (![_info.Bonsai.IsMarksPrice boolValue]&&[_info.Phase integerValue]==2) {//不明价的 买家已询价
                  _replyL.text=@"对宝贝进行了询价";
                [_offerPriceBtn setHidden:NO];
                _originPriceL.text=@"原价:不明价";
                [_priceL setHidden:YES];
                if ([_info.Phase intValue]==2) {
                    [_offerPriceBtn setTitle:@"已报价" forState:UIControlStateNormal];
                    [_offerPriceBtn setBackgroundColor:GRAYCOLOR];
                    [_offerPriceBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
                    [_offerPriceBtn setUserInteractionEnabled:NO];
                    [_priceL setHidden:NO];
                    _priceL.text=[NSString stringWithFormat:@"报价:¥%@",_info.NAmount];
                }
              
            }
            else if (![_info.Bonsai.IsMarksPrice boolValue]&&[_info.Phase integerValue]==3) {//不明价的 买家已经议价（此时的操作:接受、拒绝、回价）
                [_aggreeBtn setHidden:NO];
                [_refuseBtn setHidden:NO];
                [_replyPriceBtn setHidden:NO];
                [_offerPriceBtn setHidden:YES];
                [_negotiatedBtn setHidden:YES];
                _replyL.text=@"对宝贝报价进行了询价";
                _originPriceL.text=@"原价:不明价";
//                [_priceL setHidden:YES];
//                    [_offerPriceBtn setTitle:@"已报价" forState:UIControlStateNormal];
//                    [_offerPriceBtn setBackgroundColor:GRAYCOLOR];
//                    [_offerPriceBtn setTitleColor:WHITEColor forState:UIControlStateNormal];
//                    [_offerPriceBtn setUserInteractionEnabled:NO];
                    [_priceL setHidden:NO];
                    _priceL.text=[NSString stringWithFormat:@"报价:¥%@ >议价:¥%@",_info.Bonsai.Price,_info.NAmount];
                
            }
            else{
                  _replyL.text=@"对宝贝进行了议价";
            }
        }
        else if (_info.Result==Kgiveup) {
            [_orderBtn setHidden:YES];
            [_buyBtn setHidden:YES];
        }
        else if (_info.Result==KAgree) {
            [_orderBtn setHidden:NO];
            [_aggreeBtn setHidden:YES];
            [_refuseBtn setHidden:YES];
            [_replyPriceBtn setHidden:YES];
            [_negotiatedBtn setHidden:YES];
            
        }
        else{
            
        }
    }
    
   
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_orderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(20);
        make.width.offset(60);
        make.height.offset(30);
        
    }];
    
    [_negotiatedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(20);
        make.width.offset(50);
        make.height.offset(30);
        
    }];
    
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(20);
        make.width.offset(50);
        make.height.offset(30);
        
    }];
    
    //offerPriceBtn
    [_offerPriceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.top.offset(20);
        make.width.offset(50);
        make.height.offset(30);
        
    }];
    
    [_priceL sizeToFit];
    [_originPriceL sizeToFit];
    
   
}

//议价
-(void)replyPriceAction{
    if (_replyPriceBlock) {
        _replyPriceBlock(_index);
    }
}

-(void)orderAction{
    if (_orderBlock) {
        _orderBlock(nil);
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

@end
