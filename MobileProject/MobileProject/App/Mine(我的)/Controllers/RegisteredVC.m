//
//  RegisteredVC.m
//  MobileProject
//
//  Created by zsgy on 17/8/2.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "RegisteredVC.h"
#import "HWebVc.h"
#define viewHight KFit_H6S(110)
#define imgY KFit_H6S(30)
@interface RegisteredVC ()<UITextFieldDelegate>
@property (nonatomic , strong)TKPhoneTextField *pho;
@property (nonatomic , strong)UITextField *password;
@property (nonatomic , strong)UITextField *passwordtwo;
@property (nonatomic , strong)UITextField *verificationCode;
@property (nonatomic , strong)UITextField *companyName;
@property (nonatomic , strong)UIButton *veribut;
@property (nonatomic , strong)UIImageView *logimg;
@property (nonatomic , strong)UIButton *selectBut;
@end

@implementation RegisteredVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"注册";
    self.view.backgroundColor=[UIColor whiteColor];
    [self loadNavigation];
    /*图标*/
//    [self loadingIcon];
    /* 账号密码*/
    [self loadTheLoginBox];
    /* 功能按钮*/
    [self loadTheFunctionButton];
    
    
    // Do any additional setup after loading the view.
}

- (void)loadNavigation{
    kWeakSelf(self)
    [self.navigationView setTitle:@"注册淘电宝"];
    //是否开启 手势侧滑返回
    self.customBackGestureEnabel = YES ;
    //侧滑距离左边最大的距离,
    self.customBackGestureEdge = SCREEN_WIDTH / 2.0 ;
    [self.navigationView addRightButtonWithTitle:@"登录" clickCallBack:^(UIView *view){
        [weakself.navigationController popViewControllerAnimated:YES];
    }];
//    [self.navigationView addRightButtonWithTitle:@"注册" clickCallBack:^(UIView *view) {
//
//    }];
    
}



- (void)loadingIcon{
    UIImageView *img=[[UIImageView alloc]init];
    self.logimg=img;
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(90));
        make.centerX.mas_equalTo(self.view);
        make.height.width.mas_equalTo(KFit_W6S(140));
    }];
    [img setImage:[UIImage imageNamed:@"logoa"]];
}



- (void)loadTheLoginBox{
    UIView *v=[[UIView alloc]init];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(10));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(50));
        make.height.mas_equalTo(viewHight * 5);
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
    [imgCompany setImage:[UIImage imageNamed:@"unit"]];
    [v addSubview:imgCompany];
    self.companyName=[[UITextField alloc]initWithFrame:CGRectMake(KFit_W6S(60), viewHight, KFit_W6S(400), viewHight)];
    self.companyName.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.companyName];
    self.companyName.placeholder=@"请输入单位全称";
    
    
    
    UIImageView *imgpass=[[UIImageView alloc]initWithFrame:CGRectMake(0, imgY + viewHight *2, KFit_W6S(32), KFit_H6S(45))];
    [imgpass setImage:[UIImage imageNamed:@"password"]];
    [v addSubview:imgpass];
    self.password=[[UITextField alloc]initWithFrame:CGRectMake(KFit_W6S(60), viewHight * 2, KFit_W6S(450), viewHight)];
    self.password.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.password];
    self.password.placeholder=@"请输入密码(4-20位数字及字母)";
    self.password.secureTextEntry=YES;
    
    
    UIImageView *imgpasstwo=[[UIImageView alloc]initWithFrame:CGRectMake(0, imgY + viewHight *3, KFit_W6S(32), KFit_H6S(45))];
    [imgpasstwo setImage:[UIImage imageNamed:@"password2"]];
    [v addSubview:imgpasstwo];
    self.passwordtwo=[[UITextField alloc]initWithFrame:CGRectMake(KFit_W6S(60), viewHight * 3, KFit_W6S(400), viewHight)];
    self.passwordtwo.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.passwordtwo];
    self.passwordtwo.placeholder=@"请再次输入密码";
    self.passwordtwo.secureTextEntry=YES;
    
    
    UIImageView *imgverf=[[UIImageView alloc]initWithFrame:CGRectMake(0, imgY + viewHight *4, KFit_W6S(32), KFit_H6S(45))];
    [imgverf setImage:[UIImage imageNamed:@"message"]];
    [v addSubview:imgverf];
    self.verificationCode=[[UITextField alloc]initWithFrame:CGRectMake(KFit_W6S(60), viewHight *4, KFit_W6S(400), viewHight)];
    self.verificationCode.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.verificationCode];
    self.verificationCode.placeholder=@"请输入短信验证码";
    
    
    self.veribut=[[UIButton alloc]init];
    [v addSubview:self.veribut];
    [self.veribut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(v);
        make.centerY.mas_equalTo(imgverf);
        make.width.mas_equalTo(KFit_W6S(200));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    [self.veribut setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.veribut setTitleColor:kRGBColor(251, 189, 44) forState:UIControlStateNormal];
    [self.veribut addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    //    self.veribut.layer.borderColor=kRGBColor(251, 189, 44).CGColor;
    //    self.veribut.layer.borderWidth=0.5;
    self.veribut.layer.cornerRadius=KFit_H6S(27);
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
    
    UILabel *lbth=[[UILabel alloc]init];
    lbth.backgroundColor=kRGBColor(239, 239, 246);
    [v addSubview:lbth];
    [lbth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.mas_equalTo(v);
        make.top.mas_equalTo(self.companyName.mas_bottom);
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
        [MBProgressHUD showAutoMessage:@"请输入正确的手机号！"];
        return;
    }
    NSString *url=[NSString stringWithFormat:GETmembersMobileCheckcode,phone,1];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [FMRegExpTool startTime:self.veribut];
        }
    } failureBlock:^(NSError *error) {
        
    } progress:nil];
}


