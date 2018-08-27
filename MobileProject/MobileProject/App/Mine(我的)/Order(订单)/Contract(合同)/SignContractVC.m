//
//  SignContractVC.m
//  MobileProject
//
//  Created by zsgy on 2018/6/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "SignContractVC.h"
#import "PayVc.h"
@interface SignContractVC ()
@property (nonatomic , strong)UIButton *registered;
@property (nonatomic , strong)UIWebView *webView;
@end

@implementation SignContractVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"电力云信息服务合同"];
    self.navigationView.titleLabel.textColor = [UIColor blackColor];
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadSubview{
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, kNavBarH, kScreenW, kScreenH-kNavBarH-KFit_H6S(200))];
    [self.view addSubview:self.webView];
    //    self.webView.delegate  =  self;
    //    _webView.scrollView.delegate = self;
    //    _webView.scrollView.scrollEnabled = NO;
    _webView.opaque  =  NO;
    _webView.backgroundColor  =  kWhiteColor;
    self.webView.allowsInlineMediaPlayback = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:HTMLContract,self.model.idid,[User UserOb].token]]];
    //        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
    [self.webView loadRequest:request];
    
    UIView *v =[[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(200));
    }];
    
    
    
    
    self.registered = [[UIButton alloc] init];
    [self.view addSubview:self.registered];
    self.registered.layer.cornerRadius = 5;
    [self.registered setTitle:@"同意,支付首付款" forState:UIControlStateNormal];
    [self.registered setBackgroundColor:appcoloer];
    [self.registered addTarget:self action:@selector(modifyOrderStatus) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *cancel = [[UIButton alloc] init];
    [self.view addSubview:cancel];
    cancel.layer.cornerRadius = 5;
    [cancel setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(CancelTheOrder) forControlEvents:UIControlEventTouchUpInside];
    cancel.layer.borderColor = kColor_N(201, 201, 201).CGColor;
    cancel.layer.borderWidth = 0.3;
    NSArray *arr = @[cancel,self.registered];
    
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(40) leadSpacing:KFit_W6S(40) tailSpacing:KFit_W6S(40)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(80));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    
}
- (void)modifyOrderStatus{
//    XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:@"你确认签订合同？" sureBtn:@"确认" cancleBtn:@"取消"];
//    [alert showXLAlertView];
//    alert.resultIndex = ^(NSInteger index) {
//        if (index == 2) {
            NSString *url=[NSString stringWithFormat:GETOrdersState,self.model.idid,[User UserOb].token];
            [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
                if (kResponseObjectStatusCodeIsEqual(200)) {
                    XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"签订成功" SuccessOrFailure:YES];
                    [alert showPrompt];
                    [self loadordersInfo];
                }
                
            } failureBlock:^(NSError *error) {
                KKLog(@"%@", error);
                
            } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                
            }];
//        }
//    };
}

#pragma mark - 加载详情信息
- (void)loadordersInfo{
    NSString *url=[NSString stringWithFormat:GETOrdersInfo,self.model.idid,[User UserOb].token];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        FMMainModel *model = [FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.model = model;
        PayVc *vc = [[PayVc alloc] init];
        vc.model = self.model;
        if (_model.items.count == 1) {
            vc.ordersItemType = OrdersItemsTypeDeposit;
            
        }else if (_model.state ==5 ){
            vc.ordersItemType = OrdersItemsTypeInitialPayment;
        }else{
            vc.ordersItemType = OrdersItemsTypeFinalPaymen;
        }
        [self.navigationController pushViewController:vc animated:YES];
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}





- (void)CancelTheOrder{
    XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"你确认取消订单？" message:@"根据协议，如您取消该订单违约，首付款优能币退回你的账户，但平台将收取100优能币作为服务费！" sureBtn:@"确认取消" cancleBtn:@"不取消"];
    [alert showXLAlertView];
    alert.resultIndex = ^(NSInteger index) {
        if (index == 2) {
            NSString *url=[NSString stringWithFormat:GETOrdersCancel,self.model.idid,[User UserOb].token];
            [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
                if (kResponseObjectStatusCodeIsEqual(200)) {
                    XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"取消成功" SuccessOrFailure:YES];
                    [alert showPrompt];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
            } failureBlock:^(NSError *error) {
                KKLog(@"%@", error);
                
            } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                
            }];
        }
    };
    
    
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
