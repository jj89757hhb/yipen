//
//  ModifyPswViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/16.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "ModifyPswViewController.h"

@interface ModifyPswViewController ()

@end

@implementation ModifyPswViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sureBtn.layer.cornerRadius=5;
    self.sureBtn.clipsToBounds=YES;
    self.title=@"修改密码";
    self.line1.backgroundColor=Line_Color;
    self.line2.backgroundColor=Line_Color;
}
- (IBAction)sureAction:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
