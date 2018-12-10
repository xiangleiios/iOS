//
//  LoginVC.m
//  MobileProject
//
//  Created by zsgy on 17/8/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "LoginVC.h"
#import "XLPartyLoginV.h"
#import "ForgotPasswordVC.h"
#import "UIWebView+FMSetTonkenToCookie.h"
#import "XLCache.h"
#import "CYLTabBarControllerConfig.h"
#import "JPUSHService.h"
#import "SelectSchoolVC.h"
@interface LoginVC ()<UITextFieldDelegate>
@property (nonatomic , strong)TKPhoneTextField *pho;
@property (nonatomic , strong)UITextField *password;
@property (nonatomic , strong)UIImageView *logimg;
@property (nonatomic , strong)UIButton *veribut;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@""];
    self.view.backgroundColor=[UIColor whiteColor];

    
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
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(130));
        make.centerX.mas_equalTo(self.view);
        make.height.width.mas_equalTo(KFit_W6S(200));
    }];
    [img setImage:[UIImage imageNamed:@"logo_icon"]];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(img);
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(50));
        make.width.mas_equalTo(KFit_W6S(250));
    }];
    lb.backgroundColor = kColor_N(239, 246, 255);
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = kColor_N(15, 123, 236);
    lb.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    if (self.type) {
        lb.text = @"角色-负责人";
    }else{
        lb.text = @"角色-教练";
    }
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
    self.pho=[[TKPhoneTextField alloc]initWithFrame:CGRectMake(0, 0, KFit_W6S(550), KFit_H6S(110))];
    self.pho.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.pho];
    self.pho.placeholder=@"请输入账号";
    self.pho.keyboardType=UIKeyboardTypeNumberPad;
    self.pho.delegate =self;
    
//    UIImageView *imgpass=[[UIImageView alloc]initWithFrame:CGRectMake(0, KFit_H6S(140), KFit_W6S(32), KFit_H6S(45))];
//    [imgpass setImage:[UIImage imageNamed:@"password"]];
//    [v addSubview:imgpass];
    self.password=[[UITextField alloc]initWithFrame:CGRectMake(0, KFit_H6S(110), KFit_W6S(550), KFit_H6S(110))];
    self.password.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.password];
    self.password.placeholder=@"请输入密码";
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
    
    //15658458745   18810395609  13154898589  15512341234  15007125433  17764076879 13100704044 13100704044
#ifdef DEBUG
    self.pho.text = @"13100704044";
    self.password.text = @"123456";
#else
    
#endif
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    self.pho.text = [defaults objectForKey:@"Loginaccount"];
    
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
    if( phone.length != 11 )
    {
        [MBProgressHUD showAutoMessage:@"请输入正确的手机号！"];
        return;
    }
    if (password.length<1) {
        [MBProgressHUD showAutoMessage:@"请输入密码！"];
        return;
    }
    
    
    //    appDelegate.tab = TabBarControllerConfig
    
    NSString *url;
    if (self.type == 0) {
        // 教练
        url=[NSString stringWithFormat:GETCoachmembersLogin,phone,password];
    }else{

        url=[NSString stringWithFormat:GETTeammembersLogin,phone,password];
    }
    [MBProgressHUD showLoadingHUD:@"正在登陆"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        [MBProgressHUD hideLoadingHUD];
        if ([responseObject[@"code"] integerValue] == 200) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"登录成功" SuccessOrFailure:YES];
            XLSingleton *sing = [XLSingleton singleton];
            [sing.dateArr removeAllObjects];
            [sing.practiceArr removeAllObjects];
            [sing.timeArr removeAllObjects];
            [sing.courseArr removeAllObjects];
            [alert showPrompt];
            [XLSingleton singleton].scanPhotoIp =responseObject[@"urliIp"];
            User *user=[User UserOb];
            
            user.type = [NSString stringWithFormat:@"%ld",(long)self.type];
            user.accounttype=[NSNumber numberWithInteger:accountTypePhone];
            [user UserSave:responseObject];
//            [[XLCache singleton] cacheWhitValue:responseObject[@"schoolList"] AndKey:SchoolList];
//            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.pho.text forKey:@"Loginaccount"];
            [defaults setObject:responseObject[@"schoolList"] forKey:SchoolList];
            [defaults synchronize];
            [UIWebView fm_setTokenToUIWebViewCookie]; //存token到域名cookie
            [self laodCacheData];
            NSArray *arr = responseObject[@"schoolList"];
            if (arr.count < 1) {
                SelectSchoolVC *vc = [[SelectSchoolVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                CYLTabBarControllerConfig * TabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
                AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                appDelegate.tab = TabBarControllerConfig;
                appDelegate.window.rootViewController = TabBarControllerConfig.tabBarController;
                [self networkDidLogin];
            }
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingHUD];
        KKLog(@"error :%@",error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];

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
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject){
        if ([responseObject[@"code"] integerValue] == 200) {
            //把信息存起来
            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:[responseObject[@"data"] mj_JSONString] forKey:@"AllData"];
            [defaults synchronize];
            
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)networkDidLogin{
    
    User* bean = [User UserOb];
    if (bean.UserLogin) {
//        NSSet *set=[[NSSet alloc] initWithObjects:[NSString stringWithFormat:@"%@",bean.type], nil];
        NSString *str1=[NSString stringWithFormat:@"%@",bean.mobile];
        [JPUSHService setAlias:str1 completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            KKLog(@"rescode: %d,  \nalias: %@\n  seq:%d", iResCode, iAlias ,seq);
        } seq:1];
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
