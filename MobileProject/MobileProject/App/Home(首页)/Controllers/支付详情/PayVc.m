//
//  PayVc.m
//  MobileProject
//
//  Created by zsgy on 2018/6/8.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PayVc.h"
#import "OrderView.h"
#import "XLPay.h"
#import "FMPayCell.h"
#import "OfflinePayVC.h"
#import "UILabel+XLlable.h"
#import "RechargeVC.h"
#import "OrderDetailsVC.h"
#import "OrderExpandVC.h"
@interface PayVc ()

@property (nonatomic , strong)OrderView *orderDetails;


@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray *data;
/// 确认支付
@property (nonatomic, strong) UIButton *yfSurePay;
@property (nonatomic, strong) UIButton *yfSeletcpay;
@property (nonatomic, strong) UIButton *yfSeletcPayImg;

@property (nonatomic, strong)UIButton *pay;
@property (nonatomic, strong)UIButton *top_up;

@property (nonatomic, assign)NSInteger index;
@property (nonatomic , strong)NSMutableAttributedString *noteStr;
@property (nonatomic , strong)UILabel *money;
@property (nonatomic , strong)AccountModel *accountModel;
@property (nonatomic , strong)UILabel *titlelabel;

@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)UILabel *prompt;
@property (nonatomic , strong)FMSubmodel *item;
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , strong)UILabel *PaymentReminders;
@property (nonatomic , strong)UILabel *discountAmount; //优惠金额
@property (nonatomic , strong)UILabel *realPay; //实付金额
@property (nonatomic , strong)UILabel *amountAvailable; //可用金额
@property (nonatomic , strong)NSString *point;//优惠金额
@end

@implementation PayVc

- (NSMutableAttributedString *)noteStr{
    if (_noteStr == nil) {
        // 创建Attributed
        _noteStr = [[NSMutableAttributedString alloc] initWithString:_money.text];
        // 需要改变的第一个文字的位置
        NSUInteger firstLoc = [[_noteStr string] rangeOfString:@":"].location + 1;
        // 需要改变的最后一个文字的位置
        NSUInteger secondLoc = [[_noteStr string] rangeOfString:@"币"].location + 1;
        // 需要改变的区间
        NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
        // 改变颜色
        [_noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
        // 改变字体大小及类型
        [_noteStr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:kFit_Font6(22)] range:range];
    }
    return _noteStr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    for (FMSubmodel *model in _model.items) {
        if (model.type == self.ordersItemType) {
            self.item = model;
        }
    }
    [self laodNavigation];
    [self loadPoint];
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)laodNavigation{
    
    
    if (self.ordersItemType == OrdersItemsTypeInitialPayment) {
        [self.navigationView setTitle:@"支付服务费首付款"];
    }else if (self.ordersItemType == OrdersItemsTypeFinalPaymen){
        [self.navigationView setTitle:@"支付服务费尾款"];
    }else{
        [self.navigationView setTitle:@"确认订单"];
    }
    [self.navigationView.titleLabel setTextColor:[UIColor blackColor]];
    //是否开启 手势侧滑返回
    self.customBackGestureEnabel = YES ;
    //侧滑距离左边最大的距离,
    self.customBackGestureEdge = SCREEN_WIDTH / 2.0 ;
}

- (void)loadSubview{
    self.orderDetails = [[OrderView alloc] initWithstyle:NO];
    self.orderDetails.model = self.model;
    self.orderDetails.layer.cornerRadius = 5;
    self.orderDetails.layer.masksToBounds = YES;
    [self.view addSubview:self.orderDetails];
    [self.orderDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(10));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(20));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(360));
    }];
    
    self.backview = [[XLView alloc] init];
    
    [self.view addSubview:self.backview ];
    [self.backview  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.orderDetails.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.orderDetails);
        make.height.mas_equalTo(KFit_H6S(350));
    }];
    self.backview .layer.borderColor = appcoloer_line.CGColor;
    self.backview .layer.borderWidth = 0.7;
    self.backview .layer.cornerRadius = 10;
    self.backview .layer.masksToBounds = YES;
    
    
    
    UILabel *titlenName = [[UILabel alloc] init];
    self.titlelabel = titlenName;
    titlenName.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    titlenName.backgroundColor = kColor_N(232, 232, 232);
    [self.backview  addSubview:titlenName];
    [titlenName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.backview );
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.PaymentReminders = [[UILabel alloc] init];
    self.PaymentReminders.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.backview  addSubview:self.PaymentReminders];
