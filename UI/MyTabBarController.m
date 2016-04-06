//
//  MyTabBarController.m
//  panjing
//
//  Created by 华斌 胡 on 15/11/16.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "MyTabBarController.h"
#import "TabBarBtn.h"
@interface MyTabBarController ()

@end

@implementation MyTabBarController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.tabBar.hidden=YES;
//    float width=S 
    for (int i=0; i<2;i++) {
        TabBarBtn *tabBar=[[TabBarBtn alloc] initWithFrame:CGRectMake(i+SCREEN_WIDTH/2*i, SCREEN_HEIGHT-49, SCREEN_WIDTH/2, 49)];
        tabBar.tag=10+i;
        
        [tabBar addTarget:self action:@selector(tabBarAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:tabBar];
        if (i==0) {
            [tabBar setBackgroundColor:[UIColor blueColor]];
            
        }
        else{
            [tabBar setBackgroundColor:[UIColor greenColor]];
        }
    }
}
//切换tab
-(void)tabBarAction:(UIButton*)sender{
    self.selectedIndex=sender.tag-10;
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
