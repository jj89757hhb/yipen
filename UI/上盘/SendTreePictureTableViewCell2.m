//
//  SendTreePictureTableViewCell2.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SendTreePictureTableViewCell2.h"

@implementation SendTreePictureTableViewCell2

- (void)awakeFromNib {
    // Initialization code
    [self.price1L setUserInteractionEnabled:YES];
    [self.price2L setUserInteractionEnabled:YES];
    [self.expressType1L setUserInteractionEnabled:YES];
    [self.expressType2L setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action)];
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action)];
     UITapGestureRecognizer *tap3=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap3Action)];
     UITapGestureRecognizer *tap4=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap4Action)];
    [_price1L addGestureRecognizer:tap1];
    [_price2L addGestureRecognizer:tap2];
    [_expressType1L addGestureRecognizer:tap3];
    [_expressType2L addGestureRecognizer:tap4];
    
}

-(void)tap1Action{
    if (_click1Block) {
        _click1Block(nil);
    }
}
-(void)tap2Action{
    if (_click2Block) {
        _click2Block(nil);
    }
}
-(void)tap3Action{
    if (_click3Block) {
        _click3Block(nil);
    }
}
-(void)tap4Action{
    if (_click4Block) {
        _click4Block(nil);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
