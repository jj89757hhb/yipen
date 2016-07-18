//
//  MessageCommentTableViewCell.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MessageCommentTableViewCell.h"

@implementation MessageCommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.headIV.clipsToBounds=YES;
    self.headIV.contentMode=UIViewContentModeScaleAspectFill;
    self.headIV.layer.cornerRadius=30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(PenJinInfo *)info{
    _info=info;
    [_headIV sd_setImageWithURL:[NSURL URLWithString:info.CommUser.UserHeader] placeholderImage:Default_Image];
    _nickNameL.text=info.CommUser.NickName;
    _timeL.text=info.CommentTime;
    if (info.Attach.count) {
         [_treeIV sd_setImageWithURL:[NSURL URLWithString:info.Attach[0]] placeholderImage:Default_Image];
    }
    _titleL.text=info.Title;
    _replyL.text=info.Message;
    _contentL.text=info.Descript;
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
}
@end
