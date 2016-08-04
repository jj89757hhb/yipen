//
//  PanYuanViewController.m
//  panjing
//
//  Created by 华斌 胡 on 15/12/29.
//  Copyright © 2015年 华斌 胡. All rights reserved.
//

#import "PanYuanViewController.h"
#import "PenJinInfo.h"
@interface PanYuanViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong)SlideSwitchView *slideSwitchView;
@property (nonatomic, strong)AIMultiDelegate *multiDelegate;
@property(nonatomic,strong)NSMutableArray *imageUrls;
@property(nonatomic,strong)NSMutableArray *list;
@property(nonatomic,strong)NSMutableArray *heightList;
//@property(nonatomic,strong)NSString *ID;//盆景id
@property(nonatomic,strong)PenJinInfo *info;
@end

@implementation PanYuanViewController

- (instancetype)initSlideSwitchView:(SlideSwitchView *)slideSwitchView{
    self = [super init];
    if (self) {
        _slideSwitchView = slideSwitchView;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.list=[[NSMutableArray alloc] init];
    self.imageUrls=[[NSMutableArray alloc] init];
    self.heightList=[[NSMutableArray alloc] initWithObjects:@"10cm之内",@"10cm-30cm",@"30cm-60cm",@"60cm-100cm",@"100cm以上", nil];
    [_imageUrls addObject:@"http://img.pconline.com.cn/images/upload/upc/tx/itbbs/1106/26/c2/8138154_1309077121193_1024x1024it.jpg"];
    [_imageUrls addObject:@"http://www.photo0086.com/member/751/pic/201204191650075075.JPG"];
    [_imageUrls addObject:@"http://image13-c.poco.cn/mypoco/myphoto/20121126/19/64947591201211261905061490497461183_000.jpg?1800x1500_120"];
    [self initView];

//    if (_slideSwitchView) {
//        _multiDelegate = [[AIMultiDelegate alloc] init];
//        [_multiDelegate addDelegate:self];
//        [_multiDelegate addDelegate:_slideSwitchView];
//        self.tableView.delegate = (id)_multiDelegate;
//    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self requestData];
}

-(void)initView{
    float offX=10;
        float bottom_Height=60;
    bgView=[[UIView alloc] initWithFrame:CGRectMake(offX, offX, SCREEN_WIDTH-offX*2, SCREEN_HEIGHT-64-44-40-100-20)];
//    bgView.backgroundColor=LIGHTBLACK;
    bgView.layer.cornerRadius=5;
    bgView.layer.borderColor=LIGHTBLACK.CGColor;
    bgView.layer.borderWidth=1;
    bgView.clipsToBounds=YES;
    [self.view addSubview:bgView];
    UISwipeGestureRecognizer *leftswipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [leftswipe setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    UISwipeGestureRecognizer *rightswipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    [rightswipe setDirection:UISwipeGestureRecognizerDirectionRight];

//    swipe.delegate=self;
    [self.view addGestureRecognizer:leftswipe];
    [self.view addGestureRecognizer:rightswipe];
    imageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, bgView.frame.size.height-bottom_Height)];
    [bgView addSubview:imageView];
    NSString *url=@"http://img.pconline.com.cn/images/upload/upc/tx/itbbs/1106/26/c2/8138154_1309077121193_1024x1024it.jpg";
    //http://www.photo0086.com/member/751/pic/201204191650075075.JPG
    //http://image13-c.poco.cn/mypoco/myphoto/20121126/19/64947591201211261905061490497461183_000.jpg?1800x1500_120
//    [imageView  sd_setImageWithURL:[NSURL URLWithString:url]];
    imageView.clipsToBounds=YES;
    imageView.contentMode=UIViewContentModeScaleAspectFill;

    bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, bgView.frame.size.height-bottom_Height, bgView.frame.size.width, bottom_Height)];
    [bgView addSubview:bottomView];
    float label_offX=40;
    if (SCREEN_WIDTH<375) {
        label_offX=25;
    }
    float label_offY=5;
    float label_Width=(bgView.frame.size.width-(label_offX*5))/4;
    float label_Height=20;
    float textSize=14;
    UIFont *textFont=[UIFont boldSystemFontOfSize:textSize];
    UILabel *productL=[[UILabel alloc] initWithFrame:CGRectMake(label_offX, label_offY, label_Width, label_Height)];
    productL.text=@"品种";
    [productL setFont:textFont];
    UILabel *treeL=[[UILabel alloc] initWithFrame:CGRectMake(label_offX*2+label_Width, label_offY, label_Width, label_Height)];
    [treeL setFont:textFont];
    treeL.text=@"树高";
    UILabel *changeL_=[[UILabel alloc] initWithFrame:CGRectMake(label_offX*3+label_Width*2, label_offY, label_Width, label_Height)];
    [changeL_ setFont:textFont];
    changeL_.text=@"想换";
    UILabel *positionL_=[[UILabel alloc] initWithFrame:CGRectMake(label_offX*4+label_Width*3, label_offY, label_Width, label_Height)];
    positionL_.text=@"坐标";
    [positionL_ setFont:textFont];
    [bottomView addSubview:productL];
    [bottomView addSubview:treeL];
    [bottomView addSubview:changeL_];
    [bottomView addSubview:positionL_];
    bottomView.backgroundColor=LIGHTBLACK;
    
    //下排
    float label_Height2=25;
    float offX2=10;
    float textSize2=17;
    if (SCREEN_WIDTH<375) {//处理iPhone5
        textSize2=15;
    }
    UIFont *textFont2=[UIFont boldSystemFontOfSize:textSize2];
     UIFont *textFont3=[UIFont boldSystemFontOfSize:14];

    productNameL=[[UILabel alloc] initWithFrame:CGRectMake(productL.frame.origin.x-offX2, CGRectGetMaxY(productL.frame)+5, label_Width+offX2*2, label_Height2)];
    productNameL.font=textFont2;
    treeHeightL=[[UILabel alloc] initWithFrame:CGRectMake(treeL.frame.origin.x-offX2*2-10, CGRectGetMaxY(productL.frame)+5, label_Width+offX2*4+20, label_Height2)];
        treeHeightL.font=textFont3;
    changeL=[[UILabel alloc] initWithFrame:CGRectMake(changeL_.frame.origin.x-offX2, CGRectGetMaxY(productL.frame)+5, label_Width+offX2*2, label_Height2)];
      changeL.font=textFont2;
    positionL=[[UILabel alloc] initWithFrame:CGRectMake(positionL_.frame.origin.x-offX2, CGRectGetMaxY(productL.frame)+5, label_Width+offX2*2, label_Height2)];
     positionL.font=textFont2;
    [productNameL setTextColor:WHITEColor];
        [treeHeightL setTextColor:WHITEColor];
        [changeL setTextColor:WHITEColor];
        [positionL setTextColor:WHITEColor];
