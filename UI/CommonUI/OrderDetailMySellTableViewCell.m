//
//  OrderDetailTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "OrderDetailMySellTableViewCell.h"

@implementation OrderDetailMySellTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
   
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
    [_totalPriceL sizeToFit];
    _sellerL.text=_info.BuyUser.NickName;
    _receiverL.text=_info.Contacter;
    _phoneL.text=_info.Mobile;
    _addressL.text=_info.Address;
    _orderNumL.text=[NSString stringWithFormat:@"订单号:%@",_info.TradingNo];
    if (_info.Status==KNo_Pay) {
        _statusL.text=@"未付款";
    }
    else{
//            _payTypeL.text=_info.PayType;
     if (_info.Status==KPay_Finish) {
        _statusL.text=@"已付款";
    }
    else if (_info.Status==KSend_Goods) {
        _statusL.text=@"已发货";
    }
    else if (_info.Status==KCancel) {
        _statusL.text=@"请求退款";
    }
    else if (_info.Status==KRefunded) {
        _statusL.text=@"已退款";
    }
    else if (_info.Status==KTakedGoods) {
        _statusL.text=@"已收货";
    }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
