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
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(sendGoodsAction)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)sendGoodsAction{
    if (!_expressNumTF.text.length) {
        [SVProgressHUD showInfoWithStatus:@"请填写快递单号"];
        return;
    }
    if (!_expressCompanyTF.text.length) {
        [SVProgressHUD showInfoWithStatus:@"请填写快递公司名称"];
        return;
    }
    
        [SVProgressHUD show];
        
        NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:_expressNumTF.text,@"CourierNo", _expressCompanyTF.text,@"Courier", [DataSource sharedDataSource].userInfo.ID,@"UID",_tranNo,@"tranNo",nil];
        [HttpConnection PutCourier:dic WithBlock:^(id response, NSError *error) {
            if (!error) {
                if ([response[@"ok"] boolValue]) {
                    [SVProgressHUD showInfoWithStatus:@"已发货"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else{
                    [SVProgressHUD showInfoWithStatus:response[KErrorMsg]];
                }
            }
            else{
                [SVProgressHUD showInfoWithStatus:ErrorMessage];
            }
            
        }];
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
