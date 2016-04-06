//
//  ActivityCommentTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/29.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ActivityCommentTableViewCell.h"

@implementation ActivityCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.commentIV=[[UIImageView alloc] init];
        [_commentIV setImage:[UIImage imageNamed:@"评论-列表"]];
        self.commentL=[[UILabel alloc] init];
        [_commentL setFont:[UIFont systemFontOfSize:15]];
        [_commentL setTextColor:[UIColor darkGrayColor]];
        [self.contentView addSubview:_commentIV];
        [self.contentView addSubview:_commentL];
          _commentL.text=@"非常不错哦哦哦";
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    float offX=10;
    float offY=10;
    [_commentIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(offY);
        make.left.offset(offX);
        make.width.and.height.offset(15);
    }];
    [_commentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(offY);
        make.left.equalTo(_commentIV.mas_right).offset(5);
         make.right.offset(-offX);
    }];
    [_commentL sizeToFit];
  
}


@end
