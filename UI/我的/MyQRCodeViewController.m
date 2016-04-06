//
//  MyQRCodeViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/17.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MyQRCodeViewController.h"
#import "QRCodeGenerator.h"
@interface MyQRCodeViewController ()

@end

@implementation MyQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"我的二维码";
    self.view.backgroundColor=WHITEColor;
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:[DataSource sharedDataSource].userInfo.UserHeader] placeholderImage:nil];
    self.headIV.contentMode=UIViewContentModeScaleAspectFill;
    self.headIV.clipsToBounds=YES;
    self.headIV.layer.cornerRadius=30;
    UIImage *codeImage=[QRCodeGenerator qrImageForString:[DataSource sharedDataSource].userInfo.ID imageSize:_QRBgIV.bounds.size.width];
    NSLog(@"codeImage:%@",codeImage);
    self.QRBgIV.image=codeImage;
//    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(30, 30, 80, 20)];
//    label.text=@"不错";
//    [_QRBgIV addSubview:label];
}
- (IBAction)switchAction:(id)sender {
    if (!_mySwitch.isOn) {
        [_headIV setHidden:YES];
    }
    else{
        [_headIV setHidden:NO];
    }
}
- (IBAction)saveAction:(id)sender {
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(200 , 200), NO, 1);     //设置截屏大小
       [[_QRBgIV layer] renderInContext:UIGraphicsGetCurrentContext()];
     UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pictureName= [NSString stringWithFormat:@"yipen_%d.png",1];
     NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    UIImageWriteToSavedPhotosAlbum(viewImage, self,
                                   @selector(image:didFinishSavingWithError:contextInfo:), nil);
//
//    NSData *imageData=UIImageJPEGRepresentation(viewImage, 1);
//   [imageData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
}
- (IBAction)shareAction:(id)sender {
    share=[[ShareView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    share.enterType=1;
//    share.title=_currentActivity.title;
//    share.content=_currentActivity.intro;
//    share._id=_currentActivity._id;
    share.backgroundColor= [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow  addSubview:share];
}



- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [SVProgressHUD showInfoWithStatus:msg];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
//    [self showViewController:alert sender:nil];
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
