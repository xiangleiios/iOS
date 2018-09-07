//
//  AddInformationOneVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddInformationOneVC.h"
#import "FormsV.h"
#import "AddInformationTwoVC.h"
#import "AVCaptureViewController.h"
#import "IDInfo.h"
@interface AddInformationOneVC ()<AVCaptureViewControllerDelegate>
@property (nonatomic , strong)FormsV *SFZforms;
@property (nonatomic , strong)NSMutableDictionary *studentDic;
@end

@implementation AddInformationOneVC


- (NSMutableDictionary *)studentDic{
    if (_studentDic == nil) {
        _studentDic = [NSMutableDictionary dictionary];
    }
    return _studentDic;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self laodNavigation];
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setTitle:@"填写资料"];
    
}

- (void)loadSubview{
    UIView *v = [[UIView alloc] init];
    [self.view addSubview:v];
    v.backgroundColor = kColor_N(240, 240, 240);
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(320));
    }];
    
    UIView *backView = [[UIView alloc] init];
    [v addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v).mas_offset(KFit_H6S(40));
        make.bottom.mas_equalTo(v).mas_offset(-KFit_H6S(40));
        make.left.mas_equalTo(v).mas_offset(KFit_H6S(50));
        make.right.mas_equalTo(v).mas_offset(-KFit_H6S(50));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [backView addSubview:but];
    [but setImage:[UIImage imageNamed:@"card_nor"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(IdentificationCrdZM) forControlEvents:UIControlEventTouchUpInside];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backView);
        make.left.mas_equalTo(backView).mas_offset(KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(250), KFit_H6S(160)));
    }];
    
    UILabel *lbone = [[UILabel alloc] init];
    [backView addSubview:lbone];
    lbone.text = @"点击读取身份证信息";
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(but.mas_right).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(backView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(backView).mas_offset(-KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    [backView addSubview:lbtwo];
    lbtwo.text = @"身份证正面";
    lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    lbtwo.textColor = kColor_N(64, 75, 105);
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(but.mas_right).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(backView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(backView).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.SFZforms = [[FormsV alloc] init];
    [self.view addSubview:self.SFZforms];
    [self.SFZforms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(v.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(540));
    }];
    
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(nextVC:) forControlEvents:UIControlEventTouchUpInside];
//    next.backgroundColor = kColor_N(0, 112, 234);
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
- (void)IdentificationCrdZM{
    AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
    AVCaptureVC.delegate = self;
    [self.navigationController pushViewController:AVCaptureVC animated:YES];
}

- (void)cardInformationScanning:(IDInfo *)info{
    self.SFZforms.name.subfield.text = info.name;
    self.SFZforms.gender.subfield.text = info.gender;
    self.SFZforms.ethnic.subfield.text = info.nation;
    self.SFZforms.address.subfield.text = info.address;
    self.SFZforms.IdNumber.subfield.text = info.num;
    self.SFZforms.birthday.subfield.text = [self birthdayStrFromIdentityCard:info.num];
}




- (void)nextVC:(UIButton *)sender{
    if (self.SFZforms.name.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请填写姓名"];
        return;
    }
    if (self.SFZforms.gender.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择性别"];
        return;
    }
    if (self.SFZforms.ethnic.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择民族"];
        return;
    }
    if (self.SFZforms.birthday.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择出生年月日"];
        return;
    }
    if (self.SFZforms.address.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请填写住址"];
        return;
    }
    if (self.SFZforms.IdNumber.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请填写身份证号码"];
        return;
    }
    [self.studentDic setValue:self.SFZforms.name.subfield.text forKey:@"studentName"];
    [self.studentDic setValue:[NSString stringWithFormat:@"%ld",(long)self.SFZforms.gender.subfield.tag] forKey:@"sex"];
    [self.studentDic setValue:[NSString stringWithFormat:@"%ld",(long)self.SFZforms.ethnic.subfield.tag] forKey:@"nation"];
    
    
    
//    [XLCommonUse dateConversionTimeStamp:self.SFZforms.birthday.subfield.text]
    [self.studentDic setValue:[XLCommonUse dateConversionTimeStamp:self.SFZforms.birthday.subfield.text] forKey:@"birthday"];
    [self.studentDic setValue:self.SFZforms.address.subfield.text forKey:@"idcardAddress"];
    [self.studentDic setValue:self.SFZforms.IdNumber.subfield.text forKey:@"idcard"];
    
    
    KKLog(@"%@",_studentDic);
    
    AddInformationTwoVC *vc = [[AddInformationTwoVC alloc] init];
    vc.studentDic = self.studentDic;
    [self.navigationController pushViewController:vc animated:YES];
}


- (NSString *)birthdayStrFromIdentityCard:(NSString *)numberStr{
    
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    
    NSString *year = nil;
    
    NSString *month = nil;
    
    
    BOOL isAllNumber = YES;
    
    NSString *day = nil;
    
    if([numberStr length]<14)
        
        return result;
    
    if (numberStr.length == 18) {
        
        //**截取前14位
        
        NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 13)];
        
        
        
        //**检测前14位否全都是数字;
        
        const char *str = [fontNumer UTF8String];
        
        const char *p = str;
        
        while (*p!='\0') {
            
            if(!(*p>='0'&&*p<='9'))
                
                isAllNumber = NO;
            
            p++;
            
        }
        
        
        
        if(!isAllNumber)
            
            return result;
        
        
        
        year = [numberStr substringWithRange:NSMakeRange(6, 4)];
        
        month = [numberStr substringWithRange:NSMakeRange(10, 2)];
        
        day = [numberStr substringWithRange:NSMakeRange(12,2)];
        
        
        
        [result appendString:year];
        
        [result appendString:@"-"];
        
        [result appendString:month];
        
        [result appendString:@"-"];
        
        [result appendString:day];
        
        return result;
        
        
    }else{
        
        NSString *fontNumer = [numberStr substringWithRange:NSMakeRange(0, 11)];
        
        
        
        //**检测前14位否全都是数字;
        
        const char *str = [fontNumer UTF8String];
        
        const char *p = str;
        
        while (*p!='\0') {
            
            if(!(*p>='0'&&*p<='9'))
                
                isAllNumber = NO;
            
            p++;
            
        }
        
        
        
        if(!isAllNumber)
            
            return result;
        
        
        
        year = [numberStr substringWithRange:NSMakeRange(6, 2)];
        
        month = [numberStr substringWithRange:NSMakeRange(8, 2)];
        
        day = [numberStr substringWithRange:NSMakeRange(10,2)];
        
        
        
        //        [result appendString:year];
        
        //        [result appendString:@"-"];
        
        //        [result appendString:month];
        
        //        [result appendString:@"-"];
        
        //        [result appendString:day];
        
        NSString* resultAll = [NSString stringWithFormat:@"19%@-%@-%@",year,month,day];
        
        return resultAll;
        
        
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
