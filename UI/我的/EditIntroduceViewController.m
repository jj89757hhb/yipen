//
//  EditIntroduceViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/31.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "EditIntroduceViewController.h"

@interface EditIntroduceViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *numL;

@end

@implementation EditIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"自我介绍";
//       _textView.layoutManager.allowsNonContiguousLayout=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;//不加这句 textview位置会异常

    WS(weakSelf)
    [self setNavigationBarRightItem:@"完成" itemImg:nil withBlock:^(id sender) {
        [weakSelf modifyIntroduce];
    }];
    if ([DataSource sharedDataSource].userInfo.Descript) {
        _textView.text=[DataSource sharedDataSource].userInfo.Descript;
    }
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf finishAction];
    }];
//    _textView.scrollEnabled = NO;

}

-(void)finishAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)modifyIntroduce{
    [SVProgressHUD show];
//    NSString *nickName=[NSString stringWithFormat:@"Desc=%@&UID=%@",_textView.text,[DataSource sharedDataSource].userInfo.ID];
     NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_textView.text,@"Desc",[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    
    [HttpConnection editUserInfoWithParameter:dic pics:nil WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([response[@"ok"] isEqualToString:@"TRUE"]) {
                [SVProgressHUD showInfoWithStatus:@"修改成功"];
                [DataSource sharedDataSource].userInfo.Descript=_textView.text;
                [self.navigationController popViewControllerAnimated:YES];
            }
            else{
                [SVProgressHUD showErrorWithStatus:response[@"reason"]];
            }
            
            
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
    }];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