//    productNameL.text=@"榆树";
//    treeHeightL.text=@"40CM";
//    changeL.text=@"不限";
//    positionL.text=@"杭州";
    [bottomView addSubview:productNameL];
    [bottomView addSubview:treeHeightL];
    [bottomView addSubview:changeL];
    [bottomView addSubview:positionL];
    productNameL.textAlignment=NSTextAlignmentCenter;
    treeHeightL.textAlignment=NSTextAlignmentCenter;
    changeL.textAlignment=NSTextAlignmentCenter;
    positionL.textAlignment=NSTextAlignmentCenter;

    //163 × 163
    loveBtn=[[UIButton alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(bottomView.frame)+20, 163/2.f, 163/2.f)];
    [loveBtn setImage:[UIImage imageNamed:@"喜欢"] forState:UIControlStateNormal];
    
    noLoveBtn=[[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-163/2.f-40, loveBtn.frame.origin.y, 163/2.f, 163/2.f)];
    [noLoveBtn setImage:[UIImage imageNamed:@"不喜欢"] forState:UIControlStateNormal];
    [self.view addSubview:loveBtn];
    [self.view addSubview:noLoveBtn];
    [loveBtn addTarget:self action:@selector(loveAction) forControlEvents:UIControlEventTouchUpInside];
    [noLoveBtn addTarget:self action:@selector(noLoveAction) forControlEvents:UIControlEventTouchUpInside];

    
    
    
}

-(void)requestData{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",@"",SenShu,@"",LeiBie,@"",ChanDi,@"",PinZhong,@"",ShuXin,@"",ChiCun,@"",QiTa, nil];
    [HttpConnection GetBonsaiFate:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if (![response objectForKey:KErrorMsg]) {
                self.list=response[KDataList];
                if (_list.count==0) {
                    [SVProgressHUD showInfoWithStatus:@"暂无数据"];
                }
                dataIndex=0;
                [self refreshTreeView];
            }
            else{
                [SVProgressHUD showInfoWithStatus:[response objectForKey:KErrorMsg]];
            }
            
        }
        else{
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }
        
    }];
}

