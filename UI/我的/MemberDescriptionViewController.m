//
//  MemberDescriptionViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/17.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "MemberDescriptionViewController.h"
#import "MemberPayViewController.h"
@interface MemberDescriptionViewController ()

@end

@implementation MemberDescriptionViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title=@"会员";
    self.joinBtn1.layer.cornerRadius=5;
    self.joinBtn1.clipsToBounds=YES;
    self.joinBtn2.layer.cornerRadius=5;
    self.joinBtn2.clipsToBounds=YES;
    [self.joinBtn1 addTarget:self action:@selector(joinAction:) forControlEvents:UIControlEventTouchUpInside];
     [self.joinBtn2 addTarget:self action:@selector(joinAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)joinAction:(UIButton*)sender{
    NSInteger enterType=0;
    if ([sender isEqual:_joinBtn1]) {
        enterType=0;
    }
    else{
        enterType=1;
    }
    MemberPayViewController *ctr=[[MemberPayViewController alloc] initWithNibName:nil bundle:nil];
    ctr.enterType=enterType;
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
