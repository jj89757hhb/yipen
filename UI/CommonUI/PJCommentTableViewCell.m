//
//  PJCommentTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//  盆景评论

#import "PJCommentTableViewCell.h"

@implementation PJCommentTableViewCell

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
        _commentIV.image=[UIImage imageNamed:@"评论-列表"];
        self.commentL=[[UILabel alloc] init];
        _commentL.font=[UIFont systemFontOfSize:comment_FontSize];
        _commentL.textColor=[UIColor darkGrayColor];
        [self.contentView addSubview:_commentIV];
        [self.contentView addSubview:_commentL];
    }
    return self;
}

-(void)setInfo:(CommentInfo *)info{
    _info=info;
    _commentL.text=[NSString stringWithFormat:@"%@: %@",info.NickName,info.Message];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    float offX=10;
    float offY=10;
    [_commentIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(offX);
        make.top.offset(offY);
        make.width.and.height.offset(15);
    }];
    [_commentL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15+offX*2);
        make.right.offset(-offX);
        make.top.offset(offY);
        make.bottom.offset(-offY);
    }];
    [_commentL sizeToFit];

}
@end
