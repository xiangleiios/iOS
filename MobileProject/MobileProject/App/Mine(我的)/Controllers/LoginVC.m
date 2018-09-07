//
//  LoginVC.m
//  MobileProject
//
//  Created by zsgy on 17/8/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "LoginVC.h"
#import "XLPartyLoginV.h"
#import "RegisteredVC.h"
#import "ForgotPasswordVC.h"
#import "UIWebView+FMSetTonkenToCookie.h"
#import "MineWebVC.h"
#import "RegisteredVC.h"
#import "CYLTabBarControllerConfig.h"
#import "XLCache.h"
@interface LoginVC ()<UITextFieldDelegate>
@property (nonatomic , strong)TKPhoneTextField *pho;
@property (nonatomic , strong)UITextField *password;
@property (nonatomic , strong)UIImageView *logimg;
@property (nonatomic , strong)UIButton *veribut;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"手机快捷登录";
    self.view.backgroundColor=[UIColor whiteColor];
//    [self loadNavigation];
    
    /*图标*/
    [self loadingIcon];
    /* 账号密码*/
    [self loadTheLoginBox];
    /* 登录注册按钮*/
    [self loadTheFunctionButton];
    
    /*目前没有第三方登录 */
//    [self DSFlogin];
    // Do any additional setup after loading the view.
}

- (void)loadNavigation{
    kWeakSelf(self)
    [self.navigationView setTitle:@"登录淘电宝"];
    UIButton *rigutBut = [self.navigationView addRightButtonWithTitle:@"注册" clickCallBack:^(UIView *view) {
        RegisteredVC *vc = [[RegisteredVC alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    //是否开启 手势侧滑返回
    self.customBackGestureEnabel = YES ;
    //侧滑距离左边最大的距离,
    self.customBackGestureEdge = SCREEN_WIDTH / 2.0 ;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController fm_setStatusBarBackgroundColor:[UIColor clearColor]];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)loadingIcon{
    UIImageView *img=[[UIImageView alloc]init];
    self.logimg=img;
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(150));
        make.centerX.mas_equalTo(self.view);
        make.height.width.mas_equalTo(KFit_W6S(200));
    }];
    [img setImage:[UIImage imageNamed:@"logo_icon"]];
}


- (void)loadTheLoginBox{
    UIView *v=[[UIView alloc]init];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logimg.mas_bottom).mas_offset(KFit_H6S(180));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(70));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(70));
        make.height.mas_equalTo(KFit_H6S(220));
    }];
//    UIImageView *imgpho=[[UIImageView alloc]initWithFrame:CGRectMake(0, KFit_H6S(30), KFit_W6S(32), KFit_H6S(50))];
//    [imgpho setImage:[UIImage imageNamed:@"tel"]];
//    [v addSubview:imgpho];
    self.pho=[[TKPhoneTextField alloc]initWithFrame:CGRectMake(0, 0, KFit_W6S(350), KFit_H6S(110))];
    self.pho.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.pho];
    self.pho.placeholder=@"请输入账号";
    self.pho.keyboardType=UIKeyboardTypeNumberPad;
    self.pho.delegate =self;
    
//    UIImageView *imgpass=[[UIImageView alloc]initWithFrame:CGRectMake(0, KFit_H6S(140), KFit_W6S(32), KFit_H6S(45))];
//    [imgpass setImage:[UIImage imageNamed:@"password"]];
//    [v addSubview:imgpass];
    self.password=[[UITextField alloc]initWithFrame:CGRectMake(0, KFit_H6S(110), KFit_W6S(450), KFit_H6S(110))];
    self.password.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.password];
    self.password.placeholder=@"请输入密码（6-20位字母与数字组合）";
    self.password.secureTextEntry=YES;
    
    
    
//    self.veribut=[[UIButton alloc]init];
//    [v addSubview:self.veribut];
//    [self.veribut mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(v).mas_offset(-KFit_W6S(15));
//        make.centerY.mas_equalTo(self.password);
//        make.width.mas_equalTo(KFit_W6S(150));
//        make.height.mas_equalTo(KFit_H6S(54));
//    }];
//    [self.veribut setTitle:@"获取动态验证" forState:UIControlStateNormal];
//    [self.veribut setTitleColor:kRGBColor(251, 189, 44) forState:UIControlStateNormal];
//    [self.veribut addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
//    self.veribut.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(12)];
    
    
#ifdef DEBUG
    self.pho.text = @"18810395609";
    self.password.text = @"123456";
#else
    
#endif
    UILabel *lb=[[UILabel alloc]init];
    lb.backgroundColor=kRGBColor(239, 239, 246);
    [v addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerY.centerX.mas_equalTo(v);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lbt=[[UILabel alloc]init];
    lbt.backgroundColor=kRGBColor(239, 239, 246);
    [v addSubview:lbt];
    [lbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.bottom.mas_equalTo(v);
        make.height.mas_equalTo(1);
    }];
    
}

