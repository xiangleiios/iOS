//
//  MyAccountVC.m
//  MobileProject
//
//  Created by zsgy on 2018/6/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "MyAccountVC.h"
#import "RechargeVC.h"
#import "BillVC.h"
@interface MyAccountVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)UILabel *totalAmount; //总金额
@property (nonatomic , strong)UILabel *amountAvailable;//可用金额
@property (nonatomic , strong)UILabel *amountFrozen;//冻结金额
@property (nonatomic , strong)UIButton *pay;
@property (nonatomic , strong)NSMutableAttributedString *noteStr;
@property (nonatomic , strong)XLView *back;
@property (nonatomic , strong)AccountModel *model;
@end

@implementation MyAccountVC
- (NSMutableAttributedString *)noteStr{
//    if (_noteStr == nil) {
        // 创建Attributed
        _noteStr = [[NSMutableAttributedString alloc] initWithString:self.totalAmount.text];
        // 需要改变的第一个文字的位置
        NSUInteger firstLoc = [[_noteStr string] rangeOfString:@":"].location + 1;
        // 需要改变的最后一个文字的位置
        NSUInteger secondLoc = [[_noteStr string] rangeOfString:@"优"].location;
        // 需要改变的区间
        NSRange range = NSMakeRange(0, secondLoc);
        // 改变颜色
        [_noteStr addAttribute:NSForegroundColorAttributeName value:appcoloer range:range];
        // 改变字体大小及类型
        [_noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFit_Font6(22)] range:range];
        // 为label添加Attributed
//    }
    return _noteStr;
}
- (NSMutableArray *)data{
    if (_data == nil) {
        _data = [NSMutableArray arrayWithObject:@"11"];
    }
    return _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"我的账户"];
    self.navigationView.titleLabel.textColor = [UIColor blackColor];
    kWeakSelf(self)
    [self.navigationView addRightButtonWithTitle:@"流水明细" clickCallBack:^(UIView *view) {
        BillVC *vc = [[BillVC alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    [self loadSubview];
//    [self loadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubview{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(200));
    }];
    
    _back = [[XLView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scroll addSubview:_back];
    
    UILabel *money = [[UILabel alloc] init];
    [_back addSubview:money];
    money.text = @"账户总金额";
    money.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    money.textAlignment = NSTextAlignmentCenter;
    [money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_back);
        make.top.mas_equalTo(_back).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.totalAmount = [[UILabel alloc] init];
    [_back addSubview:self.totalAmount];
    self.totalAmount.textAlignment = NSTextAlignmentCenter;
    self.totalAmount.textColor = appcoloer;
    [self.totalAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_back);
        make.top.mas_equalTo(money.mas_bottom).mas_offset(KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(60));
    }];
    
    
    self.amountAvailable = [[UILabel alloc] init];
    self.amountAvailable.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    self.amountAvailable.textColor = kColor_N(246, 97, 0);
    self.amountAvailable.textAlignment = NSTextAlignmentCenter;
    [_back addSubview:self.amountAvailable];
    [self.amountAvailable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_back);
        make.top.mas_equalTo(self.totalAmount.mas_bottom).mas_offset(KFit_H6S(60));
        make.height.mas_equalTo(KFit_W6S(40));
        make.width.mas_equalTo(SCREEN_WIDTH/2.0);
    }];
    
    self.amountFrozen = [[UILabel alloc] init];
    self.amountFrozen.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    self.amountFrozen.textColor = kColor_N(0, 148, 208);
    self.amountFrozen.textAlignment = NSTextAlignmentCenter;
    [_back addSubview:self.amountFrozen];
    [self.amountFrozen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.amountAvailable.mas_right);
        make.right.mas_equalTo(_back);
        make.top.mas_equalTo(self.totalAmount.mas_bottom).mas_offset(KFit_H6S(60));
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
    UILabel *lbone = [[UILabel alloc] init];
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    lbone.textColor = kColor_N(97, 97, 97);
    lbone.text = @"可用金额";
    lbone.textAlignment = NSTextAlignmentCenter;
    [_back addSubview:lbone];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.amountAvailable);
        make.top.mas_equalTo(self.amountAvailable.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    lbtwo.textColor = kColor_N(97, 97, 97);
    lbtwo.text = @"冻结金额";
    lbtwo.textAlignment = NSTextAlignmentCenter;
    [_back addSubview:lbtwo];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.amountFrozen);
        make.top.mas_equalTo(self.amountFrozen.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
   
    
    self.pay = [[UIButton alloc] init];
    [self.view addSubview:self.pay];
    [self.pay setTitle:@"转  入" forState:UIControlStateNormal];
    [self.pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.pay.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(18)];
    self.pay.layer.cornerRadius=5;
    self.pay.backgroundColor = kColor_N(40, 174, 104);
    [self.pay addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [self.pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(50));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(90));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}


