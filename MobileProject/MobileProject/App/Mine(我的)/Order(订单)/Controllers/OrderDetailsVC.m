//
//  OrderDetailsVC.m
//  MobileProject
//
//  Created by zsgy on 2018/6/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "OrderDetailsVC.h"
#import "OrderProgressV.h"
#import "OrderDetailsV.h"
#import "OrdersItems.h"
#import "PayVc.h"
#import "SignContractVC.h"
#import "HWebVc.h"
#define But_W (kScreenWidth - KFit_W6S(60) )/(2.0)
#define Scorll_H (SCREEN_HEIGHT - kNavBarH - KFit_H6S(360))
@interface OrderDetailsVC ()<UIScrollViewDelegate>

@property (nonatomic , strong)UIButton *butOne;
@property (nonatomic , strong)UIButton *butTwo;
@property (nonatomic , strong)UIButton *selectbut;
@property (nonatomic , strong)UILabel *selectlab;
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)UIView *backView;
@property (nonatomic , strong)UIButton *pay;
@property (nonatomic , strong)UIButton *cancel;
@property (nonatomic , strong)OrderProgressV *orderProgress;
@property (nonatomic , strong)OrderDetailsV *orderDetails;


@end

@implementation OrderDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigation];
    [self loadSubview];
//    [self loadordersInfo];
    // Do any additional setup after loading the view.
}
- (void)loadNavigation{
    [self.navigationView setTitle:self.title];
    self.navigationView.titleLabel.textColor = [UIColor blackColor];
}

- (void)loadSubview{
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    [img setImage:[UIImage imageNamed:@"slogan"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(27));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(88));
    }];
    
    UIView *v = [[UIView alloc] init];
    [self.view addSubview:v];
    self.backView = v;
    v.layer.borderColor = appcoloer_line.CGColor;
    v.layer.borderWidth = 0.7;
    v.layer.cornerRadius = 10;
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(25));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(130));
    }];
    
    UIButton *buton=[[UIButton alloc]initWithFrame:CGRectMake(0,0 ,But_W , KFit_H6S(80))];
    [buton setTitle:@"订单进度" forState:UIControlStateNormal];
    [buton setTitleColor:kColor_N(40, 174, 104) forState:UIControlStateSelected];
    [buton setTitleColor:kColor_N(153, 153, 153) forState:UIControlStateNormal];
    buton.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(17)];
    [v addSubview:buton];
    buton.tag=0;
    buton.selected=YES;
    self.selectbut=buton;
    self.butOne = buton;
    
    UIButton *buttwo=[[UIButton alloc]initWithFrame:CGRectMake(But_W, 0, But_W, KFit_H6S(80))];
    [buttwo setTitle:@"订单详情" forState:UIControlStateNormal];
    [buttwo setTitleColor:kColor_N(153, 153, 153) forState:UIControlStateNormal];
    [buttwo setTitleColor:kColor_N(40, 174, 104) forState:UIControlStateSelected];
    buttwo.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(17)];
    [v addSubview:buttwo];
    self.butTwo = buttwo;
    buttwo.tag=1;
    
    UILabel *lb=[[UILabel alloc]init];
    [v addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(v);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(v).mas_offset(KFit_H6S(90));
    }];
    lb.backgroundColor=appcoloer_line;
  
    
    self.selectlab=[[UILabel alloc]initWithFrame:CGRectMake(KFit_W6S(60), KFit_H6S(82), But_W - KFit_W6S(120), KFit_H6S(8))];
    self.selectlab.backgroundColor=kColor_N(40, 174, 104);
    [v addSubview:self.selectlab];
    //按钮点击方法
    [buton addTarget:self action:@selector(navigationMethod:) forControlEvents:UIControlEventTouchUpInside];
    [buttwo addTarget:self action:@selector(navigationMethod:) forControlEvents:UIControlEventTouchUpInside];
    // *创建滚动视图
    [self addscrollview];
    
    UIButton *cancel = [[UIButton alloc] init];
    self.cancel = cancel;
    [self.view addSubview:cancel];
    [cancel setTitle:@"取消订单" forState:UIControlStateNormal];
    [cancel setTitleColor:kColor_N(80, 80, 80) forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(CancelTheOrder) forControlEvents:UIControlEventTouchUpInside];
    cancel.layer.cornerRadius = 5;
    cancel.layer.borderColor = appcoloer_line.CGColor;
    cancel.layer.borderWidth = 0.7;
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(25));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(230), KFit_H6S(80)));
    }];
    
    self.pay = [[UIButton alloc] init];
    [self.view addSubview:self.pay];
    [self.pay setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.pay addTarget:self action:@selector(topay) forControlEvents:UIControlEventTouchUpInside];
    self.pay.backgroundColor = kColor_N(40, 174, 104);
    self.pay.layer.cornerRadius = 5;
    [self.pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cancel.mas_right).mas_offset(KFit_W6S(25));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(25));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(cancel.mas_height);
    }];
    [self reloadview];
}
- (void)addscrollview{
    self.scroll =[[UIScrollView alloc]init];
    [self.backView addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView).mas_offset(KFit_H6S(90));
        make.bottom.left.right.mas_equalTo(self.backView);
    }];
    self.scroll.contentSize=CGSizeMake(2*(kScreenWidth - KFit_W6S(60)),0);
    self.scroll.bounces=NO;
    self.scroll.pagingEnabled=YES;
    self.scroll.delegate=self;
    [self addScrollSubview];
}

