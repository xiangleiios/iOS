//
//  ForgotPasswordVC.m
//  MobileProject
//
//  Created by zsgy on 17/8/2.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "ForgotPasswordVC.h"
#define viewHight KFit_H6S(110)
#define imgY KFit_H6S(30)
@interface ForgotPasswordVC ()<UITextFieldDelegate>
@property (nonatomic , strong)TKPhoneTextField *pho;
@property (nonatomic , strong)UITextField *verificationCode;
@property (nonatomic , strong)UITextField *password;
@property (nonatomic , strong)UITextField *passwordtwo;
@property (nonatomic , strong)UIButton *veribut;
@end

@implementation ForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"忘记密码";
    [self loadNavigation];
    
    [self loadsubview];
    
    [self loadfunctionbut];
    /* 账号密码*/
//    [self loadTheLoginBox];
    // Do any additional setup after loading the view.
}
- (void)loadNavigation{
    [self.navigationView setTitle:@"忘记密码"];
    //是否开启 手势侧滑返回
    self.customBackGestureEnabel = YES ;
    //侧滑距离左边最大的距离,
    self.customBackGestureEdge = SCREEN_WIDTH / 2.0 ;
}





- (void)loadsubview{
    UIView *v=[[UIView alloc]init];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(10));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(50));
        make.height.mas_equalTo(viewHight * 4);
    }];
    
    
    UIImageView *imgpho=[[UIImageView alloc]initWithFrame:CGRectMake(0, imgY, KFit_W6S(32), KFit_H6S(55))];
    [imgpho setImage:[UIImage imageNamed:@"tel"]];
    [v addSubview:imgpho];
    self.pho=[[TKPhoneTextField alloc]initWithFrame:CGRectMake(KFit_W6S(60), 0, KFit_W6S(400), viewHight)];
    self.pho.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.pho];
    self.pho.placeholder=@"请输入手机号码";
    self.pho.keyboardType=UIKeyboardTypeNumberPad;
    self.pho.delegate = self;
    
    
    
    UIImageView *imgCompany = [[UIImageView alloc]initWithFrame:CGRectMake(0, imgY + viewHight, KFit_W6S(32), KFit_H6S(45))];
    [imgCompany setImage:[UIImage imageNamed:@"password2"]];
    [v addSubview:imgCompany];
    self.password=[[UITextField alloc]initWithFrame:CGRectMake(KFit_W6S(60), viewHight, KFit_W6S(550), viewHight)];
    self.password.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.password];
    self.password.placeholder=@"请输入密码(4-20位数字及字母)";
    self.password.secureTextEntry=YES;
    
    
    UIImageView *imgpass=[[UIImageView alloc]initWithFrame:CGRectMake(0, imgY + viewHight *2, KFit_W6S(32), KFit_H6S(45))];
    [imgpass setImage:[UIImage imageNamed:@"password"]];
    [v addSubview:imgpass];
    self.passwordtwo=[[UITextField alloc]initWithFrame:CGRectMake(KFit_W6S(60), viewHight * 2, KFit_W6S(450), viewHight)];
    self.passwordtwo.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.passwordtwo];
    self.passwordtwo.placeholder=@"请再次输入密码";
    self.passwordtwo.secureTextEntry=YES;
    
    
    UIImageView *imgpasstwo=[[UIImageView alloc]initWithFrame:CGRectMake(0, imgY + viewHight *3, KFit_W6S(32), KFit_H6S(45))];
    [imgpasstwo setImage:[UIImage imageNamed:@"message"]];
    [v addSubview:imgpasstwo];
    self.verificationCode=[[UITextField alloc]initWithFrame:CGRectMake(KFit_W6S(60), viewHight * 3, KFit_W6S(400), viewHight)];
    self.verificationCode.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.verificationCode];
    self.verificationCode.placeholder=@"请输入短信验证码";
    self.verificationCode.secureTextEntry=YES;
    
    
    
    
    self.veribut=[[UIButton alloc]init];
    [v addSubview:self.veribut];
    [self.veribut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(v).mas_offset(-KFit_W6S(15));
        make.centerY.mas_equalTo(imgpasstwo);
        make.width.mas_equalTo(KFit_W6S(200));
        make.height.mas_equalTo(KFit_H6S(54));
    }];
    [self.veribut setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.veribut setTitleColor:kRGBColor(251, 189, 44) forState:UIControlStateNormal];
    [self.veribut addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    self.veribut.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(12)];
  
    UILabel *lb=[[UILabel alloc]init];
    lb.backgroundColor=kRGBColor(239, 239, 246);
    [v addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.mas_equalTo(v);
        make.top.mas_equalTo(self.pho.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lbt=[[UILabel alloc]init];
    lbt.backgroundColor=kRGBColor(239, 239, 246);
    [v addSubview:lbt];
    [lbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.bottom.mas_equalTo(v);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lbf=[[UILabel alloc]init];
    lbf.backgroundColor=kRGBColor(239, 239, 246);
    [v addSubview:lbf];
    [lbf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.mas_equalTo(v);
        make.top.mas_equalTo(self.password.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lbfi=[[UILabel alloc]init];
    lbfi.backgroundColor=kRGBColor(239, 239, 246);
    [v addSubview:lbfi];
    [lbfi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.mas_equalTo(v);
        make.top.mas_equalTo(self.passwordtwo.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
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
    NSString *url=[NSString stringWithFormat:GETmembersMobileCheckcode,phone,2];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showAutoMessage:@"已发送"];
            [FMRegExpTool startTime:self.veribut];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        
    } progress:nil];
}

- (void)loadfunctionbut{
    UIButton *but=[[UIButton alloc]init];
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verificationCode.mas_bottom).mas_offset(KFit_H6S(100));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(50));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    but.layer.cornerRadius=5;
    but.backgroundColor = kColor_N(40, 174, 104);
    [but setTitle:@"重置密码" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(toResetYourPassword) forControlEvents:UIControlEventTouchUpInside];
}


- (void)toResetYourPassword{
    NSString *p = [self.pho.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* phone = [p stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* YZM=self.verificationCode.text;
    NSString *passwordo=self.password.text;
    NSString *passwordt=self.passwordtwo.text;
    if( phone.length < 1 )
    {
        [MBProgressHUD showAutoMessage:@"请输入手机号！"];
        return;
    }
    if( ![FMRegExpTool fm_checkingMobile:phone] )
    {
        [MBProgressHUD showAutoMessage:@"请输入正确的手机号！"];
        return;
    }
    if (YZM.length<1) {
        [MBProgressHUD showAutoMessage:@"请输入验证码！"];
        return;
    }
    if( passwordo.length < 1 ||passwordt.length<1)
    {
        
        [MBProgressHUD showAutoMessage:@"请输入密码"];
        return;
    }
    if( passwordo.length<4||passwordt.length<4)
    {
        
        [MBProgressHUD showAutoMessage:@"密码不能小于4个字符"];
        return;
    }
    if( passwordo.length > 20||passwordt.length > 20)
    {
        
        [MBProgressHUD showAutoMessage:@"密码不能大于20个字符"];
        return;
    }
    if (![passwordo isEqualToString:passwordt]) {
        [MBProgressHUD showAutoMessage:@"两次密码输入不一致"];
        return;
    }
    NSString *url=[NSString stringWithFormat:GETResetYourPassword,phone,passwordo,YZM];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"修改成功" SuccessOrFailure:YES];
            [alert showPrompt];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } failureBlock:^(NSError *error) {
        
    } progress:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
