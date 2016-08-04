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
    [self updateUI];
}

-(void)updateUI{

    [_headIV sd_setImageWithURL:[NSURL URLWithString:[DataSource sharedDataSource].userInfo.UserHeader] placeholderImage:Default_Image];
    _nameL.text=[DataSource sharedDataSource].userInfo.NickName;
    [_nameL sizeToFit];
    if ([DataSource sharedDataSource].userInfo.CertifiInfo.length) {
        _verifyInfoL.text=[NSString stringWithFormat:@"认证信息:%@",[DataSource sharedDataSource].userInfo.CertifiInfo];
    }
    if (![[DataSource sharedDataSource].userInfo.IsCertifi boolValue]) {
        [_verifyIV setHidden:YES];
    }
    
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
