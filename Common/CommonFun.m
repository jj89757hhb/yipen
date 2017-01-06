//
//  CommonFun.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/25.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "CommonFun.h"
#import<CoreText/CoreText.h>
@implementation CommonFun

//判断字符是否为空
+(BOOL)isSpaceCharacter:(NSString*)text{
    BOOL isSpace=YES;
    if (text.length&&[[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]) {
        isSpace=NO;
    }
    return isSpace;
    
}

//日期格式时间
+(NSString*)translateDateWithCreateTime:(NSInteger)createTime{
    NSDateFormatter* f=[[NSDateFormatter alloc]init];
//    [f setDateFormat:@"yyyy.MM.dd HH:mm"];
       [f setDateFormat:@"MM-dd HH:mm"];
    NSDate *date=nil;
    NSString *timeStr=[NSString stringWithFormat:@"%ld",createTime];
    if ([timeStr length]>=10) {
        date = [NSDate dateWithTimeIntervalSince1970:[[timeStr substringToIndex:10] longLongValue]];
    }
    else{
        date = [NSDate dateWithTimeIntervalSince1970:[timeStr longLongValue]];
    }
    timeStr=[f  stringFromDate:date];
    return timeStr;
}


//倒计时
+(NSString*)countdown:(long long)lastTime{
    NSString *str=[NSString string];
    long difference= time(NULL)-lastTime;
    NSInteger i= difference/60;//分钟
        if (i<60) {
//            str=[NSString stringWithFormat:@"%ld分钟前",i];
            NSInteger remaining_time=difference%60;
            str=[NSString stringWithFormat:@"%ld分钟前",i];
        }
        else if(i<60*24){
            NSInteger i= difference/60/60;
            str=[NSString stringWithFormat:@"%ld小时前",i];
        }
        else if(i<60*24*30){
            NSInteger i= difference/60/60/24;
            str=[NSString stringWithFormat:@"%ld天前",i];
        }
        else if(i<60*24*30*12){
            NSInteger i= difference/60/60/24/12;
            str=[NSString stringWithFormat:@"%ld个月前",i-1];
        }
        else{
            NSInteger i= difference/60/60/24/12/30;
            str=[NSString stringWithFormat:@"%ld年前",i];
        }
    
    
    return str;
}

//倒计时
+(NSMutableAttributedString*)timerFireMethod:(long long)time{
    
//    NSDateFormatter *f1 = [[NSDateFormatter alloc] init];
//    [f1 setDateFormat:@"yyyy-MM-dd HH:mm:ss.S"];
//
//    NSDate *theDay=[NSDate dateWithTimeIntervalSince1970:time];
//    NSCalendar *cal = [NSCalendar currentCalendar];//定义一个NSCalendar对象
//    
//    NSDate *today = [NSDate date];//得到当前时间
//    
//    //用来得到具体的时差
//    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
//    NSDateComponents *d = [cal components:unitFlags fromDate:today toDate:theDay options:0];
//    
//    NSString *countdown = [NSString stringWithFormat:@"%d日%d小时%d分钟%d秒", [d month],[d day], [d hour], [d minute], [d second]];
//    
////    self.timeLabel.text = countdown;
//    NSLog(@"countdown:%@",countdown);
//    return countdown ;
    NSDate *today = [NSDate date];//得到当前时间
//    NSDate*  startDate  = [ [ NSDate alloc] init ];
      NSDate *startDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSGregorianCalendar ];
    NSUInteger unitFlags =
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
    NSDateComponents *cps = [chineseClendar components:unitFlags fromDate:today  toDate: startDate options:0];
    
        NSInteger diffYear = [cps year];
       NSInteger diffMon  = [cps month];
    
    NSInteger diffDay   = [cps day];
    NSInteger diffHour = [cps hour];
    NSInteger diffMin    = [cps minute];
    NSInteger diffSec   = [cps second];

 

//    NSLog(  @" From Now to %@, diff: Years: %d  Months: %d, Days; %d, Hours: %d, Mins:%d, sec:%d",
//          [today description], diffYear, diffMon, diffDay, diffHour, diffMin,diffSec );
    NSString *countdown = [NSString stringWithFormat:@"距离结束: %ld天 %ld小时 %ld分钟 %ld秒   ", diffDay,diffHour, diffMin, diffSec];
    NSString *diffDayStr=[NSString stringWithFormat:@"%ld",diffDay];
     NSString *diffHourStr=[NSString stringWithFormat:@"%ld",diffHour];
     NSString *diffMinStr=[NSString stringWithFormat:@"%ld",diffMin];
    NSString *diffSecStr=[NSString stringWithFormat:@"%ld",diffSec];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:countdown];
    if (diffSec<0) {
        countdown=[NSString stringWithFormat:@"拍卖已结束   "];
        return attributedStr;
    }

