//
//  AddInformationThreeVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddInformationThreeVC.h"
#import "FormsV.h"
#import "XLInformationV.h"
@interface AddInformationThreeVC ()
@property (nonatomic , strong)SignUpFormsV *signUpForms;
@property (nonatomic , strong)OtherFormsV *otherForms;
@end

@implementation AddInformationThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self laodNavigation];
    [self laodSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)laodNavigation{
    [self.navigationView setTitle:@"填写资料"];
}

- (void)laodSubview{
    XLInformationV *baokao = [[XLInformationV alloc] informationWithTitle:@"请填写报考信息"];
    [self.view addSubview:baokao];
    [baokao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.signUpForms = [[SignUpFormsV alloc] init];
    [self.view addSubview:self.signUpForms];
    [self.signUpForms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(baokao.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(360));
    }]; 
    
    XLInformationV *qita = [[XLInformationV alloc] informationWithTitle:@"请填写其他信息"];
    [self.view addSubview:qita];
    [qita mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.signUpForms.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.otherForms = [[OtherFormsV alloc] init];
    [self.view addSubview:self.otherForms];
    [self.otherForms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(qita.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(180));
    }];
    
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    [next setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [next setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    next.layer.cornerRadius = 5;
    next.layer.masksToBounds = YES;
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(70));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(70));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(40));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
}

- (void)nextVC{
    if (self.signUpForms.carType.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择车型"];
        return;
    }
    if (self.signUpForms.school.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择驾校"];
        return;
    }
    if (self.signUpForms.type.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择申请类型"];
        return;
    }
//    if (self.otherForms.state.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请选择收费状态"];
//        return;
//    }

//    [self.studentDic setObject:self.signUpForms.phone.subfield.text forKey:@"studentPhone"];
    [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.signUpForms.carType.subfield.tag] forKey:@"carType"];
//    [self.studentDic setObject:self.signUpForms.price.subfield.text forKey:@"signupPrice"];
    [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.signUpForms.school.subfield.tag] forKey:@"teamCode"];
    [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.signUpForms.type.subfield.tag] forKey:@"applicationType"];
    [self.studentDic setObject:self.otherForms.referees.subfield.text forKey:@"recommender"];
    [self.studentDic setObject:self.otherForms.note.subfield.text forKey:@"remark"];
//    [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.otherForms.state.subfield.tag] forKey:@"isPay"];
    
    
    KKLog(@"%@",self.studentDic);
    NSString *url = POSTStudenteamAdd;
    [MBProgressHUD showLoadingHUD:@"正在提交"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:self.studentDic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if ([responseObject[@"code"] integerValue] == 200) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"提交成功！在咨询学员中查看"];
            [alert showPrompt];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        [MBProgressHUD hideLoadingHUD];
        
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
