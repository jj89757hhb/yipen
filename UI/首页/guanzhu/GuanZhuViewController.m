//
//  GuanZhuViewController.m
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "GuanZhuViewController.h"

@interface GuanZhuViewController ()
@property (nonatomic, strong)SlideSwitchView *slideSwitchView;
@property (nonatomic, strong)AIMultiDelegate *multiDelegate;
@end

@implementation GuanZhuViewController

- (instancetype)initSlideSwitchView:(SlideSwitchView *)slideSwitchView{
    self = [super init];
    if (self) {
        _slideSwitchView = slideSwitchView;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_slideSwitchView) {
        _multiDelegate = [[AIMultiDelegate alloc] init];
        [_multiDelegate addDelegate:self];
        [_multiDelegate addDelegate:_slideSwitchView];
        self.tableView.delegate = (id)_multiDelegate;
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
