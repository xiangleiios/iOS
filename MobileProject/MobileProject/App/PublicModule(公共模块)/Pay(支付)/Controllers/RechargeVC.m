//
//  RechargeVC.m
//  MobileProject
//
//  Created by zsgy on 2018/6/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "RechargeVC.h"
#import "FMPayCell.h"
#import "OfflinePayVC.h"
#import "HWebVc.h"
@interface RechargeVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic , strong)UITextField *money;
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray *data;
@property (nonatomic, strong)UIButton *pay;
@property (nonatomic, assign)NSInteger index;
@end

@implementation RechargeVC
- (NSMutableArray *)data{
    if (!_data) {
        _data =[[NSMutableArray alloc] init];
        FMMainModel *model = [[FMMainModel alloc] init];
        model.name = @"支付宝支付";
        model.image_url = @"Alipay_cs"; //wechatpay  pay_pitchon  pay_unselected
        model.video_url = @"Alipay_gray";
        
        FMMainModel *model2 = [[FMMainModel alloc] init];
        model2.name = @"微信支付";
        model2.image_url = @"WeChat_cs"; //wechatpay  pay_pitchon  pay_unselected
        model2.video_url = @"WeChat_gray";
        
        FMMainModel *model3 = [[FMMainModel alloc] init];
        model3.name = @"银联支付";
        model3.image_url = @"UnionPay_cs"; //wechatpay  pay_pitchon  pay_unselected
        model3.video_url = @"UnionPay_gray";
        
        FMMainModel *model4 = [[FMMainModel alloc] init];
        model4.name = @"线下支付";
        model4.image_url = @"Offline-pay_cs"; //wechatpay  pay_pitchon  pay_unselected
        model4.video_url = @"Offline-pay_gray";
        
        [_data addObject:model];
        [_data addObject:model2];
        [_data addObject:model3];
        [_data addObject:model4];
    }
    return _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.index = 0;// 默认第一个支付宝
    [self.navigationView.titleLabel setTextColor:[UIColor blackColor]];
    [self.navigationView setTitle:@"我的账户转入"];
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubview{
    UILabel *lbone = [[UILabel alloc] init];
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    lbone.textColor = kColor_N(47, 47, 47);
    lbone.text = @"转入金额";
    [self.view addSubview:lbone];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(25));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(25));
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(20) + kNavBarH);
        make.height.mas_equalTo(KFit_W6S(40));
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(25) weight:1];
    lbtwo.text = @"￥";
    [self.view addSubview:lbtwo];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(25));
        make.top.mas_equalTo(lbone.mas_bottom).mas_offset(KFit_H6S(55));
        make.height.mas_equalTo(KFit_W6S(80));
        make.width.mas_equalTo(KFit_W6S(50));
    }];
    
    self.money = [[UITextField alloc] init];
    self.money.delegate = self;
    self.money.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.money];
    self.money.font = [UIFont systemFontOfSize:kFit_Font6(44) weight:0.4];
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lbtwo.mas_right);
        make.centerY.height.mas_equalTo(lbtwo);
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(25));
    }];
    
    UILabel *lblineone = [[UILabel alloc] init];
    lblineone.backgroundColor = appcoloer_line;
    [self.view addSubview:lblineone];
    [lblineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(lbone);
        make.top.mas_equalTo(self.money.mas_bottom).mas_offset(KFit_H6S(10));
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    
    UILabel *lbthree = [[UILabel alloc] init];
    lbthree.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    lbthree.text = @"兑换关系：1人民币兑换1优能币";
    lbthree.textColor = kColor_N(237, 132, 67);
    [self.view addSubview:lbthree];
    [lbthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(lbone);
        make.top.mas_equalTo(lblineone.mas_bottom).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_W6S(30));
        
    }];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.scrollEnabled =NO;
    self.table.layer.borderColor = appcoloer_line.CGColor;
    self.table.layer.borderWidth = 0.7;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.table.tableHeaderView = [self tableHeadView];
    //    self.table.tableFooterView = [self tableFootview];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(lbone);
        make.top.mas_equalTo(lbthree.mas_bottom).mas_offset(KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(360));
    }];
    
    
    UIButton *but = [[UIButton alloc] init];
    [but setTitle:@"收款账号详情>>" forState:UIControlStateNormal];
    [but setTitleColor:kColor_N(44, 163, 212) forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    [but addTarget:self action:@selector(checkTheAgreement) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.table.mas_bottom).mas_offset(-KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(200), KFit_H6S(50)));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(250));
    }];
    
    self.pay = [[UIButton alloc] init];
    [self.view addSubview:self.pay];
    [self.pay setTitle:@"支  付" forState:UIControlStateNormal];
    [self.pay setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.pay.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(18)];
    self.pay.layer.cornerRadius=5;
    self.pay.backgroundColor = kColor_N(40, 174, 104);
    [self.pay addTarget:self action:@selector(toPay) forControlEvents:UIControlEventTouchUpInside];
    [self.pay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(50));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(50));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
}


- (void)toPay{
    
    if ([self.money.text  isEqual: @""] || self.money.text.length < 1) {
        [MBProgressHUD showAutoMessage:@"请输入金额！"];
        return;
    }
    if([self.money.text integerValue] == 0){
        [MBProgressHUD showAutoMessage:@"支付金额不能为零！"];
        return;
    }
    if([self.money.text integerValue] > 1000000){
        [MBProgressHUD showAutoMessage:@"支付金额不能大于100万！"];
        return;
    }
//    if ((self.index + 1) == PayTypeYL) {
//       XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:@"银联支付尚在开发中" sureBtn:@"确定" cancleBtn:nil];
//        [alert showXLAlertView];
//        return;
//    
//    }
    OfflinePayVC *vc = [[OfflinePayVC alloc] init];
    vc.payType = (self.index + 1);
    vc.num = self.money.text;
    if (vc.payType == PayTypeOffline) {
        vc.title = @"上传凭证";
    }else{
        vc.title = @"支付";
    }
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(90);
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"FMPayCell";
    
    FMPayCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FMPayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    
    if (self.index == indexPath.row) {
//        cell.yfSeletButton.selected = YES;
        cell.yfCoverIma.selected = YES;
    }else{
//        cell.yfSeletButton.selected = NO;
        cell.yfCoverIma.selected = NO;
    }
    cell.model = self.data[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.index = indexPath.row;
    [self.table reloadData];
    if (self.index == 3) {
        [self.pay setTitle:@"上传凭证" forState:UIControlStateNormal];
    }else{
        [self.pay setTitle:@"支  付" forState:UIControlStateNormal];
    }
}

//设置文本框只能输入数字

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //如果是限制只能输入数字的文本框
    return [self validateNumber:string];
    
}


- (BOOL)validateNumber:(NSString*)number {
    
    BOOL res =YES;
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    int i =0;
    
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i,1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length ==0) {
            res =NO;
            break;
        }
        i++;
    }
    return res;
}

- (void)checkTheAgreement{
    HWebVc *vc= [[HWebVc alloc] init];
    vc.title = @"收款账户";
    vc.url = HTMLPaymentAccount;
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
