//
//  MySellTableViewCell1.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/15.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MyBuyTableViewCell1.h"

@implementation MyBuyTableViewCell1

- (void)awakeFromNib {
    // Initialization code
    self.msg2Btn=[[UIButton alloc] init];
    self.payBtn=[[UIButton alloc] init];
    self.cancelOrderBtn=[[UIButton alloc] init];
    _msg2Btn.layer.cornerRadius=5;
    _msg2Btn.titleLabel.font=[UIFont systemFontOfSize:14];
       _payBtn.titleLabel.font=[UIFont systemFontOfSize:14];
       _cancelOrderBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [_msg2Btn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    _msg2Btn.layer.borderWidth=0.5;
    _payBtn.layer.borderWidth=0.5;
    _cancelOrderBtn.layer.borderWidth=0.5;;
    [_payBtn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    [_cancelOrderBtn setTitleColor:GRAYCOLOR forState:UIControlStateNormal];
    _msg2Btn.clipsToBounds=YES;
    _payBtn.layer.cornerRadius=5;
    _payBtn.clipsToBounds=YES;
    _cancelOrderBtn.layer.cornerRadius=5;
    _cancelOrderBtn.clipsToBounds=YES;
    [_payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [self.contentView addSubview:_msg2Btn];
    [_msg2Btn setTitle:@"对 话" forState:UIControlStateNormal];
    [_msg2Btn addTarget:self action:@selector(msgAction:) forControlEvents:UIControlEventTouchUpInside];
    [_msgBtn addTarget:self action:@selector(msgAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_payBtn];
    [self.contentView addSubview:_cancelOrderBtn];
    [_cancelOrderBtn setTitle:@"取消订单" forState:UIControlStateNormal];
    [_cancelOrderBtn setUserInteractionEnabled:NO];
    _treeIV.contentMode=UIViewContentModeScaleAspectFill;
    _treeIV.clipsToBounds=YES;
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(ExchangeInfo *)info{
   
    
    _info=info;
    if (_info.Bonsai.Attach.count) {
        [_treeIV sd_setImageWithURL:[NSURL URLWithString:_info.Bonsai.Attach[0]] placeholderImage:Default_Image];
    }
    _sellerL.text=[NSString stringWithFormat:@"卖家:%@",info.SaleUser.NickName];
    _orderTimeL.text=info.Createtime;
    _orderNumL.text= [NSString stringWithFormat:@"订单号:%@",info.TradingNo];
    _titleL.text =[NSString stringWithFormat:@"%@",info.Bonsai.Title];
    
  
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_msg2Btn setHidden:YES];
    [_payBtn setHidden:YES];
    [_cancelOrderBtn setHidden:YES];
    
    [_msgBtn setHidden:NO];
    [_sureGoodsBtn setHidden:NO];
    [_complaintBtn setHidden:NO];
    [_payBtn setUserInteractionEnabled:YES];
    float width=60;
    float offY=-15;
    [_msg2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(offY);
        make.width.offset(width);
        make.height.offset(30);
        make.right.offset(-80);
        
    }];
    [_payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(offY);
        make.width.offset(width);
        make.height.offset(30);
        make.right.offset(-10);
    }];
    
    [_cancelOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(offY);
        make.width.offset(width);
        make.height.offset(30);
        make.right.offset(-10);
    }];
//    [_cancelOrderBtn setBackgroundColor:RedColor];
//    [_sureGoodsBtn setTitle:@"确认收货" forState:UIControlStateNormal];

    if (_info.Status==KNo_Pay) {
        _sendStatusL.text=@"未付款";
        [_msg2Btn setHidden:NO];
        [_payBtn setHidden:NO];
        [_payBtn setTitle:@"立即付款" forState:UIControlStateNormal];
        [_payBtn setUserInteractionEnabled:NO];
        
        [_msgBtn setHidden:YES];
        [_sureGoodsBtn setHidden:YES];
        [_complaintBtn setHidden:YES];
    }
    else if (_info.Status==KPay_Finish) {
        _sendStatusL.text=@"已付款";
        [_msgBtn setHidden:YES];
        [_sureGoodsBtn setHidden:YES];
        [_complaintBtn setHidden:YES];
        [_cancelOrderBtn setHidden:NO];
        [_msg2Btn setHidden:NO];
  
    }
    else if (_info.Status==KSend_Goods) {
        _sendStatusL.text=@"已发货";
    }
    else if (_info.Status==KCancel) {
//        _sendStatusL.text=@"已取消";
        _sendStatusL.text=@"已申请退款";
        [_msg2Btn setHidden:NO];
        [_payBtn setHidden:NO];
        [_payBtn setTitle:@"投诉" forState:UIControlStateNormal];
        
        [_msgBtn setHidden:YES];
        [_sureGoodsBtn setHidden:YES];
        [_complaintBtn setHidden:YES];
//        [_sureGoodsBtn setTitle:@"对话" forState:UIControlStateNormal];
    }
    else if (_info.Status==KRefunded) {
        _sendStatusL.text=@"已退款";
    }
    else if (_info.Status==KTakedGoods) {
        _sendStatusL.text=@"已收货";
    }
    _buyTypeL.text=[NSString stringWithFormat:@"¥%@ 直接购买",_info.Bonsai.Price];
    if (_info.Courier.length) {
        [_expressNameL setHidden:NO];
        [_expressNumL setHidden:NO];
        _expressNameL.text=_info.Courier;
        _expressNumL.text=_info.CourierNo;
    }
    else{
        [_expressNameL setHidden:YES];
        [_expressNumL setHidden:YES];
    }
}


-(void)msgAction:(UIButton*)sender{
    if (_msgBlock) {
        _msgBlock(_index);
    }
    
}

@end