- (void)getVerificationCode{
    NSString* phone = [self.pho.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
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
    
    
    NSString *url=[NSString stringWithFormat:GETmembersMobileCheckcode,phone,0];
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




- (void)loadTheFunctionButton{
//    UIButton *registered=[[UIButton alloc]init];
//    [self.view addSubview:registered];
//    [registered setTitle:@"立即注册" forState:UIControlStateNormal];
//    [registered setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    registered.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(18)];
//    [registered addTarget:self action:@selector(Registered) forControlEvents:UIControlEventTouchUpInside];
//    UILabel *lb=[[UILabel alloc]init];
//    [self.view addSubview:lb];
//    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.top.mas_equalTo(self.password.mas_bottom).mas_offset(KFit_H6S(20));
//        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
//        make.height.mas_equalTo(KFit_H6S(30));
//        make.width.mas_equalTo(KFit_W6S(215));
//    }];
//    lb.font=[UIFont systemFontOfSize:kFit_Font6(13)];
//    lb.textColor=[UIColor lightGrayColor];
//    lb.text=@"登录即代表您同意";
//
//
//    UIButton *but=[[UIButton alloc]init];
//    [self.view addSubview:but];
//    [but mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.height.mas_equalTo(lb);
//        make.left.mas_equalTo(lb.mas_right);
//        make.width.mas_equalTo(KFit_W6S(280));
//    }];
//    [but setTitle:@"《文化南宁用户协议》" forState:UIControlStateNormal];
//    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    but.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(13)];
//    [but addTarget:self action:@selector(toProtocol) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *login=[[UIButton alloc]init];
    [self.view addSubview:login];
    login.backgroundColor=kRGBColor(0, 112, 234 );
    [login setTitle:@"确定" forState:UIControlStateNormal];
    login.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(18)];
    [login addTarget:self action:@selector(loging) forControlEvents:UIControlEventTouchUpInside];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.password.mas_bottom).mas_offset(KFit_H6S(50));
         make.height.mas_equalTo(KFit_H6S(90));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(KFit_W6S(670));
    }];
    login.layer.cornerRadius = 5;
    
    
    
//    UIButton *but = [[UIButton alloc] init];
//    [but setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [but setTitleColor:appcoloer forState:UIControlStateNormal];
//    but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(15)];
//    [but addTarget:self action:@selector(forgotpassword) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:but];
//    [but mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(login);
//        make.top.mas_equalTo(login.mas_bottom).mas_offset(20);
//        make.size.mas_equalTo(CGSizeMake(KFit_W6S(130), KFit_H6S(20)));
//    }];
//    NSArray *arr=[NSArray arrayWithObjects:registered,login, nil];
//    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:KFit_W6S(20)  leadSpacing:KFit_W6S(120) tailSpacing:KFit_W6S(120)];
//    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.password.mas_bottom).mas_offset(KFit_H6S(80));
//        make.height.mas_equalTo(KFit_H6S(80));
//    }];
    
    
//    registered.layer.cornerRadius=KFit_H6S(40);
//    registered.layer.borderWidth=0.5;
//    registered.layer.borderColor=[UIColor lightGrayColor].CGColor;
//
    
//    UIButton *forgot=[[UIButton alloc]init];
//    [self.view addSubview:forgot];
//    [forgot setTitle:@"忘记密码" forState:UIControlStateNormal];
//    [forgot setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    forgot.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(13)];
//    [forgot addTarget:self action:@selector(forgotpassword) forControlEvents:UIControlEventTouchUpInside];
//    [forgot mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(login.mas_bottom).mas_offset(KFit_H6S(25));
//        make.right.mas_equalTo(login).mas_offset(-KFit_W6S(30));
//        make.height.mas_equalTo(KFit_H6S(30));
//        make.width.mas_equalTo(KFit_W6S(120));
//    }];
    
}



- (void)toProtocol{
    MineWebVC *vc=[[MineWebVC alloc]init];
    vc.title=@"用户协议";
    vc.url=HTKLprotocol;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)loging{
    [self.view endEditing:YES];
    NSString *p = [self.pho.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* phone = [p stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* password=[self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
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
    if (password.length<1) {
        [MBProgressHUD showAutoMessage:@"请输入密码！"];
        return;
    }
    
    
    //    appDelegate.tab = TabBarControllerConfig
    NSString *url=[NSString stringWithFormat:GETmembersLogin,phone,password];

    MBProgressHUD *hud=[MBProgressHUD showMessage:@"正在登陆" ToView:self.view];

    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        [hud hide:YES];
        if ([responseObject[@"code"] integerValue] == 200) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"登录成功" SuccessOrFailure:YES];
            [alert showPrompt];
            User *user=[User UserOb];
            user.accounttype=[NSNumber numberWithInteger:accountTypePhone];
            [user UserSave:responseObject];
            [[XLCache singleton] cacheWhitValue:responseObject[@"schoolList"] AndKey:SchoolList];
            [UIWebView fm_setTokenToUIWebViewCookie]; //存token到域名cookie
            [self laodCacheData];
            CYLTabBarControllerConfig * TabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];            
            [self presentViewController:TabBarControllerConfig.tabBarController animated:YES completion:^{

            }];

        }else{
            
        }
    } failureBlock:^(NSError *error) {
        [hud hide:YES];
        KKLog(@"error :%@",error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];

}


- (void)Registered{
    RegisteredVC *vc=[[RegisteredVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)DSFlogin{
    XLPartyLoginV *v=[[XLPartyLoginV alloc]initWithFrame:CGRectMake(0, KFit_H6S(780), kScreenW, KFit_H6S(200))];
    v.vc=self;
    [self.view addSubview:v];
}

- (void)forgotpassword{
    ForgotPasswordVC *vc=[[ForgotPasswordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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


#pragma mark -登录成功之后去获取各种缓存数据

- (void)laodCacheData{
    NSString *url = POSTAppDictList;
    [FMNetworkHelper fm_setValue:[User UserOb].token forHTTPHeaderKey:@"token"];
    [FMNetworkHelper fm_setValue:@"Mobile" forHTTPHeaderKey:@"loginType"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject){
        if ([responseObject[@"code"] integerValue] == 200) {
            [[XLCache singleton] cacheWhitValue:responseObject[@"data"] AndKey:ALLDATA];
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

@end