//    self.PaymentReminders.textAlignment = NSTextAlignmentRight;
    self.PaymentReminders.text = @"您的账户中可用金额:";
    [self.PaymentReminders mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backview ).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(self.backview ).mas_offset(-KFit_W6S(245));
        make.top.mas_equalTo(titlenName.mas_bottom).mas_offset(KFit_H6S(10));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    _money = [[UILabel alloc] init];
    _money.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    _money.textColor = [UIColor redColor];
    _money.textAlignment = NSTextAlignmentRight;
    [self.backview  addSubview:_money];
    [_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.PaymentReminders.mas_right).mas_offset(KFit_W6S(10));
        make.right.mas_equalTo(self.backview ).mas_offset(-KFit_W6S(10));
        make.top.mas_equalTo(titlenName.mas_bottom).mas_offset(KFit_H6S(10));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    
    
    self.top_up = [[UIButton alloc] init];
    [self.view addSubview:self.top_up];
    [self.top_up setTitle:@"去我的账户" forState:UIControlStateNormal];
    [self.top_up setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.top_up.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(18)];
    self.top_up.layer.cornerRadius=5;
    self.top_up.layer.borderColor = appcoloer_line.CGColor;
    self.top_up.layer.borderWidth = 0.5;
    [self.top_up addTarget:self action:@selector(topUp) forControlEvents:UIControlEventTouchUpInside];
    [self.top_up mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.width.mas_equalTo(KFit_W6S(400));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(50));
        make.height.mas_equalTo(KFit_H6S(80));
    }];

    
    self.pay = [[UIButton alloc] init];
    [self.view addSubview:self.pay];
    [self.pay setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.pay.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(18)];
    self.pay.layer.cornerRadius=5;
    self.pay.backgroundColor = kColor_N(40, 174, 104);
    [self.pay addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [self.pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.top_up.mas_right).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(50));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(50));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    
    
}
#pragma mark - 去支付
- (void)toPay{
    NSString *ts;
    NSString *title;
    if (self.ordersItemType == OrdersItemsTypeDeposit){
        title = @"确认订单?";
        ts = [NSString stringWithFormat:@"确认订单后，其中的%ld优能币将被冻结，直至订单完成或者取消；冻结的部分可用于本订单的服务费支付",self.item.amount];
        
    }else if (self.ordersItemType == OrdersItemsTypeInitialPayment){
        title = @"确认支付?";
        ts = @"确认支付后，首付款将从你的账户中扣减，优先从本订单冻结金额中扣减。";
    }else{
        title = @"确认支付?";
        ts = @"确认支付后，款项将从你的账户中扣减，优先从本订单冻结金额中扣减";
    }
    XLAlertView *alert = [[XLAlertView alloc] initWithTitle:title message:ts sureBtn:@"确定" cancleBtn:@"取消"];
    alert.resultIndex = ^(NSInteger index) {
        KKLog(@"%ld",(long)index);
        if (index == 2) {
            [self DeterminePayment];
        }
    };
    [alert showXLAlertView];
}