- (void)loadData{
    NSString *url = [NSString stringWithFormat:GETMembersAccountInfo,[User UserOb].token];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic = responseObject[@"data"];
            AccountModel *model = [AccountModel mj_objectWithKeyValues:dic];
            self.model = model;
            
            self.totalAmount.text = [NSString stringWithFormat:@"%@优能币",[XLCommonUse separatedDigitStringWithStr:[NSString stringWithFormat:@"%ld",(long)model.money_sum]]];
            [self.totalAmount setAttributedText:self.noteStr];
            self.amountAvailable.text = [NSString stringWithFormat:@"%@优能币",[XLCommonUse separatedDigitStringWithStr:[NSString stringWithFormat:@"%ld",(long)model.money_free]]];
            self.amountFrozen.text = [NSString stringWithFormat:@"%@优能币",[XLCommonUse separatedDigitStringWithStr:[NSString stringWithFormat:@"%ld",(long)model.money_freeze]]];
            [self loadFreezeOrders];
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)loadFreezeOrders{
    UILabel *lblineone;
    lblineone = [[UILabel alloc] init];
    lblineone.backgroundColor = kColor_N(232, 232, 232);
    [_back addSubview:lblineone];
    [lblineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_back);
        make.top.mas_equalTo(self.amountAvailable.mas_bottom).mas_offset(KFit_H6S(80));
        make.height.mas_equalTo(KFit_W6S(12));
    }];
    if (self.model.freeze_orders.count > 0) {
        UILabel *lbDD = [[UILabel alloc] init];
        lbDD.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        lbDD.textColor = kColor_N(97, 97, 97);
        lbDD.text = @"订单号";
        lbDD.textAlignment = NSTextAlignmentCenter;
        [_back addSubview:lbDD];
        [lbDD mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.amountAvailable);
            make.right.mas_equalTo(self.amountAvailable).mas_offset(KFit_W6S(90));
            make.top.mas_equalTo(lblineone.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(KFit_W6S(40));
        }];
        
        UILabel *lbYNB = [[UILabel alloc] init];
        lbYNB.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        lbYNB.textColor = kColor_N(97, 97, 97);
        lbYNB.text = @"冻结金额(优能币)";
        lbYNB.textAlignment = NSTextAlignmentCenter;
        [_back addSubview:lbYNB];
        [lbYNB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.amountFrozen);
            make.left.mas_equalTo(lbDD.mas_right);
            make.top.mas_equalTo(lblineone.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(KFit_W6S(40));
        }];
        
        UILabel *lb_lien;
        lb_lien = [[UILabel alloc] init];
        [_back addSubview:lb_lien];
        [lb_lien mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_back);
            make.top.mas_equalTo(lbDD.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(KFit_W6S(1));
        }];
        
        for (int i = 0; i < self.model.freeze_orders.count; i++) {
            NSDictionary *dic =self.model.freeze_orders[i];
            
            UILabel *lbone = [[UILabel alloc] init];
            lbone.font = [UIFont systemFontOfSize:kFit_Font6(16)];
            lbone.textColor = kColor_N(97, 97, 97);
            lbone.text = [NSString stringWithFormat:@" %@",dic[@"order_num"]];
            lbone.textAlignment = NSTextAlignmentCenter;
            [_back addSubview:lbone];
            [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(lbDD);
                make.top.mas_equalTo(lb_lien.mas_bottom).mas_offset(KFit_H6S(10));
                make.height.mas_equalTo(KFit_W6S(40));
            }];
            
            UILabel *lbtwo = [[UILabel alloc] init];
            lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(16)];
            lbtwo.textColor = kColor_N(97, 97, 97);
            lbtwo.text = [NSString stringWithFormat:@"%d",[dic[@"money"] intValue]];
            lbtwo.textAlignment = NSTextAlignmentCenter;
            [_back addSubview:lbtwo];
            [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(lbYNB);
                make.top.mas_equalTo(lb_lien.mas_bottom).mas_offset(KFit_H6S(10));
                make.height.mas_equalTo(KFit_W6S(40));
            }];
            
            lb_lien = [[UILabel alloc] init];
            [_back addSubview:lb_lien];
            [lb_lien mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(_back);
                make.top.mas_equalTo(lbone.mas_bottom).mas_offset(KFit_H6S(10));
                make.height.mas_equalTo(KFit_W6S(1));
            }];
        }
        lblineone = [[UILabel alloc] init];
        lblineone.backgroundColor = kColor_N(232, 232, 232);
        [_back addSubview:lblineone];
        [lblineone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_back);
            make.top.mas_equalTo(lb_lien.mas_bottom).mas_offset(KFit_H6S(10));
            make.height.mas_equalTo(KFit_W6S(12));
        }];
    }
    _back.frame = CGRectMake(0, 0, SCREEN_WIDTH, [_back getLayoutCellHeightWithFlex:KFit_H6S(100)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(_back.frame));
    if (self.model.money_offline != 0) {
        
        UILabel *lbone = [[UILabel alloc] init];
        lbone.font = [UIFont systemFontOfSize:kFit_Font6(17)];
        lbone.textColor = kColor_N(97, 97, 97);
        
        
        lbone.text = [NSString stringWithFormat:@"  *线下支付等待确认：%@优能币",[XLCommonUse separatedDigitStringWithStr:[NSString stringWithFormat:@"%ld",(long)self.model.money_offline]]];
        [_back addSubview:lbone];
        [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_back);
            make.top.mas_equalTo(lblineone.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(KFit_W6S(40));
        }];
        // 创建Attributed
        NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:lbone.text];
        // 需要改变的第一个文字的位置
        NSUInteger firstLoc = [[noteStr string] rangeOfString:@"："].location + 1;
        // 需要改变的最后一个文字的位置
        NSUInteger secondLoc = [[noteStr string] rangeOfString:@"币"].location + 1;
        // 需要改变的区间
        NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
        // 改变颜色
        [noteStr addAttribute:NSForegroundColorAttributeName value:kColor_N(246, 97, 0) range:range];
        // 改变字体大小及类型
        [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:kFit_Font6(17)] range:range];
        // 为label添加Attributed
        [lbone setAttributedText:noteStr];
        _back.frame = CGRectMake(0, 0, SCREEN_WIDTH, [_back getLayoutCellHeightWithFlex:KFit_H6S(100)]);
        self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(_back.frame));
    }
}




- (void)toPay{
    RechargeVC *vc = [[RechargeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
