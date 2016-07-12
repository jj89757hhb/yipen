//
//  OfferPriceTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/21.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "OfferPriceTableViewCell.h"

@implementation OfferPriceTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.timerL.backgroundColor=Tree_BgColor;
//    self.textLayer = [CATextLayer layer];
//    [self.contentView.layer addSublayer:_textLayer];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(PenJinInfo *)info{
    _info=info;
    _startPriceL.text=[NSString stringWithFormat:@"¥%@",info.APrice];
    _addPriceL.text=[NSString stringWithFormat:@"¥%@",info.MakeUp];
    [self timeAction];
    
}

-(void)timeAction{
     timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refreshTime) userInfo:nil repeats:YES];
    [timer fire];
}

-(void)refreshTime{
    
//    long long timeInterval=time(NULL)-[_info.AEndTime longLongValue];
    NSMutableAttributedString *attributedStr=[CommonFun timerFireMethod:[_info.AEndTime longLongValue]];
 
    self.timerL.attributedText=attributedStr;
//    _textLayer.string=attributedStr;
//    
//    _textLayer.frame = CGRectMake(SCREEN_WIDTH-200, 5, 200, 20);
//    [self.timerL setHidden:YES];
}

-(void)dealloc{
    [timer invalidate];
}

@end

