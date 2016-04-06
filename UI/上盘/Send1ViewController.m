//
//  Send1ViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/1/4.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "Send1ViewController.h"
#import "SendShareViewController.h"
#import "SendPanYuanViewController.h"
#import "SendShareViewController.h"
#import "SendPenDaiFuViewController.h"
@interface Send1ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIButton *saleBtn;

@property (weak, nonatomic) IBOutlet UIButton *paiMaiBtn;
@property (weak, nonatomic) IBOutlet UIButton *panYuanBtn;
@property (weak, nonatomic) IBOutlet UIButton *panDaiFuBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation Send1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
//    float offX=-80;
     float offX=-60;
    UIFont *font=[UIFont systemFontOfSize:13];
    self.shareBtn.titleLabel.font=font;
    self.shareBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [self.shareBtn setTitle:@"发分享" forState:UIControlStateNormal];
    [self.shareBtn setTitleColor:MIDDLEBLACK forState:UIControlStateNormal];
//    [self.shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -100, -80, 0)];
     [self.shareBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, offX, -80, 0)];
    [self.shareBtn setTag:10];
    
    self.saleBtn.titleLabel.font=font;
    [self.saleBtn setTitle:@"发出售" forState:UIControlStateNormal];
    [self.saleBtn setTitleColor:MIDDLEBLACK forState:UIControlStateNormal];
    [self.saleBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,offX, -80, 0)];
    [self.saleBtn setTag:11];
    
    self.paiMaiBtn.titleLabel.font=font;
    [self.paiMaiBtn setTitle:@"发拍卖" forState:UIControlStateNormal];
    [self.paiMaiBtn setTitleColor:MIDDLEBLACK forState:UIControlStateNormal];
    [self.paiMaiBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,offX, -80, 0)];
    [self.paiMaiBtn setTag:12];
    
    self.panYuanBtn.titleLabel.font=font;
    [self.panYuanBtn setTitle:@"发盘缘" forState:UIControlStateNormal];
    [self.panYuanBtn setTitleColor:MIDDLEBLACK forState:UIControlStateNormal];
    [self.panYuanBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,offX, -80, 0)];
    [self.panYuanBtn setTag:13];
    
    self.panDaiFuBtn.titleLabel.font=font;
    [self.panDaiFuBtn setTitle:@"发盘大夫" forState:UIControlStateNormal];
    [self.panDaiFuBtn setTitleColor:MIDDLEBLACK forState:UIControlStateNormal];
    [self.panDaiFuBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, offX, -80, 0)];
    [self.panDaiFuBtn setTag:14];
    
    [self.shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.saleBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
     [self.paiMaiBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
     [self.panYuanBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
         [self.panDaiFuBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    
    float tool_offX=(SCREEN_WIDTH-60*5)/6;
    float width=60;
    float offY=160;
    [self.shareBtn setFrame:CGRectMake(tool_offX, SCREEN_HEIGHT-offY, width, width)];
     [self.saleBtn setFrame:CGRectMake(tool_offX+width*1+tool_offX*1, SCREEN_HEIGHT-offY, width, width)];
     [self.paiMaiBtn setFrame:CGRectMake(tool_offX+width*2+tool_offX*2, SCREEN_HEIGHT-offY, width, width)];
     [self.panYuanBtn setFrame:CGRectMake(tool_offX+width*3+tool_offX*3, SCREEN_HEIGHT-offY, width, width)];
     [self.panDaiFuBtn setFrame:CGRectMake(tool_offX+width*4+tool_offX*4, SCREEN_HEIGHT-offY, width, width)];
  
    [self.closeBtn setFrame:CGRectMake((SCREEN_WIDTH-60)/2, CGRectGetMaxY(_shareBtn.frame)+15, 60, 60)];
    
}

-(void)shareAction:(UIButton*)sender{
//    SendShareViewController *sendShare=[[SendShareViewController alloc] initWithNibName:nil bundle:nil];
//    [self.navigationController pushViewController:sendShare animated:YES];
    if (sender.tag==10) {
        SendShareViewController *ctr=[Storyboard instantiateViewControllerWithIdentifier:@"SendShareViewController"];
        ctr.enterType=1;
        ctr.title=@"发布分享";
        [self.navigationController pushViewController:ctr animated:YES];
        
    }
    else if (sender.tag==11){//出售
        SendShareViewController *ctr=[Storyboard instantiateViewControllerWithIdentifier:@"SendShareViewController"];
        ctr.enterType=2;
        
        ctr.title=@"发布出售";
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(sender.tag==12){//拍卖
        SendShareViewController *ctr=[Storyboard instantiateViewControllerWithIdentifier:@"SendShareViewController"];
        ctr.enterType=3;
        ctr.title=@"发布拍卖";
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(sender.tag==13){//
        
//        SendShareViewController *ctr=[Storyboard instantiateViewControllerWithIdentifier:@"SendShareViewController"];
//        ctr.enterType=4;
//        [self.navigationController pushViewController:ctr animated:YES];
        SendPanYuanViewController *ctr=[[SendPanYuanViewController alloc] init];
        ctr.title=@"发布盆缘";
        [self.navigationController pushViewController:ctr animated:YES];
    }
    else if(sender.tag==14){//盆大夫
        SendPenDaiFuViewController *ctr=[[SendPenDaiFuViewController alloc] initWithNibName:nil bundle:nil];
         ctr.title=@"发布盆大夫";
        [self.navigationController pushViewController:ctr animated:YES];
    }
   
}
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
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
