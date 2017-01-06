//
//  AppPurchase.m
//  panjing
//
//  Created by 华斌 胡 on 16/3/30.
//  Copyright © 2016年 华斌 胡. All rights reserved.
//

#import "AppPurchase.h"
#define APPSTORE_ASK_TO_BUY_IN_SANDBOX 1

// 生成订单参数，注意沙盒测试账号与线上正式苹果账号的验证途径不一样，要给后台标明
//NSNumber *sandbox;
//#if (defined(APPSTORE_ASK_TO_BUY_IN_SANDBOX) && defined(DEBUG))
//sandbox = @(0);
//#else
//sandbox = @(1);
//#endif
@implementation AppPurchase

-(id)init{
    self=[super init];
    if (self) {
      
//        [self requestProducts];
    }
    return self;
}

static AppPurchase *_sharedAppPurchase = nil;
+(AppPurchase*) sharedAppPurchase {
    
    @synchronized([AppPurchase class])
    {
        if (!_sharedAppPurchase){
            _sharedAppPurchase = [[self alloc] init];
           [[SKPaymentQueue defaultQueue] addTransactionObserver:_sharedAppPurchase];
        }
        [_sharedAppPurchase requestProducts];
        return _sharedAppPurchase;
    }
    // to avoid compiler warning
    return nil;
}


-(void)requestProducts
{
  
//    NSSet* productSet = [NSSet setWithArray:@[@"yipen002",@"yipen003"]];
    NSSet* productSet = [NSSet setWithArray:@[@"yipen004",@"yipen005"]];
    SKProductsRequest* skReq = [[SKProductsRequest alloc] initWithProductIdentifiers:productSet];
    skReq.delegate = self;
    [skReq start];
    [SVProgressHUD show];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
//    [ESHUDView dismiss];
    NSLog(@"response:%@",response);
    
    if (response.products.count != 0) {
        _products = response.products;
        if (_memberType==KVerify_Business) {
              self.product=_products[1];
        }
        else{
              self.product=_products[0];
        }
      
        NSLog(@"11:%@",_product.localizedTitle);
           NSLog(@"22:%@",_product.localizedDescription);
        
    }else{
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"不能连接到AppStore" message:nil delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
    [SVProgressHUD dismiss];
}


-(void)savePayReceipt:(NSString*)receiptData
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:receiptData forKey:@"lasterRecepit"];
    [userDefaults synchronize];
}

-(void)removePayRecepit
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"lasterRecepit"];
    [userDefaults synchronize];
}

//-(void)saveCoinToLoacl:(NSInteger) totalPrice
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSInteger localCoin = [userDefaults integerForKey:@"localCoin"];
//    [userDefaults setInteger: localCoin + totalPrice forKey:@"localCoin"];
//    [userDefaults synchronize];
//}

-(void)validatePayReceipt:(NSString*)receiptData
{
    
//    [ESHUDView showWithStatus:nil];
    //调用服务端验证接口
    if (receiptData) {//成功
        
        [self verifyTransactionResult];
    }
    else{//失败
        [self validateReceiptFailHandler:receiptData];
    }

}



- (void)verifyTransactionResult
{
    // 验证凭据，获取到苹果返回的交易凭据
    // appStoreReceiptURL iOS7.0增加的，购买交易完成后，会将凭据存放在该地址
    NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
    // 从沙盒中获取到购买凭据
    NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
    // 传输的是BASE64编码的字符串
    /**
     BASE64 常用的编码方案，通常用于数据传输，以及加密算法的基础算法，传输过程中能够保证数据传输的稳定性
     BASE64是可以编码和解码的
     */
    NSDictionary *requestContents = @{
                                      @"receipt-data": [receipt base64EncodedStringWithOptions:0]
                                      };
    NSError *error;
    // 转换为 JSON 格式
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestContents
                                                          options:0
                                                            error:&error];
    // 不存在
    if (!requestData) { /* ... Handle error ... */ }
    
    // 发送网络POST请求，对购买凭据进行验证
    NSString *verifyUrlString;
