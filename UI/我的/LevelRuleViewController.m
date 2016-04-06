//
//  LevelRuleViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/17.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "LevelRuleViewController.h"

@interface LevelRuleViewController ()

@end

@implementation LevelRuleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    self.title=@"等级规则";
    WS(weakSelf)
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"返回"] withBlock:^(id sender) {
        [weakSelf backAction];
    }];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)initView{
    myScroll=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:myScroll];
    levelCateL=[[UILabel alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 20)];
    levelCateL.text=@"等级分类";
    levelCateL.textAlignment=NSTextAlignmentCenter;
    [myScroll addSubview:levelCateL];
    levelCateL.font=[UIFont systemFontOfSize:14];
    levelCateL.textColor=[UIColor darkGrayColor];
    float offX=(SCREEN_WIDTH-150)/2;
    float offY=10;
    NSString *numStr=nil;
    for (int i=0; i<9; i++) {
        UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(offX, 30+14*i+offY*i, 40, 14)];//40 14
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"lv%d",i+1]]];
        [myScroll addSubview:imageView];
        UILabel *numL=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame)+20, imageView.frame.origin.y, 80, 20)];
        numL.textAlignment=NSTextAlignmentRight;
        numL.textColor=[UIColor darkGrayColor];
        numL.font=[UIFont systemFontOfSize:15];
        if (i==0) {
            numStr=@"100";
        }
        else if (i==1){
             numStr=@"500";
        }
        else if (i==2){
             numStr=@"1000";
        }
        else if (i==3){
             numStr=@"3000";
        }
        else if (i==4){
             numStr=@"6000";
        }
        else if (i==5){
            numStr=@"18000";
        }
        else if (i==6){
            numStr=@"25000";
        }
        else if (i==7){
            numStr=@"40000";
        }
        else if (i==8){
            numStr=@"100000";
        }
        
        numL.text=numStr;
        [myScroll addSubview:numL];
    }
    
    
    levelRule=[[UILabel alloc] initWithFrame:CGRectMake(0, 260, SCREEN_WIDTH, 20)];
    levelRule.text=@"等级细则";
    levelRule.textAlignment=NSTextAlignmentCenter;
    [myScroll addSubview:levelRule];
    levelRule.font=[UIFont systemFontOfSize:14];
    levelRule.textColor=[UIColor darkGrayColor];
    
    NSArray *array1=[[NSArray alloc] initWithObjects:@"点赞",@"被赞",@"评论",@"发分享",@"交易",@"拍卖", @"盆缘",@"盆大夫",@"发布活动",@"参加活动",@"发布友园",@"发布托管"@"发布享园",@"分享至",nil];
    NSArray *array2=[[NSArray alloc] initWithObjects:@"+1", @"+2",@"+2",@"+5",@"+10",@"+15",@"+10",@"+5",@"+15",@"+5",@"+10",@"+25",@"+25",@"+25",nil];
    for (int i=0; i<9; i++) {
      
        
        UILabel *leftL=[[UILabel alloc] initWithFrame:CGRectMake(offX, CGRectGetMaxY(levelRule.frame) +14*i+offY*i, 60, 20)];
        leftL.textAlignment=NSTextAlignmentLeft;
        leftL.textColor=[UIColor darkGrayColor];
        leftL.font=[UIFont systemFontOfSize:15];
        
        leftL.text=array1[i];
        [myScroll addSubview:leftL];
        
        
        UILabel *numL=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(leftL.frame)+20, leftL.frame.origin.y, 60, 20)];
        numL.textAlignment=NSTextAlignmentRight;
        numL.textColor=[UIColor darkGrayColor];
        numL.font=[UIFont systemFontOfSize:15];
  
        numL.text=array2[i];
        [myScroll addSubview:numL];
    }

    
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
