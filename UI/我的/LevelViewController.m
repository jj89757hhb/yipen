//
//  LevelViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/2/17.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "LevelViewController.h"
#import "LevelRuleViewController.h"
@interface LevelViewController ()

@end

@implementation LevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"等级";
    [self initView];
}

-(void)initView{
    bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 180)];
    [self.view addSubview:bgView];
    bgView.backgroundColor=WHITEColor;
    scoreL=[[UILabel alloc] initWithFrame:CGRectMake(10, 15, 60, 20)];
    scoreL.text=@"当前积分";
    scoreL.font=[UIFont systemFontOfSize:13];
    scoreNumL=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(scoreL.frame), scoreL.frame.origin.y, 80, 20)];
    scoreNumL.text=@"100";
    scoreNumL.textColor=[UIColor redColor];
    scoreNumL.font=[UIFont systemFontOfSize:13];
    [bgView addSubview:scoreL];
    [bgView addSubview:scoreNumL];
    float offX=10;
    [SVGloble colorFromHexRGB:@""];
    /*
     e4e4e4
     d1e5a3
     b9b366
     91a666
    
     
     669a97
      66779b
     
     966691
     c86686
     f06671
     */
    NSArray *colors=[NSArray arrayWithObjects:[SVGloble colorFromHexRGB:@"e4e4e4"],[SVGloble colorFromHexRGB:@"d1e5a3"],[SVGloble colorFromHexRGB:@"b9b366"],[SVGloble colorFromHexRGB:@"91a666"],[SVGloble colorFromHexRGB:@"669a97"],[SVGloble colorFromHexRGB:@"66779b"],[SVGloble colorFromHexRGB:@"966691"],[SVGloble colorFromHexRGB:@"c86686"],[SVGloble colorFromHexRGB:@"f06671"], nil];//+ (UIColor *)purpleColor;     // 0.5, 0.0, 0.5 RGB
//    + (UIColor *)brownColor;
    float width=(SCREEN_WIDTH-10*2)/9;
    for (int i=0; i<9; i++) {
        UILabel *segL=[[UILabel alloc] initWithFrame:CGRectMake(offX+width*i, CGRectGetMaxY(scoreL.frame)+10, width, 20)];
        segL.backgroundColor=colors[i];
        [bgView addSubview:segL];
    }
    
    arrowIV=[[UIImageView alloc] initWithFrame:CGRectMake(offX+10,  CGRectGetMaxY(scoreNumL.frame)+35, 28/2, 24/2)];
    arrowIV.image=[UIImage imageNamed:@"三角形"];
    [bgView addSubview:arrowIV];
    
    levelIV=[[UIImageView alloc] initWithFrame:CGRectMake(offX, CGRectGetMaxY(arrowIV.frame)+4, 40, 14)];
    levelIV.image=[UIImage imageNamed:@"lv1"];
    [bgView addSubview:levelIV];
    
    levelRuleBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, CGRectGetMaxY(scoreNumL.frame)+80, 70, 30)];
    [levelRuleBtn setTitle:@"等级规则" forState:UIControlStateNormal];
    [levelRuleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    levelRuleBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    levelRuleBtn.clipsToBounds=YES;
    levelRuleBtn.layer.cornerRadius=3;
    levelRuleBtn.layer.borderWidth=1;
    levelRuleBtn.layer.borderColor=[UIColor grayColor].CGColor;
    [bgView addSubview:levelRuleBtn];
    [levelRuleBtn addTarget:self action:@selector(ruleAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)ruleAction{
    LevelRuleViewController *level=[[LevelRuleViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:level animated:YES];
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
