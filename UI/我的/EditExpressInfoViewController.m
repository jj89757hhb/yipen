//
//  EditExpressInfoViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/7/8.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "EditExpressInfoViewController.h"

@interface EditExpressInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *expressCompanyTF;
@property (weak, nonatomic) IBOutlet UITextField *expressNumTF;

@end

@implementation EditExpressInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"物流信息";
    [_expressCompanyTF becomeFirstResponder];
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