- (void)DeterminePayment{
//    if (![self judgeRemainingSum]) {
//        XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"余额不足" SuccessOrFailure:NO];
//        [alert showPrompt];
//        return;
//    }
    [MBProgressHUD showLoadingHUD:@"请稍等.."];
    NSString *url=[NSString stringWithFormat:GETOrdersVerify,self.item.idid,[User UserOb].token];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            if (self.ordersItemType == OrdersItemsTypeDeposit){
                XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"确定订单成功" SuccessOrFailure:YES];
                    [alert showPrompt];
            }else{
                XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"支付成功" SuccessOrFailure:YES];
                    [alert showPrompt];
            }
            
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[OrderDetailsVC class]]) {
                    [self.navigationController popToViewController:controller animated:YES];
                    return ;
                }
                
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    
    }];
}
#pragma mark - 去充值
- (void)topUp{
    RechargeVC *vc = [[RechargeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 获取我的账户金额
- (void)myAccount{
    NSString *url = [NSString stringWithFormat:GETMembersAccountInfo,[User UserOb].token];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic = responseObject[@"data"];
            AccountModel *model = [AccountModel mj_objectWithKeyValues:dic];
            self.accountModel = model;
            [self refreshData];
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}


#pragma mark - 获取我的优惠券
- (void)loadPoint{
    NSString *url = [NSString stringWithFormat:GETmMembersPoint,[User UserOb].token];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic = responseObject[@"data"];
            self.point = dic[@"money_sum"];
            [self refreshData];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

#pragma mark - 刷新页面数据
- (void)refreshData{
    [self.prompt removeFromSuperview];
    [self.amountAvailable removeFromSuperview];
    [_img removeFromSuperview];
    _prompt = [[UILabel alloc] init];
    [self.backview  addSubview:_prompt];
    _prompt.textColor = [UIColor redColor];
    _prompt.numberOfLines = 0;
//    _prompt.textAlignment = NSTextAlignmentRight;
    _prompt.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    if (self.ordersItemType == OrdersItemsTypeDeposit) {
        self.titlelabel.text = @" 可用余额";
        [self.pay setTitle:@"确认订单" forState:UIControlStateNormal];
        self.PaymentReminders.text = @"您的账户中可用金额:";
        _money.text = [NSString stringWithFormat:@"%ld",self.accountModel.money_free];
        //判断余额充足
        if ([self judgeRemainingSum]) {
            self.top_up.backgroundColor = [UIColor whiteColor];
            self.pay.backgroundColor = kColor_N(40, 174, 104);
            [self.top_up setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.pay setEnabled:YES];
            _prompt.text = [NSString stringWithFormat:@"确认订单后，其中的%ld优能币将被冻结，直至订单完成或者取消；冻结的部分可用于本订单的服务费支付。",self.item.amount];
            [_prompt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.backview ).mas_offset(KFit_W6S(10));
                make.right.mas_equalTo(self.backview ).mas_offset(-KFit_W6S(10));
                make.top.mas_equalTo(_money.mas_bottom).mas_offset(KFit_H6S(20));
//                make.height.mas_equalTo(KFit_H6S(74));
            }];
            self.top_up.hidden = YES;
            [self.pay mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
                make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(50));
                make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(50));
                make.height.mas_equalTo(KFit_H6S(80));
            }];
            [self.backview  mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.orderDetails.mas_bottom).mas_offset(KFit_H6S(20));
                make.left.right.mas_equalTo(self.orderDetails);
                make.height.mas_equalTo(KFit_H6S(300));
            }];
        }else{
            self.pay.backgroundColor = kColor_N(232, 232, 232);
            self.top_up.backgroundColor = kColor_N(40, 174, 104);
            [self.top_up setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.pay setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.pay setEnabled:NO];
            _img = [[UIImageView alloc] init];
            [_img setImage:[UIImage imageNamed:@"error"]];
            [self.backview  addSubview:_img];
            [_img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_money.mas_bottom).mas_offset(KFit_H6S(40));
                make.left.mas_equalTo(self.backview ).mas_offset(KFit_W6S(10));
                make.size.mas_equalTo(CGSizeMake(KFit_W6S(40), KFit_W6S(40)));
            }];
            _prompt.text = [NSString stringWithFormat:@"账户中的可用金额低于本订单要求的%ld优能币，请先去我的账户补充！",self.item.amount];
            [_prompt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(_money);
                make.centerY.mas_equalTo(_img);
                make.left.mas_equalTo(_img.mas_right).mas_offset(KFit_W6S(10));
                make.height.mas_equalTo(KFit_H6S(74));
            }];
            [self.backview  mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.orderDetails.mas_bottom).mas_offset(KFit_H6S(20));
                make.left.right.mas_equalTo(self.orderDetails);
                make.height.mas_equalTo(KFit_H6S(250));
            }];
            
        }
        [self loadtishiview];
    }else{
        
        
        
        UILabel *dongjie = [[UILabel alloc] init];
        [self.backview addSubview:dongjie];
        dongjie.textColor = [UIColor redColor];
        dongjie.text = [NSString stringWithFormat:@"%ld",self.model.order_freeze_money];
        dongjie.font = [UIFont systemFontOfSize:kFit_Font6(15)];
        dongjie.textAlignment = NSTextAlignmentRight;
        [dongjie mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(self.money);
            make.top.mas_equalTo(_prompt);
        }];
        
        self.amountAvailable = [[UILabel alloc] init];
        [self.backview addSubview:self.amountAvailable];
        self.amountAvailable.textColor = [UIColor redColor];
        self.amountAvailable.text = [NSString stringWithFormat:@"%ld",self.accountModel.money_free];
        self.amountAvailable.font = [UIFont systemFontOfSize:kFit_Font6(15)];
        self.amountAvailable.textAlignment = NSTextAlignmentRight;
        [self.amountAvailable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.mas_equalTo(self.money);
            make.top.mas_equalTo(dongjie.mas_bottom).mas_offset(KFit_H6S(15));
        }];
        
        if (self.ordersItemType == OrdersItemsTypeInitialPayment){
            self.titlelabel.text = @" 支付首付款";
            self.PaymentReminders.text = @"《信息服务合同》首付款(优能币):";
            _money.text = [NSString  stringWithFormat:@"%ld",self.item.amount];
            UILabel *yhq = [[UILabel alloc] init];
            [self.backview addSubview:yhq];
            yhq.text = @"扣减优惠券(元):";
            yhq.textAlignment = NSTextAlignmentRight;
            yhq.font = [UIFont systemFontOfSize:kFit_Font6(15)];
            [yhq mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.mas_equalTo(self.PaymentReminders);
                make.top.mas_equalTo(self.PaymentReminders.mas_bottom).mas_offset(KFit_H6S(20));
                
            }];
            
            self.discountAmount = [[UILabel alloc] init];
            [self.backview addSubview:self.discountAmount];
            self.discountAmount.textColor = [UIColor redColor];
            
            
            self.discountAmount.textAlignment = NSTextAlignmentRight;
            self.discountAmount.font = [UIFont systemFontOfSize:kFit_Font6(15)];
            [self.discountAmount mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.mas_equalTo(self.money);
                make.top.mas_equalTo(self.PaymentReminders.mas_bottom).mas_offset(KFit_H6S(20));
                
            }];
            
            UILabel *lb = [[UILabel alloc] init];
            [self.backview addSubview:lb];
            lb.backgroundColor = appcoloer_line;
            [lb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(10));
                make.left.mas_equalTo(yhq.mas_right).mas_offset(-KFit_W6S(250));
                make.top.mas_equalTo(yhq.mas_bottom).mas_offset(KFit_H6S(10));
                make.height.mas_equalTo(1);
                
            }];
            
            
            
            UILabel *sjzf = [[UILabel alloc] init];
            [self.backview addSubview:sjzf];
            sjzf.text = @"实际需要支付(优能币):";
            sjzf.font = [UIFont systemFontOfSize:kFit_Font6(15)];
            sjzf.textAlignment = NSTextAlignmentRight;
            [sjzf mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.mas_equalTo(self.PaymentReminders);
                make.top.mas_equalTo(yhq.mas_bottom).mas_offset(KFit_H6S(30));
                
            }];
            
            self.realPay = [[UILabel alloc] init];
            [self.backview addSubview:self.realPay];
            self.realPay.textColor = [UIColor redColor];
            
            self.realPay.font = [UIFont systemFontOfSize:kFit_Font6(16)];
            self.realPay.textAlignment = NSTextAlignmentRight;
            [self.realPay mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.height.mas_equalTo(self.money);
                make.top.mas_equalTo(yhq.mas_bottom).mas_offset(KFit_H6S(30));
                
            }];
            if (self.item.amount < [self.point integerValue]) {
                self.realPay.text = [NSString stringWithFormat:@"0"];
                self.discountAmount.text = [NSString stringWithFormat:@"%ld",self.item.amount];
            }else{
                self.realPay.text = [NSString stringWithFormat:@"%ld",(self.item.amount - [self.point integerValue])];
                self.discountAmount.text = [NSString stringWithFormat:@"%@",self.point];
            }
            _prompt.text = [NSString stringWithFormat:@"本订单可用冻结金额(优能币)：\n我的账户中可用金额(优能币)：\n提示：款项将从你的账户中扣减，优先从本订单冻结金额中扣减"];
            [UILabel changeLineSpaceForLabel:_prompt WithSpace:KFit_H6S(15)];
            [_prompt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.backview ).mas_offset(KFit_W6S(10));
                make.right.mas_equalTo(self.backview ).mas_offset(-KFit_W6S(10));
                make.top.mas_equalTo(sjzf.mas_bottom).mas_offset(KFit_H6S(30));
                //            make.height.mas_equalTo(KFit_H6S(200));
            }];

            [self.backview  mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.orderDetails.mas_bottom).mas_offset(KFit_H6S(20));
                make.left.right.mas_equalTo(self.orderDetails);
                make.height.mas_equalTo(KFit_H6S(500));
            }];
        }else if(self.ordersItemType == OrdersItemsTypeFinalPaymen){
            self.titlelabel.text = @" 支付余款";
            self.PaymentReminders.text = @"《信息服务合同》服务费余款(优能币):";
            _money.text = [NSString stringWithFormat:@"%ld",self.item.amount];
            
            _prompt.text = [NSString stringWithFormat:@"本订单可用冻结金额(优能币)：\n我的账户中可用金额(优能币)：\n提示：款项将从你的账户中扣减，优先从本订单冻结金额中扣减"];
            [UILabel changeLineSpaceForLabel:_prompt WithSpace:KFit_H6S(15)];
            [_prompt mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.backview ).mas_offset(KFit_W6S(10));
                make.right.mas_equalTo(self.backview ).mas_offset(-KFit_W6S(10));
                make.top.mas_equalTo(self.PaymentReminders.mas_bottom).mas_offset(KFit_H6S(30));
                //            make.height.mas_equalTo(KFit_H6S(200));
            }];
            
            [self.PaymentReminders mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.backview ).mas_offset(KFit_W6S(10));
                make.right.mas_equalTo(self.backview ).mas_offset(-KFit_W6S(150));
                make.top.mas_equalTo(self.titlelabel.mas_bottom).mas_offset(KFit_H6S(10));
                make.height.mas_equalTo(KFit_H6S(40));
            }];
            
            [self.backview  mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.orderDetails.mas_bottom).mas_offset(KFit_H6S(20));
                make.left.right.mas_equalTo(self.orderDetails);
                make.height.mas_equalTo(KFit_H6S(370));
            }];
        }
        
    }
    
}



- (void)loadtishiview{
    
    UILabel *lbone = [[UILabel alloc] init];
    [self.view addSubview:lbone];
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    lbone.numberOfLines = 0 ;
    lbone.textColor = [UIColor redColor];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(self.backview.mas_bottom).mas_offset(KFit_H6S(20));
    }];
    lbone.text = @"关于订单冻结及支付金额的时间节点说明：";
    
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    lb.numberOfLines = 0 ;
    lb.textColor = [UIColor redColor];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(lbone.mas_bottom).mas_offset(KFit_H6S(15));
    }];
    lb.text = @" • 在您确认订单后，冻结一定额度的优能币\n • 在订单匹配成功签订完信息服务合同后，支付服务费首付款\n • 在线下三方购售电合同签订后，支付服务费余款\n • 如您在订单匹配成功后取消订单，平台会扣一定的优能币作为信息服务费";
}

#pragma mark - 判断余额是否充足
- (BOOL)judgeRemainingSum{
    if (_accountModel.money_free >= self.item.amount) {
        KKLog(@"%d  --  %d",_accountModel.money_free,self.item.amount);
        return YES;
    }else{
        return NO;
    }
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self myAccount];
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
