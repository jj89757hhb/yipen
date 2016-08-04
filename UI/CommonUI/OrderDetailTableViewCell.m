//
//  OrderDetailTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "OrderDetailTableViewCell.h"

@implementation OrderDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payTypeAction)];
    [_payTypeL addGestureRecognizer:tap1];
    [_payTypeL setUserInteractionEnabled:YES];
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
    _titleL.text=_info.Bonsai.Title;
    _priceL.text=[NSString stringWithFormat:@"¥%@",_info.Bonsai.Price];
    if ([_info.Bonsai.IsMailed boolValue]) {//卖家包邮
           _totalPriceL.text=[NSString stringWithFormat:@"¥%@(卖家包邮)",_info.Bonsai.Price];
    }
    else{
        NSString *totalPrice=[NSString stringWithFormat:@"%.2f",[_info.Bonsai.Price floatValue]+[_info.Bonsai.MailFee floatValue]];
           _totalPriceL.text=[NSString stringWithFormat:@"¥%@(含邮费¥%@)",totalPrice,_info.Bonsai.MailFee];
    }
 
    _sellerL.text=_info.SaleUser.NickName;
    _receiverL.text=_info.Contacter;
    _phoneL.text=_info.Mobile;
    _addressL.text=_info.Address;
    _orderNumL.text=[NSString stringWithFormat:@"订单号:%@",_info.TradingNo];
    [_payTypeL setUserInteractionEnabled:NO];
    if (_info.Status==KNo_Pay) {
        _statusL.text=@"未付款";
        [_payTypeL setUserInteractionEnabled:YES];
        if (_pay_Type==KYuE_Pay) {
            _payTypeL.text=@"余额支付";
        }
        else if(_pay_Type==KZFB_Pay){
            _payTypeL.text=@"支付宝支付";
        }
        else if(_pay_Type==KWeiXin_Pay){
            _payTypeL.text=@"微信支付";
        }
    }
    else{
           _payTypeL.text=_info.PayType;
    if (_info.Status==KPay_Finish) {
        _statusL.text=@"已付款";
        
    }
    else if (_info.Status==KSend_Goods) {
        _statusL.text=@"已发货";
    }
    else if (_info.Status==KCancel) {
        _statusL.text=@"已取消";
    }
    else if (_info.Status==KRefunded) {
        _statusL.text=@"已退款";
    }
    else if (_info.Status==KTakedGoods) {
        _statusL.text=@"已收货";
    }
    }
 
  
}

//选择支付方式
-(void)payTypeAction{
    if (_payTypeBlock) {
        _payTypeBlock(nil);
    }
}

@end
