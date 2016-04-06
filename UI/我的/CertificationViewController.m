//
//  CertificationViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/17.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "CertificationViewController.h"
#import "ApplyIdentityViewController.h"
@interface CertificationViewController ()

@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"认证";
    [self.verifyBtn addTarget:self action:@selector(verifyAction) forControlEvents:UIControlEventTouchUpInside];
}

//认证
-(void)verifyAction{
    ApplyIdentityViewController *ctr=[[ApplyIdentityViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:ctr animated:YES];
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