//刷新
-(void)refreshTreeView{
    if (dataIndex>=_list.count) {
        return;
    }
    
    self.info=_list[dataIndex];
//    productNameL.text=@"榆树";
//    treeHeightL.text=@"40CM";
//    changeL.text=@"不限";
//    positionL.text=@"杭州";
    productNameL.text=_info.Varieties;
    treeHeightL.text=_heightList[[_info.Height integerValue]-1];
    changeL.text=_info.ChangeVarieties;
    positionL.text=_info.Location;
    [imageView sd_setImageWithURL:[NSURL URLWithString:_info.Path]];
    dataIndex++;
}


//喜欢
-(void)loveAction{
    [self swipeAction:nil];
    [self likeOrNoWithType:1];
}
//不喜欢
-(void)noLoveAction{
    [self swipeAction:nil];
    [self likeOrNoWithType:0];
}

//是否喜欢
-(void)likeOrNoWithType:(NSInteger)type{

//    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID",_info.ID,@"BID", [NSNumber numberWithInteger:type],@"IsRight",_info.UID,@"PostUserId", nil];
    NSDictionary *dic2=[[NSDictionary alloc] initWithObjectsAndKeys:_info.ID,@"BID", [NSNumber numberWithInteger:type],@"IsRight",_info.UID,@"PostUserId", nil ];
  
//    NSArray *result=[[NSArray alloc] initWithObjects:dic2, nil];
    NSString *result=[NSString stringWithFormat:@"%@,%@,%@",_info.ID,[NSNumber numberWithInteger:type],_info.UID];
    NSDictionary *dic3=[[NSDictionary alloc] initWithObjectsAndKeys:result,@"result" ,[DataSource sharedDataSource].userInfo.ID,@"UID",nil];
    [HttpConnection PostBonsaiFate:dic3 WithBlock:^(id response, NSError *error) {
        if (error) {
            [SVProgressHUD showInfoWithStatus:ErrorMessage];
        }
        else{
            
        }
        
    }];
    
}

-(void)swipeAction:(UISwipeGestureRecognizer*)sender{
    if (dataIndex>=_list.count) {//再次请求
        [self requestData];
        return;
    }
    [self refreshTreeView];
//    CATransition *animation = [CATransition animation];
//    //动画播放持续时间
//    [animation setDuration:0.25f];
//    //动画速度,何时快、慢
//    [animation setTimingFunction:[CAMediaTimingFunction
//                                  functionWithName:kCAMediaTimingFunctionEaseIn]];
//    [animation setSubtype:kCATransitionFromLeft];
//    [animation setType:@"pageCurl"];
//    [bgView.layer addAnimation:animation forKey:@"pageCurl"];
    index++;
    if (index>2) {
        index=0;
    }
    if (sender.direction==UISwipeGestureRecognizerDirectionLeft||sender.direction==UISwipeGestureRecognizerDirectionUp) {
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.6];
        [animation setFillMode:kCAFillModeForwards];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [animation setType:@"pageCurl"];// rippleEffect
        [animation setSubtype:kCATransitionFromTop];
        [imageView.layer addAnimation:animation forKey:nil];
        NSLog(@"左边");
    }
    else if(sender.direction==UISwipeGestureRecognizerDirectionRight||sender.direction==UISwipeGestureRecognizerDirectionDown){
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.6];
        [animation setFillMode:kCAFillModeBackwards];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [animation setType:@"pageCurl"];// rippleEffect
        [animation setSubtype:kCATransitionFromBottom];
        [imageView.layer addAnimation:animation forKey:nil];
        NSLog(@"右边");
    }

//    NSString *url=_imageUrls[index];
//    NSString *url=@"http://www.photo0086.com/member/751/pic/201204191650075075.JPG";
    //http://www.photo0086.com/member/751/pic/201204191650075075.JPG
    //http://image13-c.poco.cn/mypoco/myphoto/20121126/19/64947591201211261905061490497461183_000.jpg?1800x1500_120
//        [imageView  sd_setImageWithURL:[NSURL URLWithString:url]];
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
