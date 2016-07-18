//
//  MySell1TableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/1.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MySellOrderTableViewCell.h"

@implementation MySellOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.sendGoodsBtn addTarget:self action:@selector(sendGoodsAction) forControlEvents:UIControlEventTouchUpInside];
    [self.msgBtn addTarget:self action:@selector(msgAction) forControlEvents:UIControlEventTouchUpInside];
    self.treeIV.contentMode=UIViewContentModeScaleAspectFill;
    self.treeIV.clipsToBounds=YES;
}

-(void)sendGoodsAction{
    if (_sendGoodsBlock) {
        _sendGoodsBlock(nil);
    }
    
}

-(void)msgAction{
    if (_msgBlock) {
        _msgBlock(nil);
    }
}

-(void)setExchangeInfo:(ExchangeInfo *)exchangeInfo{
    _exchangeInfo=exchangeInfo;
    self.titleL.text=exchangeInfo.Bonsai.Title;
    self.sellerL.text=exchangeInfo.SaleUser.NickName;
    self.orderNumL.text= [NSString stringWithFormat:@"订单号:%@",exchangeInfo.TranNo] ;
    self.orderTimeL.text=exchangeInfo.CreateTime;
    self.sendStatusL.text=@"等待支付";
    if (exchangeInfo.Bonsai.Attach.count) {
        [self.treeIV sd_setImageWithURL:[NSURL URLWithString:exchangeInfo.Bonsai.Attach[0]] placeholderImage:Default_Image];
    }
    self.priceL.text=[NSString stringWithFormat:@"¥%@",exchangeInfo.NAmount];
        NSString *textStr = nil;
    if (![exchangeInfo.Bonsai.IsMarksPrice boolValue]) {//不明价
//        self.originalPriceL.text=@"不明价";
        textStr=@"不明价";
    }
    else{
//        self.originalPriceL.text=[NSString stringWithFormat:@"¥%@",exchangeInfo.Bonsai.Price];
        textStr=[NSString stringWithFormat:@"¥%@",exchangeInfo.Bonsai.Price];
    }
    

    
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    
    // 赋值
   _originalPriceL.attributedText = attribtStr;
    _originalPriceL.textColor=GRAYCOLOR;
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