- (void)addScrollSubview{
    self.orderProgress = [[OrderProgressV alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - KFit_W6S(60),Scorll_H)];
    
    [self.scroll addSubview:self.orderProgress];
    
    self.orderDetails = [[OrderDetailsV alloc] initWithFrame:CGRectMake(kScreenWidth - KFit_W6S(60), 0, kScreenWidth - KFit_W6S(60),Scorll_H)];
    self.orderDetails.vc = self;
    [self.scroll addSubview:self.orderDetails];
    
    
}



#pragma mark-滚动视图代理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.x/(kScreenWidth - KFit_W6S(60))){
        [self navigationMethod:self.butTwo];
        
    }else{
        [self navigationMethod:self.self.butOne];
        
    }
}

- (void)navigationMethod:(UIButton *)sender{
    
    self.selectbut.selected=NO;
    sender.selected=YES;    //一二两行顺序不能换
    self.selectbut=sender;
    [UIView animateWithDuration:0.3 animations:^{
        self.selectlab.frame=CGRectMake(sender.frame.origin.x + KFit_W6S(60), KFit_H6S(82), But_W - KFit_W6S(120), KFit_H6S(8));
    }];
    self.scroll.contentOffset=CGPointMake(sender.tag*(kScreenWidth - KFit_W6S(60)), 0);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)topay{
    
    if (self.model.state == 4) {
        //去签订合同
        SignContractVC *vc = [[SignContractVC alloc] init];
        vc.model = self.model;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
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
    }
    
}

- (void)CancelTheOrder{
    NSString *ts;
    if (_model.state <= 3) {
        ts = @"取消订单后，该订单冻结的优能币会解冻";
    }else{
        ts = @"根据协议，如您取消该订单违约，首付款优能币退回你的账户，但平台将收取100优能币作为服务费！";
    }
    XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"你确认取消订单？" message:ts sureBtn:@"确认取消" cancleBtn:@"不取消"];
    [alert showXLAlertView];
    alert.resultIndex = ^(NSInteger index) {
        if (index == 2) {
            NSString *url=[NSString stringWithFormat:GETOrdersCancel,self.model.idid,[User UserOb].token];
            [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
                if (kResponseObjectStatusCodeIsEqual(200)) {
                    XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"取消成功" SuccessOrFailure:YES];
                    [alert showPrompt];
                    FMMainModel *model = [FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
                    self.model = model;
                    self.orderDetails.model = self.model;
                    self.orderProgress.data = model.logs;
                }
                [self reloadview];
            } failureBlock:^(NSError *error) {
                KKLog(@"%@", error);
                
            } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                
            }];
        }
    };
    
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadordersInfo];
}
#pragma mark - 加载详情信息
- (void)loadordersInfo{
    NSString *url=[NSString stringWithFormat:GETOrdersInfo,self.model.idid,[User UserOb].token];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        FMMainModel *model = [FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.model = model;
        self.orderDetails.model = self.model;
        self.orderProgress.data = model.logs;
        [self reloadview];
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)reloadview{
    if (_model.state == OrdersType3 || _model.state == OrdersType7 || _model.state == OrdersType10) {
        self.pay.hidden = YES;
    }
    if (_model.state < 0) {
        _cancel.hidden = YES;
        self.pay.hidden = YES;
        UILabel *lb = [[UILabel alloc] init];
        [self.view addSubview:lb];
        lb.textColor = kColor_N(0, 160, 52);
        lb.text = @"本订单剩余冻结优能币已解冻";
        lb.font = [UIFont systemFontOfSize:kFit_Font6(14)];
        [lb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
            make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
            make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(25));
            make.height.mas_equalTo(KFit_H6S(80));
        }];
    }
    if (_model.state == OrdersType10) {
        _cancel.hidden = YES;
    }
    if (_model.state == 4) {
        [self.pay setTitle:@"签订服务合同" forState:UIControlStateNormal];
    }else if (_model.state == 1){
        [self.pay setTitle:@"去确认订单" forState:UIControlStateNormal];
    }else if (_model.state == 5){
        [self.pay setTitle:@"支付首付款" forState:UIControlStateNormal];
    }else if (_model.state == 8){
        _cancel.hidden = YES;
        [self.pay setTitle:@"支付服务费余款" forState:UIControlStateNormal];
    }else{
        [self.pay setTitle:@"确认支付" forState:UIControlStateNormal];
    }
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
