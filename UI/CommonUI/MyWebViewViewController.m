//
//  MyWebViewViewController.m
//  EduSoho
//
//  Created by 华斌 胡 on 16/1/12.
//  Copyright © 2016年 Kuozhi Network Technology. All rights reserved.
//

#import "MyWebViewViewController.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface MyWebViewViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (nonatomic,strong) NJKWebViewProgress *progressProxy;
@end

@implementation MyWebViewViewController
CGFloat const HZProgressBarHeight = 2.5;
NSInteger const HZProgresstagId = 222122323;
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title=self._title;
//    [ESHUDView showLoading];
    WS(weakSelf);


    [self initWebView];
      _progressProxy = [[NJKWebViewProgress alloc] init];
     myWebView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    [myWebView.scrollView addLegendHeaderWithRefreshingBlock:^{
        [weakSelf reloadWebView];
    }];
    [self setNavigationBarLeftItem:nil itemImg:[UIImage imageNamed:@"backIcon"] withBlock:^(id sender) {
        [weakSelf backActionWithType:1];
    }];
  
}

-(void)backActionWithType:(NSInteger)type{
    if (type==1) {
        if (myWebView.canGoBack) {
              WS(weakSelf)
            [self setNavigationBarRightItem:@"关闭" itemImg:nil withBlock:^(id sender) {
                [weakSelf backActionWithType:2];
            }];
            [myWebView goBack];
        }
        else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
           [self.navigationController popViewControllerAnimated:YES];
    }
   
    
}

-(void)initWebView{
    myWebView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
//    myWebView.delegate=self;
    [self.view addSubview:myWebView];
    NSURL *url=[NSURL URLWithString:_urlStr];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc] initWithURL:url];
    [myWebView loadRequest:request];
    
}

-(void)reloadWebView{
    [myWebView reload];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{
//    [ESHUDView dismiss];
    [myWebView.scrollView.header endRefreshing];
    [myWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    [myWebView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
        NSString *title = [webView stringByEvaluatingJavaScriptFromString: @"document.title"];
    if (!self.title) {
        self.title=title;
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [ESHUDView dismiss];
     [myWebView.scrollView.header endRefreshing];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestString = [[request URL] absoluteString];
    NSLog(@"requestString:%@",requestString);
    NSString * string = @"/wap/user/";
        NSString * string2 = @"/wap/classroom/";
    NSString *string3=@"/wap/course/";
    if ([requestString rangeOfString:string].location != NSNotFound) {
        NSLog(@"这个字符串中有");

    }
    return YES;
}

//显示加载进度view
- (NJKWebViewProgressView *)setupHZProgressSubviewWithTintColor:(UIColor *)tintColor{
    
    NJKWebViewProgressView *progressView;
    for (UIView *subview in [self.view subviews])
    {
        if (subview.tag == HZProgresstagId)
        {
            progressView = (NJKWebViewProgressView *)subview;
        }
    }
    
    if(!progressView)
    {
        progressView =  [[NJKWebViewProgressView alloc] initWithFrame:CGRectMake(0,myWebView.frame.origin.y, myWebView.frame.size.width, HZProgressBarHeight)];
        progressView.tag = HZProgresstagId;
        //		progressView.backgroundColor = tintColor;
        [self.view addSubview:progressView];
    }
    else
    {
        CGRect progressFrame = progressView.frame;
        progressFrame.origin.y = myWebView.frame.origin.y;
        progressView.frame = progressFrame;
    }
    
    return progressView;
    
}
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    
    if(progress >= 1.0000f)
        myWebView.backgroundColor = [UIColor clearColor];
    [self viewUpdatesForPercentage:progress andTintColor:[UIColor redColor]];
    if (progress == 0.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [UIView animateWithDuration:0.27 animations:^{
            
        }];
    }
    if (progress == 1.0) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
    }
}

- (void)viewUpdatesForPercentage:(float)percentage andTintColor:(UIColor *)tintColor
{
    NJKWebViewProgressView *progressView = [self setupHZProgressSubviewWithTintColor:tintColor];
    [progressView setProgress:percentage animated:YES];
    return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return NO;
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