//    NSDictionary *attributeDict = [NSDictionary dictionaryWithObjectsAndKeys:
//                                   [UIFont systemFontOfSize:14.0],NSFontAttributeName,
//                                   BLACKCOLOR,NSForegroundColorAttributeName,nil];
//    NSDictionary *attributeDict2 = [NSDictionary dictionaryWithObjectsAndKeys:
//                                   [UIFont systemFontOfSize:14.0],NSFontAttributeName,
//                                   RedColor,NSForegroundColorAttributeName,nil];
//    [attributedStr addAttribute:NSFontAttributeName
//                          value:[UIFont systemFontOfSize:14.0]
//                          range:NSMakeRange(0, attributedStr.length)];
//    [attributedStr addAttribute:NSForegroundColorAttributeName
//                          value:[UIColor redColor]
//                          range:NSMakeRange(6, 1)];
//    [attributedStr addAttribute:NSForegroundColorAttributeName
//                          value:[UIColor greenColor]
//                          range:NSMakeRange(8, 1)];
    int begin_Location=6;
    int space_Lenght=1;
//    [attributedStr addAttribute:(NSString *)kCTForegroundColorAttributeName
//    
//                        value:(id)[UIColor redColor].CGColor
//                        range:NSMakeRange(begin_Location, diffDayStr.length)];
//
//    [attributedStr addAttribute:(NSString *)kCTForegroundColorAttributeName
//                        value:(id)[UIColor redColor].CGColor
//                        range:NSMakeRange(begin_Location+diffDayStr.length+1+space_Lenght, diffHourStr.length)];
//    
//    [attributedStr addAttribute:(NSString *)kCTForegroundColorAttributeName
//                          value:(id)[UIColor redColor].CGColor
//                          range:NSMakeRange(begin_Location+diffDayStr.length+1+space_Lenght+diffHourStr.length+2+space_Lenght, diffMinStr.length)];
//    
//    [attributedStr addAttribute:(NSString *)kCTForegroundColorAttributeName
//                          value:(id)[UIColor redColor].CGColor
//                          range:NSMakeRange(begin_Location+diffDayStr.length+1+space_Lenght+diffHourStr.length+2+space_Lenght  +diffMinStr.length+2+space_Lenght, diffSecStr.length)];

    float size=14;
    [attributedStr addAttribute:NSFontAttributeName
     
                        value:[UIFont systemFontOfSize:size]
     
                        range:NSMakeRange(begin_Location, diffDayStr.length)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                        value:[UIColor redColor]
     
                        range:NSMakeRange(begin_Location, diffDayStr.length)];
    
    
    [attributedStr addAttribute:NSFontAttributeName
     
                        value:[UIFont systemFontOfSize:size]
     
                        range:NSMakeRange(begin_Location+diffDayStr.length+1+space_Lenght, diffHourStr.length)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                        value:[UIColor redColor]
     
                        range:NSMakeRange(begin_Location+diffDayStr.length+1+space_Lenght, diffHourStr.length)];
    
    [attributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:size]
     
                          range:NSMakeRange(begin_Location+diffDayStr.length+1+space_Lenght+diffHourStr.length+2+space_Lenght, diffMinStr.length)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:NSMakeRange(begin_Location+diffDayStr.length+1+space_Lenght+diffHourStr.length+2+space_Lenght, diffMinStr.length)];
    
    [attributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:size]
     
                          range:NSMakeRange(begin_Location+diffDayStr.length+1+space_Lenght+diffHourStr.length+2+space_Lenght  +diffMinStr.length+2+space_Lenght, diffSecStr.length)];
    
    [attributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor redColor]
     
                          range:NSMakeRange(begin_Location+diffDayStr.length+1+space_Lenght+diffHourStr.length+2+space_Lenght  +diffMinStr.length+2+space_Lenght, diffSecStr.length)];
    
    
    return attributedStr;

    
}

+(CGSize)sizeWithString:(NSString *)string font:(UIFont *)font size:(CGSize)contentSize
{
    CGRect rect = [string boundingRectWithSize:contentSize//限制最大的宽度和高度
                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading  |NSStringDrawingUsesLineFragmentOrigin//采用换行模式
                                    attributes:@{NSFontAttributeName: font}//传人的字体字典
                                       context:nil];
    
    return rect.size;
}

+ (UIViewController *)viewControllerHasNavigation:(UIView *)aView
{
    for (UIView *next = aView.superview; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            if (((UIViewController*)nextResponder).navigationController) {
                return (UIViewController*)nextResponder;
            }
        }
    }
    return nil;
}

//去掉小数
+ (NSString *)delDecimal:(NSString *)inputNum{
    NSString *outNum=nil;
    NSInteger num = [inputNum integerValue];
    outNum=[NSString stringWithFormat:@"%ld",num];
    return outNum;
}


+ (UIViewController *)viewControllerHasNavgation:(UIView *)aView
{
    for (UIView *next = aView.superview; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            if (((UIViewController*)nextResponder).navigationController) {
                return (UIViewController*)nextResponder;
            }
        }
    }
    return nil;
}

+(NSInteger)upLoadPictureNum{
    NSInteger num =4;
    if ([[DataSource sharedDataSource].userInfo.RoleType isEqualToString:@"1"]||[[DataSource sharedDataSource].userInfo.RoleType isEqualToString:@"2"]) {
        num = 9;
    }
    return num;
}

+(NSString *)getVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    //    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
//    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
       NSString *app_Version = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_Version;
}

@end
