//
//  SendTreePictureTableViewCell3.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/26.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "SendTreePictureTableViewCell3.h"

@implementation SendTreePictureTableViewCell3

- (void)awakeFromNib {
    // Initialization code
    [self.sellExpressL setUserInteractionEnabled:YES];
    [self.buyExpressL setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action)];
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action)];
    [self.sellExpressL addGestureRecognizer:tap1];
    [self.buyExpressL addGestureRecognizer:tap2];
    [self.startTimeL setUserInteractionEnabled:YES];
    [self.endTimeL setUserInteractionEnabled:YES];
    UITapGestureRecognizer *startTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(startTimeAction)];
    UITapGestureRecognizer *endTap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endTimeAction)];
    [_startTimeL addGestureRecognizer:startTap];
    [_endTimeL addGestureRecognizer:endTap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

-(void)startTimeAction{
    if (_startTimeBlock) {
        _startTimeBlock(nil);
    }
}

-(void)endTimeAction{
    if (_endTimeBlock) {
        _endTimeBlock(nil);
    }
}

-(void)layoutSubviews{
    self.v_line_width.constant=0.5;
    self.x_line_height.constant=0.5;
    self.x_line2_Height.constant=0.5;
    self.y_line2_width.constant=0.5;
}
@end