//#if (defined(APPSTORE_ASK_TO_BUY_IN_SANDBOX) && defined(DEBUG))
//    verifyUrlString = @"https://sandbox.itunes.apple.com/verifyReceipt";
//#else
    verifyUrlString = @"https://buy.itunes.apple.com/verifyReceipt";
//#endif
    // 国内访问苹果服务器比较慢，timeoutInterval 需要长一点
    NSMutableURLRequest *storeRequest = [NSMutableURLRequest requestWithURL:[[NSURL alloc] initWithString:verifyUrlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0f];
    
    [storeRequest setHTTPMethod:@"POST"];
    [storeRequest setHTTPBody:requestData];
    
    // 在后台对列中提交验证请求，并获得官方的验证JSON结果
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:storeRequest queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   NSLog(@"链接失败");
                                   [SVProgressHUD showInfoWithStatus:ErrorMessage];;
                              
                               } else {
                                   NSError *error;
                                   NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
                                   NSLog(@"苹果支付返回:%@",jsonResponse);
                                   if (!jsonResponse) {
                                       NSLog(@"验证失败");
                                          [SVProgressHUD showInfoWithStatus:@"验证失败，请重试"];
                                   }
                                   else{
                                       [self removePayRecepit];
                                       NSLog(@"验证成功");
//                                       [SVProgressHUD showInfoWithStatus:@"购买成功"];
                                       //发送通知 提交服务器
                                       [NotificationCenter postNotificationName:@"paySecond" object:nil];
                                   }
                                   
                                   // 比对 jsonResponse 中以下信息基本上可以保证数据安全
                                   /*
                                    bundle_id
                                    application_version
                                    product_id
                                    transaction_id
                                    */
                                   
                               }
                           }];
    
}

-(void)validateReceiptFailHandler:(NSString*)receiptData
{
    [UIAlertView bk_showAlertViewWithTitle:@"支付验证提醒" message:NSLocalizedString(@"当前网络不好,支付验证超时！点击重试继续验证,或点击取消下次验证。", nil) cancelButtonTitle:NSLocalizedString(@"取消", nil) otherButtonTitles:@[NSLocalizedString(@"重试", nil)] handler:^(UIAlertView *alertView, NSInteger buttonIndex){
        if (buttonIndex == 1) {
            [self validatePayReceipt:receiptData];
        }
    }];
}

-(void)completeTransaction:(SKPaymentTransaction *) transaction
{
    NSString *productIdentifier = transaction.payment.productIdentifier;
    
    if ([productIdentifier length] > 0) {
        NSURL *receiptURL = [[NSBundle mainBundle] appStoreReceiptURL];
        NSData *receipt = [NSData dataWithContentsOfURL:receiptURL];
        NSString *receiptData = [receipt base64EncodedStringWithOptions:0];
        [self savePayReceipt:receiptData];
        [self validatePayReceipt:receiptData];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

-(void)failedTransaction:(SKPaymentTransaction *)transaction
{
    if (transaction.error.code != SKErrorPaymentCancelled) {
        NSLog(@"购买失败");
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
//    [ESHUDView dismiss];
}

- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions) {
        NSLog(@"Transaction status->%ld", transaction.transactionState);
        switch (transaction.transactionState) {
                //交易完成
            case SKPaymentTransactionStatePurchased:
                NSLog(@"交易完成");
                [self completeTransaction:transaction];
                break;
                //交易失败
            case SKPaymentTransactionStateFailed:
                NSLog(@"交易失败");
                [self failedTransaction:transaction];
//                [SVProgressHUD showWithStatus:@"交易失败"];
                [UIAlertView bk_showAlertViewWithTitle:nil message:@"交易失败" cancelButtonTitle:@"确定" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                    
                }];
                break;
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"商品加进购买列表");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"商品已经购买过");
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
    [SVProgressHUD dismiss];
//    [self removeTransaction];
}


-(void)willPurchase{
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:self.product];
    payment.quantity = 1;
    [[SKPaymentQueue defaultQueue] addPayment:payment];
    [SVProgressHUD show];
}


- (void)dealloc
{
    NSLog(@"removeTransactionObserver");
//    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

-(void)removeTransaction{
     [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

@end
