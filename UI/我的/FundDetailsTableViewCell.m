//
//  FundDetailsTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "FundDetailsTableViewCell.h"

@implementation FundDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(FundDetail *)info{
    _info=info;
    _timeL.text=_info.Createtime;
    NSString *prefix=@"-";
    if ([_info.Type integerValue]==1) {
        prefix=@"+";
    }
    else if ([_info.Type integerValue]==2) {
        
    }
    else if ([_info.Type integerValue]==3) {
        
    }
    else if ([_info.Type integerValue]==4) {
           prefix=@"+";
    }
    else if ([_info.Type integerValue]==5) {
           prefix=@"+";
    }
    else if ([_info.Type integerValue]==6) {
           prefix=@"+";
    }
    
    _fundL.text=[NSString stringWithFormat:@"%@%@¥",prefix,_info.Money];
    _desL.text=_info.Summary;
}

@end
