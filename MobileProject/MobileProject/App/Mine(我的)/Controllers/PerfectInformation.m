//
//  PerfectInformation.m
//  MobileProject
//
//  Created by zsgy on 17/8/3.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "PerfectInformation.h"

@interface PerfectInformation ()
@property (nonatomic , strong)UITextField *phoneNum;
@property (nonatomic , strong)UITextField *verificationCode;
@property (nonatomic , strong)UIButton *verificationButton;
@end

@implementation PerfectInformation

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =  @"手机绑定";
    self.view.backgroundColor =  kRGBColor(239, 239, 246);
    [self loadSubview];
}

- (void)loadSubview{
    UIView *v =  [[UIView alloc]init];
    v.backgroundColor =  [UIColor whiteColor];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(25));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(25));
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(210));
    }];
    
    UILabel *lb =  [[UILabel alloc]init];
    lb.font =  [UIFont systemFontOfSize:kFit_Font6(15)];
    lb.text =  @"手机号";
    UILabel *lbtwo =  [[UILabel alloc]init];
    lbtwo.font =  [UIFont systemFontOfSize:kFit_Font6(15)];
    lbtwo.text =  @"验证码";
    [v addSubview:lb];
    [v addSubview:lbtwo];
    
    
    NSArray *arr =  [NSArray arrayWithObjects:lb,lbtwo, nil];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:1.0 leadSpacing:0 tailSpacing:0];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(30));
        make.width.mas_equalTo(KFit_W6S(120));
    }];
    
    _phoneNum =  [[XLTextField alloc]init];
    [v addSubview:_phoneNum];
    _phoneNum.keyboardType = UIKeyboardTypeNamePhonePad;
    _phoneNum.layer.cornerRadius =  KFit_H6S(30);
    _phoneNum.layer.borderColor =  [UIColor lightGrayColor].CGColor;
    _phoneNum.layer.borderWidth =  0.5;
    _phoneNum.placeholder =  @"请输入手机号";
    
    _phoneNum.font =  [UIFont systemFontOfSize:kFit_Font6(15)];
    [_phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lb);
        make.left.mas_equalTo(lb.mas_right);
        make.height.mas_equalTo(KFit_H6S(60));
        make.width.mas_equalTo(KFit_W6S(380));
    }];
    
    
    self.verificationCode =  [[XLTextField alloc]init];
    [v addSubview:self.verificationCode];
    self.verificationCode.layer.cornerRadius =  KFit_H6S(30);
    self.verificationCode.layer.borderColor =  [UIColor lightGrayColor].CGColor;
    self.verificationCode.layer.borderWidth =  0.5;
    self.verificationCode.placeholder =  @"请输入验证码";
    self.verificationCode.font =  [UIFont systemFontOfSize:kFit_Font6(15)];
    [self.verificationCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lbtwo);
        make.left.mas_equalTo(lbtwo.mas_right);
        make.height.mas_equalTo(KFit_H6S(60));
        make.width.mas_equalTo(KFit_W6S(380));
    }];
    
    
    self.verificationButton =  [[UIButton alloc]init];
    [v addSubview:self.verificationButton];
    [self.verificationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(v).mas_offset(-KFit_W6S(15));
        make.centerY.mas_equalTo(_phoneNum);
        make.width.mas_equalTo(KFit_W6S(200));
        make.height.mas_equalTo(KFit_H6S(54));
    }];
    [self.verificationButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.verificationButton setTitleColor:kRGBColor(251, 189, 44) forState:UIControlStateNormal];
    [self.verificationButton addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    self.verificationButton.titleLabel.font =  [UIFont systemFontOfSize:kFit_Font6(12)];
    
    [self bangDingNow];
}

- (void)getVerificationCode {
    NSString* phone  =   [_phoneNum.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if( phone.length < 1 ) {
        [MBProgressHUD showAutoMessage:@"请输入手机号！"];
        return;
    }else if( ![FMRegExpTool fm_checkingMobile:phone] ) {
        [MBProgressHUD showAutoMessage:@"请输入正确的手机号！"];
        return;
    }
    NSString *url =  [NSString stringWithFormat:GETmembersMobileCheckcode,phone,0];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [self.view endEditing:YES];
            [MBProgressHUD showAutoMessage:@"已发送"];
            [FMRegExpTool startTime:self.verificationButton];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        
    } progress:nil];
}

- (void)bangDingNow {
    UIButton *but =  [[UIButton alloc]init];
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.verificationCode.mas_bottom).mas_offset(KFit_H6S(110));
        make.width.mas_equalTo(KFit_W6S(530));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    but.layer.cornerRadius =  KFit_H6S(40);
    but.backgroundColor =  kRGBColor(251, 189, 44);
    [but setTitle:@"立即绑定" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(completeBinding) forControlEvents:UIControlEventTouchUpInside];
}

- (void)completeBinding{
    NSString* phone  =   [_phoneNum.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* yzCode =  self.verificationCode.text;
    if( phone.length < 1 ) {
        [MBProgressHUD showAutoMessage:@"请输入手机号！"];
        return;
    } else if( ![FMRegExpTool fm_checkingMobile:phone] ) {
        [MBProgressHUD showAutoMessage:@"请输入正确的手机号！"];
        return;
    } else if (yzCode.length < 1) {
        [MBProgressHUD showAutoMessage:@"请输入验证码！"];
        return;
    }
    
    NSString *url =  [NSString stringWithFormat:GETBindingMobilePhone,self.dic[@"token"],phone,yzCode];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showAutoMessage:@"完成绑定"];
            NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:self.dic];
            [mutableDic setValue:_phoneNum.text forKey:@"mobile"];
            User *user =  [User UserOb];
            [user UserSave:mutableDic];
            user.mobile= _phoneNum.text;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        
    } progress:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
