//
//  MySell1TableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/1.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MySell1TableViewCell.h"

@implementation MySell1TableViewCell

- (void)awakeFromNib {
    // Initialization code
    
   
    self.treeIV.contentMode=UIViewContentModeScaleAspectFill;
    self.treeIV.clipsToBounds=YES;
    self.refundBtn=[[UIButton alloc] init];
    [_refundBtn setTitle:@"同意退款" forState:UIControlStateNormal];
    [self.refundBtn addTarget:self action:@selector(refundAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_refundBtn];
    [_refundBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    _refundBtn.clipsToBounds=YES;
    _refundBtn.layer.cornerRadius=3;
    _refundBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    _refundBtn.layer.borderColor=GRAYCOLOR.CGColor;
    _refundBtn.layer.borderWidth=1;
    self.msgBtn=[[UIButton alloc] init];
    [_msgBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [self.contentView addSubview:_msgBtn];
    _msgBtn.clipsToBounds=YES;
    _msgBtn.layer.cornerRadius=3;
    _msgBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    _msgBtn.layer.borderColor=GRAYCOLOR.CGColor;
    _msgBtn.layer.borderWidth=1;
    [_msgBtn setTitle:@"对 话" forState:UIControlStateNormal];
    [_msgBtn addTarget:self action:@selector(msgAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendGoodsBtn=[[UIButton alloc] init];
    [_sendGoodsBtn setTitleColor:BLACKCOLOR forState:UIControlStateNormal];
    [self.contentView addSubview:_sendGoodsBtn];
    _sendGoodsBtn.clipsToBounds=YES;
    _sendGoodsBtn.layer.cornerRadius=3;
    _sendGoodsBtn.titleLabel.font=[UIFont systemFontOfSize:12];
    _sendGoodsBtn.layer.borderColor=GRAYCOLOR.CGColor;
    _sendGoodsBtn.layer.borderWidth=1;
    [_sendGoodsBtn setTitle:@"发 货" forState:UIControlStateNormal];
    [_sendGoodsBtn addTarget:self action:@selector(sendGoodsAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)sendGoodsAction{
    if (_sendGoodsBlock) {
        _sendGoodsBlock(_indexPath);
    }
    
}

-(void)msgAction{
    if (_msgBlock) {
        _msgBlock(_indexPath);
    }
}

-(void)setInfo:(ExchangeInfo *)info{
    _info=info;
    if (_info.Bonsai.Attach.count) {
        [_treeIV sd_setImageWithURL:[NSURL URLWithString:_info.Bonsai.Attach[0]] placeholderImage:Default_Image];
    }
//    _sellerL.text=[NSString stringWithFormat:@"卖家:%@",info.SaleUser.NickName];
  
    _sellerL.text=[NSString stringWithFormat:@"买家:%@",_info.BuyUser.NickName];
    _orderTimeL.text=info.CreateTime;
    _orderNumL.text= [NSString stringWithFormat:@"订单号:%@",info.TradingNo];
    _titleL.text =[NSString stringWithFormat:@"%@",info.Bonsai.Title];
    if (_info.Courier.length) {
         [_expressNameL setHidden:NO];
        [_expressNumL setHidden:NO];
        _expressNameL.text=_info.Courier;
         _expressNumL.text=[NSString stringWithFormat:@"快递单号:%@",_info.CourierNo];
    }
    else{
        [_expressNameL setHidden:YES];
        [_expressNumL setHidden:YES];
    }
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    
    float offx=10;
    float offy=15;
    float width=60;
    float height=25;
    
    [_refundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-(width*2+offx*3));
        make.bottom.offset(-offy);
        make.width.offset(width);
        make.height.offset(height);
    }];
    [_msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-(width*1+offx*2));
        make.bottom.offset(-offy);
        make.width.offset(width);
        make.height.offset(height);
    }];
    
    [_sendGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-offx);
        make.bottom.offset(-offy);
        make.width.offset(width);
        make.height.offset(height);
    }];
         [_refundBtn setHidden:YES];
    if (_info.Status==KNo_Pay) {
        _sendStatusL.text=@"未付款";
        [_msgBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-(width*0+offx*1));
            make.bottom.offset(-offy);
            make.width.offset(width);
            make.height.offset(height);
        }];
        [_sendGoodsBtn  setHidden:YES];
    }
    else if (_info.Status==KPay_Finish) {
        _sendStatusL.text=@"已付款";
//        [_msgBtn setHidden:YES];
//        [_sureGoodsBtn setHidden:YES];
//        [_complaintBtn setHidden:YES];
//        [_cancelOrderBtn setHidden:NO];
//        [_msg2Btn setHidden:NO];
   
    }
    else if (_info.Status==KSend_Goods) {
        _sendStatusL.text=@"待收货";
        [_msgBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-(width*0+offx*1));
            make.bottom.offset(-offy);
            make.width.offset(width);
            make.height.offset(height);
        }];
        [_sendGoodsBtn  setHidden:YES];
    }
    else if (_info.Status==KCancel) {//操作： 同意退款 对话 发货
        _sendStatusL.text=@"请求退款";
        [_refundBtn setHidden:NO];
//        [_refundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(-(width*2+offx*2));
//            make.bottom.offset(-offy);
//            make.width.offset(width);
//            make.height.offset(height);
//        }];
//        [_msgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(-(width*1+offx*1));
//            make.bottom.offset(-offy);
//            make.width.offset(width);
//            make.height.offset(height);
//        }];
//        
//        [_sendGoodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.offset(-offx);
//            make.bottom.offset(-offy);
//            make.width.offset(width);
//            make.height.offset(height);
//        }];
        
        
    }
    else if (_info.Status==KRefunded) {
        _sendStatusL.text=@"已退款";
        [_msgBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-(width*0+offx*1));
            make.bottom.offset(-offy);
            make.width.offset(width);
            make.height.offset(height);
        }];
        [_sendGoodsBtn  setHidden:YES];
    }
    else if (_info.Status==KTakedGoods) {
        _sendStatusL.text=@"已收货";
       
    }
//    _expressNameL.text
 
    _buyTypeL.text=[NSString stringWithFormat:@"¥%@ 直接购买",_info.Bonsai.Price];
}

//退款
-(void)refundAction{
    if (_refundBlock) {
        _refundBlock(_indexPath);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
