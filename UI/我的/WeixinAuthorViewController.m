//
//  WeixinAuthorViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/14.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "WeixinAuthorViewController.h"

@interface WeixinAuthorViewController ()

@end

@implementation WeixinAuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"微信提现授权";
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
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
