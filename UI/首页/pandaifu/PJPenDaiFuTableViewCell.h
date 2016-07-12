//
//  PenDaiFuTableViewCell.h
//  panjing
//
//  Created by 华斌 胡 on 16/3/24.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PraiseView.h"
#import "BottomToolView.h"
#import "PenJinInfo.h"
static float comment_FontSize=14;
typedef void(^ClickBlock)(id sender);
typedef void(^PraiseBlock)(id sender);
typedef void(^CollectBlock)(id sender);
typedef void(^CommentBlock)(id sender);
typedef void(^ChatBlock)(id sender);
typedef void(^AttentionBlock)(id sender);
@protocol PJPenDaiFuTableViewCellDeleagte <NSObject>

-(void)tapImageViewWithCellIndex:(NSIndexPath*)indexPath imageIndex:(NSInteger)index;
-(void)gotoDetailView:(NSIndexPath*)indexPath;//处理scrollview的拦截问题
@end
@interface PJPenDaiFuTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *headView;//头像
@property(nonatomic,strong)UIScrollView *imageScrollView;
@property(nonatomic,strong)UILabel *nickNameL;//昵称
@property(nonatomic,strong)UIImageView *levelIV;//等级
@property(nonatomic,strong)UIImageView *certificateIV;//认证
@property(nonatomic,strong)UIImageView *memberIV;//会员
@property(nonatomic,strong)UILabel *timeL;//时间
@property(nonatomic,strong)UIButton *attentBtn;//关注
@property(nonatomic,strong)UIImageView *treeIcon;//小图标
@property(nonatomic,strong)UILabel *descriptionL;//内容描述
@property(nonatomic,strong)UILabel *titleL;//标题
@property(nonatomic,strong)UIView *generalGB;//概貌底部视图
@property(nonatomic,strong)UIView *h_line;//横线
@property(nonatomic,strong)UIView *v_line;//竖线
@property(nonatomic,strong)UIView *v_line2;//左边
@property(nonatomic,strong)UIView *v_line3;//右边
@property(nonatomic,strong)UILabel *heightL;//高度
@property(nonatomic,strong)UILabel *heightNumL;//高度数值
@property(nonatomic,strong)UILabel *widthL;//宽带
@property(nonatomic,strong)UILabel *widthNumL;//
@property(nonatomic,strong)UILabel *diameterL;//直径
@property(nonatomic,strong)UILabel *diameterNumL;
@property(nonatomic,strong)UILabel *ageL;//树龄
@property(nonatomic,strong)UILabel *ageNumL;

@property(nonatomic,strong)UIImageView *commentIV;//评论图标

@property(nonatomic,strong)UIButton *praiseBtn;//赞
@property(nonatomic,strong)UIButton *collectBtn;//收藏
@property(nonatomic,strong)UIButton *commentBtn;//评论
@property(nonatomic,strong)UIButton *chatBtn;//私信
@property (nonatomic,copy) ClickBlock clickBlock;

@property (nonatomic,copy) PraiseBlock praiseBlock;
@property (nonatomic,copy) CollectBlock collectBlock;
@property (nonatomic,copy) CommentBlock commentBlock;
@property (nonatomic,copy) ChatBlock chatBlock;
@property (nonatomic,copy) AttentionBlock attentionBlock;

@property(nonatomic,strong)PraiseView *praiseView;
@property(nonatomic,strong)BottomToolView *bottomToolView;
@property(nonatomic,strong)UIView *bottomLine;
@property(nonatomic,strong)PenJinInfo *info;
@property(nonatomic,strong)UILabel *isExpressL;//包邮
@property(nonatomic,strong)UILabel *saleStatusL;//出售状态
@property(nonatomic,strong)UILabel *priceL;//价格
@property(nonatomic,assign)NSInteger enterType;//0 分享列表 1 分享详情   2 出售  3 拍卖
@property(nonatomic,assign)BOOL isDetail;//是否是详情；
@property(nonatomic,weak)NSIndexPath *indexPath;
@property(nonatomic,weak)id <PJPenDaiFuTableViewCellDeleagte> delegate;
@end
