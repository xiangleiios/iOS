//
//  MyProfileVC.m
//  MobileProject
//
//  Created by zsgy on 17/8/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "MyProfileVC.h"
#import "ChangePasswordVC.h"

@interface MyProfileVC ()
@property (nonatomic , strong)UIButton *phone;
@end

@implementation MyProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的资料";
    self.view.backgroundColor=kRGBColor(239, 239, 246);
    [self loadsubview];
    // Do any additional setup after loading the view.
}

- (void)loadsubview{
    UIView *v=[[UIView alloc]init];
    v.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(25));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(25));
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(310));
    }];
    
    UIButton *pho=[[UIButton alloc]init];
    self.phone=pho;
    [pho setTitle:@"我的手机号" forState:UIControlStateNormal];
    [pho setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    pho.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    pho.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    UIButton *password=[[UIButton alloc]init];
    [password setTitle:@"修改密码" forState:UIControlStateNormal];
    [password setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    password.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    password.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [password addTarget:self action:@selector(changepassword) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nikename=[[UIButton alloc]init];
    [nikename setTitle:@"修改昵称" forState:UIControlStateNormal];
    [nikename setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [nikename addTarget:self action:@selector(promptedToChangeTheNickname) forControlEvents:UIControlEventTouchUpInside];
    nikename.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    nikename.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [v addSubview:pho];
    [v addSubview:password];
    [v addSubview:nikename];
    NSArray *arr=[NSArray arrayWithObjects:pho,password,nikename, nil];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:1.0 leadSpacing:0 tailSpacing:0];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_equalTo(v);
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(v).mas_offset(-KFit_W6S(30));
    }];
    
    UILabel *lb=[[UILabel alloc]init];
    [v addSubview:lb];
    lb.backgroundColor=kRGBColor(239, 239, 246);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(pho);
        make.top.mas_equalTo(pho.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lbt=[[UILabel alloc]init];
    [v addSubview:lbt];
    lbt.backgroundColor=kRGBColor(239, 239, 246);
    [lbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(pho);
        make.top.mas_equalTo(password.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    /* 手机号*/
    [self loadphoneLabel];
    
}

- (void)changepassword{
    ChangePasswordVC *vc=[[ChangePasswordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)loadphoneLabel{
    UILabel *lb=[[UILabel alloc]init];
    [self.phone addSubview:lb];
    lb.textColor=[UIColor lightGrayColor];
    lb.textAlignment=NSTextAlignmentRight;
    lb.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.phone).mas_offset(-KFit_W6S(20));
        make.top.mas_equalTo(self.phone).mas_offset(KFit_H6S(20));
        make.bottom.mas_equalTo(self.phone).mas_offset(-KFit_H6S(20));
        make.width.mas_equalTo(KFit_W6S(360));
    }];
    lb.text=[User UserOb].mobile;

}



#pragma mark -修改昵称
- (void)promptedToChangeTheNickname{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"昵称修改" message:@"请输入新的昵称" preferredStyle:UIAlertControllerStyleAlert];
    
    // 添加按钮
    __weak typeof(alert) weakAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        
        //        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSString *encodingString =[ [weakAlert.textFields.firstObject text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
        //        dic[@"nick_name"] = encodingString;
        //        NSString *ster = [[DataModule sharedInstance] getLoginedUserInfo].token;
        //        dic[@"token"] = ster;
        if ([weakAlert.textFields.firstObject text].length > 16) {
            //            [SVProgressHUD showErrorWithStatus:@"昵称仅限制16个字符以内"];
            [MBProgressHUD showAutoMessage:@"昵称仅限制16个字符以内"];
            [self presentViewController:alert animated:YES completion:nil];
            return ;
        }
        [self changeNickRequest:encodingString];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }]];
    
    
    // 添加文本框
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.textColor = [UIColor redColor];
        textField.placeholder = @"昵称支持中英文以及数字";
        [textField addTarget:self action:@selector(usernameDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    }];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)changeNickRequest:(NSString *)name{
    NSString *url=[NSString stringWithFormat:POSTChangeTheNickname,[User UserOb].token,name];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showAutoMessage:@"修改成功"];
            User *use=[User UserOb];
            use.nick_name=[name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:use.nick_name forKey:@"nick_name"];
            [defaults synchronize];
            [self.MyProvc theLoginStatusChange];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }    } failureBlock:^(NSError *error) {
        
    } progress:nil];
}


#pragma mark - 删除特殊字符

- (void)usernameDidChange:(UITextField *)username
{
    username.text = [self disable_emoji:username.text];
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'-/:;()¥&@\".,?!'[]{}#%^*+=_\\|~<>$£.,?!'\""];
    username.text = [username.text stringByTrimmingCharactersInSet:set];
}

- (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
