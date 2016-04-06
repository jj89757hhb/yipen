//
//  ChatListViewController.m
//  EEC
//
//  Created by jiefu on 15/11/10.
//  Copyright © 2015年 jiefu. All rights reserved.
//

#import "ChatListViewController.h"
#import <RongIMKit/RongIMKit.h>
//#import "RCDChatListCell.h"

@interface ChatListViewController ()

@end

@implementation ChatListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置需要显示哪些类型的会话
    [self setDisplayConversationTypes:@[@(ConversationType_PRIVATE),
                                        @(ConversationType_DISCUSSION),
                                        @(ConversationType_CHATROOM),
                                        @(ConversationType_GROUP),
                                        @(ConversationType_APPSERVICE),
                                        @(ConversationType_SYSTEM)]];
    //设置需要将哪些类型的会话在会话列表中聚合显示
//    [self setCollectionConversationType:@[@(ConversationType_DISCUSSION),
//                                          @(ConversationType_GROUP)]];
    UIView * view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = VIEWBACKCOLOR;
    self.emptyConversationView=view;
    self.cellBackgroundColor = VIEWBACKCOLOR;
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    self.conversationListTableView.tableFooterView =footerView;
    self.conversationListTableView.backgroundColor = VIEWBACKCOLOR;
}

//重载函数，onSelectedTableRow 是选择会话列表之后的事件，该接口开放是为了便于您自定义跳转事件。在快速集成过程中，您只需要复制这段代码。
-(void)onSelectedTableRow:(RCConversationModelType)conversationModelType conversationModel:(RCConversationModel *)model atIndexPath:(NSIndexPath *)indexPath
{
    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
    [tabBar xmTabBarHidden:YES animated:NO];
    if (conversationModelType == RC_CONVERSATION_MODEL_TYPE_NORMAL) {
    RCConversationViewController *_conversationVC = [[RCConversationViewController alloc]init];
        [_conversationVC setMessageAvatarStyle:RC_USER_AVATAR_CYCLE];
    _conversationVC.conversationType = model.conversationType;
    _conversationVC.targetId = model.targetId;
//    _conversationVC.userName = model.conversationTitle;
    _conversationVC.title = model.conversationTitle;
//    _conversationVC.conversation = model;
    _conversationVC.unReadMessage = model.unreadMessageCount;
    _conversationVC.enableNewComingMessageIcon=YES;//开启消息提醒
    _conversationVC.enableUnreadMessageIcon=YES;
    [self.navigationController pushViewController:_conversationVC animated:YES];
    }

}

- (void)rcConversationListTableView:(UITableView *)tableView
                 commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                  forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
////自定义cell
//-(RCConversationBaseCell *)rcConversationListTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    RCConversationModel *model = self.conversationListDataSource[indexPath.row];
//    __block NSString *userName    = nil;
//    __block NSString *portraitUri = nil;
//    __weak ChatListViewController *weakSelf = self;
//    //此处需要添加根据userid来获取用户信息的逻辑，extend字段不存在于DB中，当数据来自db时没有extend字段内容，只有userid
//    if (nil == model.extend) {
//        // Not finished yet, To Be Continue...
//        if(model.conversationType == ConversationType_SYSTEM && [model.lastestMessage isMemberOfClass:[RCContactNotificationMessage class]])
//        {
//            RCContactNotificationMessage *_contactNotificationMsg = (RCContactNotificationMessage *)model.lastestMessage;
//            NSDictionary *_cache_userinfo = [[NSUserDefaults standardUserDefaults]objectForKey:_contactNotificationMsg.sourceUserId];
//            if (_cache_userinfo) {
//                userName = _cache_userinfo[@"username"];
//                portraitUri = _cache_userinfo[@"portraitUri"];
//            }
//        }
//    }else{
//        RCUserInfo *user = (RCUserInfo *)model.extend;
//        userName    = user.name;
//        portraitUri = user.portraitUri;
//    }
//    
//    RCDChatListCell *cell = [[RCDChatListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
//    cell.lblDetail.text =[NSString stringWithFormat:@"来自%@的好友请求",userName];
//    [cell.ivAva sd_setImageWithURL:[NSURL URLWithString:portraitUri] placeholderImage:[UIImage imageNamed:@"system_notice"]];
//    cell.labelTime.text = [self ConvertMessageTime:model.sentTime / 1000];
//    return cell;
//}
//#pragma mark - private
//- (NSString *)ConvertMessageTime:(long long)secs {
//    NSString *timeText = nil;
//    
//    NSDate *messageDate = [NSDate dateWithTimeIntervalSince1970:secs];
//    
//    //    DebugLog(@"messageDate==>%@",messageDate);
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    
//    NSString *strMsgDay = [formatter stringFromDate:messageDate];
//    
//    NSDate *now = [NSDate date];
//    NSString *strToday = [formatter stringFromDate:now];
//    NSDate *yesterday = [[NSDate alloc] initWithTimeIntervalSinceNow:-(24 * 60 * 60)];
//    NSString *strYesterday = [formatter stringFromDate:yesterday];
//    
//    NSString *_yesterday = nil;
//    if ([strMsgDay isEqualToString:strToday]) {
//        [formatter setDateFormat:@"HH':'mm"];
//    } else if ([strMsgDay isEqualToString:strYesterday]) {
//        _yesterday = NSLocalizedStringFromTable(@"Yesterday", @"RongCloudKit", nil);
//        //[formatter setDateFormat:@"HH:mm"];
//    }
//    
//    if (nil != _yesterday) {
//        timeText = _yesterday; //[_yesterday stringByAppendingFormat:@" %@", timeText];
//    } else {
//        timeText = [formatter stringFromDate:messageDate];
//    }
//    
//    return timeText;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
