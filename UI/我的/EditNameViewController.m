//
//  EditNameViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/31.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "EditNameViewController.h"

@interface EditNameViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFielf;
@property (weak, nonatomic) IBOutlet UIView *bgView;


@end

@implementation EditNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    WS(weakSelf)
    [self setNavigationBarRightItem:@"完成" itemImg:nil withBlock:^(id sender) {
//        weakSelf.changeNameBlock(_textFielf.text);
        [weakSelf modifyName];
    }];
    self.title=@"昵称";
    if ( [DataSource sharedDataSource].userInfo.NickName) {
        _textFielf.text=[DataSource sharedDataSource].userInfo.NickName;
    }
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}


-(void)finishAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)modifyName{
    [SVProgressHUD show];
//    NSString *nickName=[NSString stringWithFormat:@"NickName=%@&UID=%@",_textFielf.text,[DataSource sharedDataSource].userInfo.ID];
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_textFielf.text,@"NickName",[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    
    [HttpConnection editUserInfoWithParameter:dic pics:nil WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([response[@"ok"] boolValue]) {
                [SVProgressHUD showInfoWithStatus:@"修改成功"];
                [DataSource sharedDataSource].userInfo.NickName=_textFielf.text;
                [self finishAction];
            }
            else{
                [SVProgressHUD showErrorWithStatus:response[@"Reason"]];
            }
            
            
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
    }];

}

//-(void)setChangeNameBlock:(ChangeNameBlock)changeNameBlock
//{
//    if (changeNameBlock) {
//        _changeNameBlock = nil;
//        _changeNameBlock = [changeNameBlock copy];
//    }
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
