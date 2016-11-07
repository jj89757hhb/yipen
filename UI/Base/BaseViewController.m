//
//  BaseViewController.m
//  panjing
//
//  Created by 华斌 胡 on 15/11/16.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController (){
    NavigationTouchButtonBlock nvRightBtnAction;
    NavigationTouchButtonBlock nvLeftBtnAction;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:VIEWBACKCOLOR];
//    self.navigationItem.hidesBackButton=YES;
//    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
}

//返回
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
//    [tabBar xmTabBarHidden:NO animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
//    [tabBar xmTabBarHidden:YES animated:NO];
}

- (void)setNavigationBarLeftItem:(NSString *)title itemImg:(UIImage *)itemImg withBlock:(NavigationTouchButtonBlock)block
{
    if (block == nil)
    {
        return;
    }
    if (title == nil && itemImg == nil)
    {
        return;
    }
    
    int nBtnWidth = 0;
    int nBtnHeight = 0;
    if (itemImg)
    {
        nBtnWidth = itemImg.size.width;
        nBtnHeight = itemImg.size.height;
    }
    else
    {
        // CGSize size = [CommonFuction sizeOfString:title withFontSize:14.0f];
        // nBtnWidth = size.width;
        //nBtnHeight = size.height;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (block)
    {
        nvLeftBtnAction = nil;
        nvLeftBtnAction = [block copy];
    }
    [btn addTarget:self action:@selector(OnClickLeft:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, nBtnWidth, nBtnHeight)];
    /*这里可以加按钮背景*/
    [btn setBackgroundImage:itemImg forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTintColor:[UIColor redColor]];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    // self.navigationItem.leftBarButtonItem = backBtn;
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    if (ISBIGSYSTEM7)
    {
        negativeSpacer.width = -5;
    }
    else
    {
        negativeSpacer.width = 0;
    }
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects: backBtn, nil];
    
    
    // self.navigationItem.leftBarButtonItem.imageInsets =UIEdgeInsetsMake(0, 0, 0, 10);
}

//右边
- (void)setNavigationBarRightItem:(NSString *)title itemImg:(UIImage *)itemImg withBlock:(NavigationTouchButtonBlock)block
{
    if (block == nil) {
        return;
    }
    if (title == nil && itemImg == nil)
    {
        return;
    }
    if (block)
    {
        nvRightBtnAction = nil;
        nvRightBtnAction = [block copy];
    }
    
    int nBtnWidth = 0;
    int nBtnHeight = 0;
    if (itemImg)
    {
        nBtnWidth = itemImg.size.width;
        nBtnHeight = itemImg.size.height;
    }
    else
    {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:16.f] forKey:NSFontAttributeName];
        CGSize size = [title sizeWithAttributes:attributes];
        nBtnWidth = size.width;
        nBtnHeight = size.height;
    }
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.titleBtn=btn;
    [btn addTarget:self action:@selector(OnClickRight:) forControlEvents:UIControlEventTouchUpInside];
    [btn setFrame:CGRectMake(0, 0, nBtnWidth*2, nBtnHeight)];
    /*这里可以加按钮背景*/
    [btn setImage:itemImg forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:BLUECOLOR forState:UIControlStateNormal];
//    btn.titleLabel.textColor = Blue_Color;
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    // self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    if (ISBIGSYSTEM7)
    {
        negativeSpacer.width = -8;
    }
    else
    {
        negativeSpacer.width = 0;
    }
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: negativeSpacer,rightBtn, nil];
}

- (void)OnClickRight:(id)sender
{
    if (nvRightBtnAction)
    {
        nvRightBtnAction(sender);
    }

}

-(void)OnClickLeft:(id)sender{
    if (nvLeftBtnAction) {
        nvLeftBtnAction(sender);
//        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)hideTabBar:(BOOL)hide animated:(BOOL)isAnimate{
    XMTabBarController *tabBar=(XMTabBarController*)self.tabBarController;
    [tabBar xmTabBarHidden:hide animated:isAnimate];
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
