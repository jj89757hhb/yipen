//
//  YiPenInfoViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "YiPenInfoViewController.h"

@interface YiPenInfoViewController ()

@end

@implementation YiPenInfoViewController

- (void)viewDidLoad {
    self.title=@"易盆";
    [super viewDidLoad];
    self.yiPenNumL.textAlignment=NSTextAlignmentCenter;
    self.nickNameL.textAlignment=NSTextAlignmentCenter;
    self.yiPenNumL.font=[UIFont systemFontOfSize:22];
    self.yiPenNumL.textColor=[UIColor redColor];
    self.nickNameL.textColor=[UIColor darkGrayColor];
    self.nickNameL.font=[UIFont systemFontOfSize:14];
    self.nickNameL.text=[DataSource sharedDataSource].userInfo.NickName;
    self.yiPenNumL.text=[DataSource sharedDataSource].userInfo.ID;
}

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
