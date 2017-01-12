//
//  WeixinNoViewController.m
//  panjing
//
//  Created by 华斌 胡 on 2016/12/22.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "WeixinNoViewController.h"

@interface WeixinNoViewController ()

@end

@implementation WeixinNoViewController

- (void)viewDidLoad {
    self.title = @"问题反馈";
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
//    _weixinL.backgroundColor = Clear_Color;
//    [_weixinL setTextColor:BLACKCOLOR];
    UILabel *weiXinL = [[UILabel alloc] initWithFrame:CGRectMake(23, 40, 200, 20)];
    weiXinL.font = [UIFont systemFontOfSize:16];
    weiXinL.text = @"易盆微信公众号: imyipen";
//    [self.view addSubview:weiXinL];
}



-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)saveAction{
    UIImage *image = [UIImage imageNamed:@"微信二维码.png"];

     UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
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
