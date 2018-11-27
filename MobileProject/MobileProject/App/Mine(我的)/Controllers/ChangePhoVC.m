//
//  ChangePhoVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ChangePhoVC.h"
#define viewHight KFit_H6S(110)
@interface ChangePhoVC ()<UITextFieldDelegate>
@property (nonatomic , strong)TKPhoneTextField *pho;
@property (nonatomic , strong)UITextField *verificationCode;
@property (nonatomic , strong)UIButton *veribut;
@property (nonatomic , strong)NSString *verifyCode;
@end

@implementation ChangePhoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"跟换手机号"];
    [self loadSubv];
    // Do any additional setup after loading the view.
}


- (void)loadSubv{
    self.pho=[[TKPhoneTextField alloc]initWithFrame:CGRectMake(KFit_W6S(60), kNavBarH, KFit_W6S(400), viewHight)];
    self.pho.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [self.view addSubview:self.pho];
    self.pho.placeholder=@"请输入手机号码";
    self.pho.keyboardType=UIKeyboardTypeNumberPad;
    self.pho.delegate = self;
    
    
    UILabel *lbt=[[UILabel alloc]init];
    lbt.backgroundColor=kRGBColor(240, 240, 240);
    [self.view addSubview:lbt];
    [lbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.pho.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.verificationCode=[[UITextField alloc]initWithFrame:CGRectMake(KFit_W6S(60), kNavBarH +viewHight * 1, KFit_W6S(400), viewHight)];
    self.verificationCode.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [self.view addSubview:self.verificationCode];
    self.verificationCode.placeholder=@"请输入短信验证码";
    self.verificationCode.secureTextEntry=YES;
    
    UILabel *lb=[[UILabel alloc]init];
    lb.backgroundColor=kRGBColor(240, 240, 240);
    [self.view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.verificationCode.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.veribut=[[UIButton alloc]init];
    [self.view addSubview:self.veribut];
    [self.veribut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(15));
        make.centerY.mas_equalTo(self.verificationCode);
        make.width.mas_equalTo(KFit_W6S(200));
        make.height.mas_equalTo(KFit_H6S(54));
    }];
    [self.veribut setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.veribut setTitleColor:kRGBColor(251, 189, 44) forState:UIControlStateNormal];
    [self.veribut addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    self.veribut.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(12)];
    
    UIButton *login=[[UIButton alloc]init];
    [self.view addSubview:login];
    login.backgroundColor=kRGBColor(0, 112, 234 );
    [login setTitle:@"确定" forState:UIControlStateNormal];
    login.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(18)];
    [login addTarget:self action:@selector(loging) forControlEvents:UIControlEventTouchUpInside];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lb.mas_bottom).mas_offset(KFit_H6S(50));
        make.height.mas_equalTo(KFit_H6S(90));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(KFit_W6S(670));
    }];
    login.layer.cornerRadius = 5;
}

- (void)getVerificationCode{
    NSString *p = [self.pho.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* phone = [p stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if( phone.length < 1 )
    {
        [MBProgressHUD showAutoMessage:@"请输入手机号！"];
        return;
    }
    if( ![FMRegExpTool fm_checkingMobile:phone] )
    {
        [MBProgressHUD showAutoMessage:@"请输入手机号！"];
        return;
    }
    NSString *url=[NSString stringWithFormat:GETmembersMobileCheckcode,phone];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject){
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showAutoMessage:@"已发送"];
            [FMRegExpTool startTime:self.veribut];
            self.verifyCode = responseObject[@"verifyCode"];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)loging{
    NSString *p = [self.pho.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* phone = [p stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (self.verificationCode.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请填写验证码"];
        return;
    }
    if (self.pho.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请填写手机号码"];
        return;
    }
    if ([self.verifyCode intValue] != [self.verificationCode.text intValue]) {
        [MBProgressHUD showMsgHUD:@"验证码错误"];
        return;
    }
    NSString *url=POSTupdateCoachPhone;
    NSDictionary *dic = @{@"phoneNumber":phone};
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject){
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            [MBProgressHUD showMsgHUD:@"修改成功"];
            [defaults setObject:phone forKey:@"mobile"];
            [defaults synchronize];
            [User UserOb].mobile = phone;
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//限制最大输入字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (textField == _pho) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 13) {
            
            return NO;
        }
    }
    if([string hasSuffix:@" "])     // 忽视空格
        return NO;
    else
        return YES;
    return YES;
}
@end