- (void)loadTheFunctionButton{
    self.selectBut = [[UIButton alloc] init];
    [self.view addSubview:self.selectBut];
    self.selectBut.selected = YES;
    [self.selectBut setImage:[UIImage imageNamed:@"notselect"] forState:UIControlStateNormal];
    [self.selectBut setImage:[UIImage imageNamed:@"select"] forState:UIControlStateSelected];
    [self.selectBut addTarget:self action:@selector(agreementSelecetBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.verificationCode.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(22), KFit_W6S(22)));
    }];
    UILabel *ts = [[UILabel alloc] init];
    ts.font = [UIFont systemFontOfSize:kFit_Font6(11)];
    ts.text = @"我已仔细阅读并遵守";
    [self.view addSubview:ts];
    [ts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(self.selectBut);
        make.left.mas_equalTo(self.selectBut.mas_right).mas_offset(KFit_W6S(10));
    }];
    
    
    
    UIButton *butone = [[UIButton alloc] init];
    [self.view addSubview:butone];
    butone.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(11)];
    [butone setTitleColor:kColor_N(0, 154, 201) forState:UIControlStateNormal];
    [butone setTitle:@"《淘电宝用户服务协议》" forState:UIControlStateNormal];
    [butone addTarget:self action:@selector(checkTheAgreement) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:@"《淘电宝用户服务协议》"];
    [tncString addAttribute:NSUnderlineStyleAttributeName
                      value:@(NSUnderlineStyleSingle)
                      range:(NSRange){0,[tncString length]}];
    //此时如果设置字体颜色要这样
    [tncString addAttribute:NSForegroundColorAttributeName value:kColor_N(0, 154, 201)  range:NSMakeRange(0,[tncString length])];
    
    //设置下划线颜色...
    [tncString addAttribute:NSUnderlineColorAttributeName value:kColor_N(0, 154, 201) range:(NSRange){0,[tncString length]}];
    [butone setAttributedTitle:tncString forState:UIControlStateNormal];
    
    [butone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ts.mas_right);
        make.width.mas_equalTo(KFit_W6S(250));
        make.centerY.height.mas_equalTo(ts);
    }];
    
    
    
    UIButton *registered=[[UIButton alloc]init];
    [self.view addSubview:registered];
    [registered setTitle:@"注册" forState:UIControlStateNormal];
    [registered setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    registered.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(18)];
    registered.layer.cornerRadius=5;
    registered.backgroundColor = kColor_N(40, 174, 104);
    [registered addTarget:self action:@selector(Registered) forControlEvents:UIControlEventTouchUpInside];
    [registered mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(50));
        make.top.mas_equalTo(ts.mas_bottom).mas_offset(45);
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    
}
- (void)agreementSelecetBut:(UIButton *)senter{
    senter.selected = !senter.selected;
}
- (void)backloging{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)Registered{
    [self.view endEditing:YES];
     NSString *pho = [self.pho.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *passwordo=self.password.text;
    NSString *passwordt=self.passwordtwo.text;
    NSString *yzm=self.verificationCode.text;
    NSString *name = self.companyName.text;
    if( pho.length < 1 )
    {
        
        [MBProgressHUD showAutoMessage:@"请输入手机号！"];
        return;
    }
    if( yzm.length < 1 )
    {
        
        [MBProgressHUD showAutoMessage:@"请输入验证码！"];
        return;
    }
    if( ![FMRegExpTool fm_checkingMobile:pho] )
    {
        [MBProgressHUD showAutoMessage:@"请输入正确的手机号！"];
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
    if (name.length < 1) {
        [MBProgressHUD showAutoMessage:@"请输入公司名"];
        return;
    }
    
    NSString *url=[NSString stringWithFormat:GETRegistered,pho,name,passwordo,yzm];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@", responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showAutoMessage:@"注册成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
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


- (void)checkTheAgreement{
    HWebVc *vc= [[HWebVc alloc] init];
    vc.title = @"淘电宝信息服务协议";
    vc.url = HTMLTDBAPPUserAgreement;
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
