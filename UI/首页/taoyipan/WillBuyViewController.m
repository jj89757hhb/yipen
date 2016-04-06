//
//  WillBuyViewController.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/18.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "WillBuyViewController.h"
#import "WillBuyTableViewCell.h"
#import "AddressInfo.h"
@interface WillBuyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)AddressInfo *addressinfo;
@end

@implementation WillBuyViewController
static NSString *identify=@"identify";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"确认购买";
    [self initTable];
    [self queryAddress];
}


-(void)queryAddress{
    NSDictionary *dic=[[NSDictionary alloc] initWithObjectsAndKeys:[DataSource sharedDataSource].userInfo.ID,@"UID", nil];
    [HttpConnection GetAddressList:dic WithBlock:^(id response, NSError *error) {
        if (!error) {
            if ([[response objectForKey:@"ok"] boolValue]) {
//                [self.list removeAllObjects];
                NSArray *records=response[@"records"];
                for (NSDictionary *dic in records) {
                    self.addressinfo=[[AddressInfo alloc] initWithKVCDictionary:dic];
//                    [self.list addObject:info];
                    break;
                }
                
                [myTable reloadData];
            }
            else{
                [SVProgressHUD showErrorWithStatus:[response objectForKey:@"reason"]];
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:ErrorMessage];
        }
        
        
    }];
}
-(void)initTable{
    myTable=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    myTable.delegate=self;
    myTable.dataSource=self;
    [self.view addSubview:myTable];
    [myTable registerNib:[UINib nibWithNibName:@"WillBuyTableViewCell" bundle:nil] forCellReuseIdentifier:identify];
    myTable.separatorStyle=UITableViewCellSeparatorStyleNone;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WillBuyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identify];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    [cell.treeIV sd_setImageWithURL:[NSURL URLWithString:_info.Attach[0]] placeholderImage:Default_Image];
    [cell.titleL setText:_info.Title];
    cell.oldPriceL.text=_info.Price;
    cell.nameL.text=_addressinfo.Contacter;
    cell.addressL.text=_addressinfo.Address;
    cell.phoneL.text=_addressinfo.Mobile;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(payTypeAction)];
    [cell.bg3 addGestureRecognizer:tap];
    [cell.bg3 setUserInteractionEnabled:YES];
    
    return cell;
}

-(void)payTypeAction{
//    [UIActionSheet bk_showAlertViewWithTitle:nil message:@"支付方式" cancelButtonTitle:@"取消" otherButtonTitles:@[@"余额支付",@"支付宝支付",@"微信支付"] handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//        
//    }];
//    [UIActionSheet bk_actionSheetWithTitle:@"支付方式"];
    UIActionSheet *action=[UIActionSheet bk_actionSheetWithTitle:@"支付方式"];
    [action bk_addButtonWithTitle:@"余额支付" handler:^{
        
    }];
    [action bk_addButtonWithTitle:@"支付宝支付" handler:^{
        
    }];
    [action bk_addButtonWithTitle:@"微信支付" handler:^{
        
    }];
//    [action bk_addButtonWithTitle:@"取消" handler:^{
//        
//    }];
    [action bk_setCancelButtonWithTitle:@"取消" handler:^{
        
    }];
    [action showInView:self.view];
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
