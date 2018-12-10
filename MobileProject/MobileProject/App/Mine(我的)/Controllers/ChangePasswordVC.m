//
//  ChangePasswordVC.m
//  MobileProject
//
//  Created by zsgy on 17/8/2.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "ChangePasswordVC.h"
#define viewHight KFit_H6S(110)
#define imgY KFit_H6S(30)
@interface ChangePasswordVC ()
@property (nonatomic , strong)UITextField *odlpassword;
@property (nonatomic , strong)UITextField *password;
@property (nonatomic , strong)UITextField *passwordtwo;
@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadNavigation];
    
//    self.view.backgroundColor=kRGBColor(239, 239, 246);
    [self loadsubview];
    [self loadfunctionbut];
    // Do any additional setup after loading the view.
}
- (void)loadNavigation{
    [self.navigationView setTitle:@"修改密码"];
    //是否开启 手势侧滑返回
    self.customBackGestureEnabel = YES ;
    //侧滑距离左边最大的距离,
    self.customBackGestureEdge = SCREEN_WIDTH / 2.0 ;
}

- (void)loadsubview{
    UIView *v=[[UIView alloc]init];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(60));
//        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(viewHight * 3);
    }];
    
    
//    UIImageView *imgpho=[[UIImageView alloc]initWithFrame:CGRectMake(0, imgY, KFit_W6S(32), KFit_H6S(45))];
//    [imgpho setImage:[UIImage imageNamed:@"password2"]];
//    [v addSubview:imgpho];
    self.odlpassword=[[UITextField alloc]initWithFrame:CGRectMake(KFit_W6S(30), 0, KFit_W6S(650), viewHight)];
    self.odlpassword.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.odlpassword];
    self.odlpassword.placeholder=@"请输入旧密码";
    self.odlpassword.keyboardType=UIKeyboardTypeNumberPad;
    self.odlpassword.secureTextEntry=YES;
    [self.odlpassword addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
//    UIImageView *imgCompany = [[UIImageView alloc]initWithFrame:CGRectMake(0, imgY + viewHight, KFit_W6S(32), KFit_H6S(45))];
//    [imgCompany setImage:[UIImage imageNamed:@"password"]];
//    [v addSubview:imgCompany];
    self.password=[[UITextField alloc]initWithFrame:CGRectMake(KFit_W6S(30), viewHight, KFit_W6S(650), viewHight)];
    self.password.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.password];
    self.password.placeholder=@"请输入包含数字和字母的新密码6-20位密码";
    self.password.secureTextEntry=YES;
    [self.password addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
//    UIImageView *imgpass=[[UIImageView alloc]initWithFrame:CGRectMake(0, imgY + viewHight *2, KFit_W6S(32), KFit_H6S(45))];
//    [imgpass setImage:[UIImage imageNamed:@"password2"]];
//    [v addSubview:imgpass];
    self.passwordtwo=[[UITextField alloc]initWithFrame:CGRectMake(KFit_W6S(30), viewHight * 2, KFit_W6S(650), viewHight)];
    self.passwordtwo.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.passwordtwo];
    self.passwordtwo.placeholder=@"请再次输入密码";
    self.passwordtwo.secureTextEntry=YES;
    [self.passwordtwo addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    UILabel *lb=[[UILabel alloc]init];
    lb.backgroundColor=kRGBColor(239, 239, 246);
    [v addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.left.mas_equalTo(v);
        make.top.mas_equalTo(self.odlpassword.mas_bottom);
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
    
}


- (void)loadfunctionbut{
    UIButton *but=[[UIButton alloc]init];
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(650));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    but.layer.cornerRadius=5;
    but.backgroundColor = kColor_N(0, 112, 234);
    [but setTitle:@"修改密码" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
}


- (void)change{
    [self.view endEditing:YES];
    NSString* odl =self.odlpassword.text;
    NSString* passwordo=self.password.text;
    NSString *passwordt=self.passwordtwo.text;
    if( odl.length < 1)
    {
        
        [MBProgressHUD showAutoMessage:@"请输入密码"];
        return;
    }
    
    if( passwordo.length<1||passwordt.length<1)
    {
        
        [MBProgressHUD showAutoMessage:@"请输入新密码"];
        return;
    }
    
    
    if( odl.length < 6 ||passwordo.length<6||passwordt.length<6)
    {
        
        [MBProgressHUD showAutoMessage:@"密码不能小于6个字符"];
        return;
    }
    if( odl.length > 20 ||passwordo.length > 20||passwordt.length > 20)
    {
        
        [MBProgressHUD showAutoMessage:@"密码不能大于20个字符"];
        return;
    }
    if (![passwordo isEqualToString:passwordt]) {
        [MBProgressHUD showAutoMessage:@"两次密码输入不一致"];
        return;
    }
    
    NSString *url;
    
    if (USERFZR) {
        url=[NSString stringWithFormat:@"%@?userId=%@&password=%@&newPass=%@",POSTEditPwd,[User UserOb].userId,odl,passwordo];
    }else{
        url=[NSString stringWithFormat:@"%@?userId=%@&password=%@&newPass=%@",POSTEditPwdCoach,[User UserOb].userId,odl,passwordo];
    }
    
    [MBProgressHUD showLoadingHUD:@"正在修改"];
    
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"修改成功" SuccessOrFailure:YES];
            [alert showPrompt];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
        KKLog(@"%@",responseObject);
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingHUD];
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
//    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
//        [hud hide:YES];
//        if ([responseObject[@"status_code"] intValue]==200) {
//            [MBProgressHUD showAutoMessage:@"修改成功"];
//            [self.navigationController popViewControllerAnimated:YES];
//
//        }else{
//            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
//        }
//        KKLog(@"登录返回的成功信息--------->%@", responseObject);
//    } failureBlock:^(NSError *error) {
//        [hud hide:YES];
//
//    } progress:nil];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)textField{
    UITextRange *selectedRange = textField.markedTextRange;
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    if (!position) {
        // 没有高亮选择的字
        // 1. 过滤非汉字、字母、数字字符
        
        // 2. 截取
        if (textField.text.length >= 20) {
            textField.text = [textField.text substringToIndex:20];
            
        }
        
    } else {
        // 有高亮选择的字 不做任何操作
        
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
