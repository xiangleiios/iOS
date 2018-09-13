//
//  StudentDetailsEditorVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/27.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "StudentDetailsEditorVC.h"
#import "XLInformationV.h"
#import "FormsV.h"
#import "CGXPickerView.h"
#import "XLCache.h"
#import "AVCaptureViewController.h"
#import "JQAVCaptureViewController.h"
#import "IDInfo.h"
@interface StudentDetailsEditorVC ()<AVCaptureViewControllerDelegate,JQAVCaptureViewControllerDelegate>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;

@property (nonatomic , strong)FormsV *SFZforms;
@property (nonatomic , strong)SignUpTwoFormsV *signUpTwo;
@property (nonatomic , strong)XLInformationV *start_time;
@property (nonatomic , strong)XLInformationV *end_time;
@property (nonatomic , strong)OtherFormsV *otherForms;
@property (nonatomic , strong)NSMutableDictionary *studentDic;
@end

@implementation StudentDetailsEditorVC

- (NSMutableDictionary *)studentDic{
    if (_studentDic == nil) {
        _studentDic = [NSMutableDictionary dictionary];
    }
    return _studentDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"学员详情"];
    
    [self laodScroll];
    
    [self loadDataview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)laodScroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
    
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.scroll.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.backview = [[XLView alloc] init];
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backview.backgroundColor = [UIColor whiteColor];
    [self.scroll addSubview:self.backview];
    
    
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    //1 报名到总校，2、未报名到总校
    if ([_model.signupState  isEqual: @"1"]) {
        [next setTitle:@"保存并提交" forState:UIControlStateNormal];
    }else{
        [next setTitle:@"保存" forState:UIControlStateNormal];
    }
    
    [next addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    [next setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [next setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    next.layer.cornerRadius = 5;
    next.layer.masksToBounds = YES;
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(70));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(70));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
}
#pragma mark - 保存修改信息
- (void)nextVC{
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
    
    if (self.start_time.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择有效期开始时间"];
        return;
    }
    if (self.end_time.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择有效期结束时间"];
        return;
    }
    
    if (self.signUpTwo.phone.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请填写手机号"];
        return;
    }
    if (self.signUpTwo.carType.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择车型"];
        return;
    }
    if (self.signUpTwo.school.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择驾校"];
        return;
    }
    if (self.signUpTwo.type.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择申请类型"];
        return;
    }
    if (self.signUpTwo.hukou.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择本/外地户口"];
        return;
    }
    if (self.otherForms.state.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请选择报考状态"];
        return;
    }
    
    
    [self.studentDic setObject:self.signUpTwo.phone.subfield.text forKey:@"studentPhone"];
    [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.signUpTwo.carType.subfield.tag] forKey:@"carType"];
    [self.studentDic setObject:self.signUpTwo.price.subfield.text forKey:@"signupPrice"];
    [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.signUpTwo.school.subfield.tag] forKey:@"teamCode"];
    [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.signUpTwo.type.subfield.tag] forKey:@"applicationType"];
    [self.studentDic setObject:self.otherForms.referees.subfield.text forKey:@"recommender"];
    [self.studentDic setObject:self.otherForms.note.subfield.text forKey:@"remark"];
    [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.otherForms.state.subfield.tag] forKey:@"isPay"];
    
    
    
    [self.studentDic setObject:[XLCommonUse dateConversionTimeStamp:self.start_time.subfield.text] forKey:@"idcardStartDate"];
    [self.studentDic setObject:self.end_time.subfield.text forKey:@"idcardEndDate"];
    
    [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.signUpTwo.hukou.subfield.tag] forKey:@"enterType"];
    
    
    
    
    
    
    
    [self.studentDic setValue:self.SFZforms.name.subfield.text forKey:@"studentName"];
    [self.studentDic setValue:[NSString stringWithFormat:@"%ld",(long)self.SFZforms.gender.subfield.tag] forKey:@"sex"];
    [self.studentDic setValue:[NSString stringWithFormat:@"%ld",(long)self.SFZforms.ethnic.subfield.tag] forKey:@"nation"];
    
    
    [self.studentDic setValue:[XLCommonUse dateConversionTimeStamp:self.SFZforms.birthday.subfield.text] forKey:@"birthday"];
    [self.studentDic setValue:self.SFZforms.address.subfield.text forKey:@"idcardAddress"];
    [self.studentDic setValue:self.SFZforms.IdNumber.subfield.text forKey:@"idcard"];
    [self.studentDic setValue:self.model.idid forKey:@"id"];
    KKLog(@"%@",self.studentDic);
    NSString *url;
    if (self.PayCost) {
        url = POSTUpdateStudent;
    }else{
        url = POSTStudenteamEdit;
    }
    [MBProgressHUD showLoadingHUD:@"正在保存"];
    [FMNetworkHelper fm_setValue:[User UserOb].token forHTTPHeaderKey:@"token"];
    [FMNetworkHelper fm_setValue:@"Mobile" forHTTPHeaderKey:@"loginType"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:self.studentDic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if ([responseObject[@"code"] integerValue] == 200) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"修改成功" SuccessOrFailure:YES];
            [alert showPrompt];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
        KKLog(@"%@",responseObject);
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        [MBProgressHUD hideLoadingHUD];
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
    
    
}


- (void)loadDataview{
//    UIView *v = [[UIView alloc] init];
//    [self.backview addSubview:v];
//    [v mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(self.backview);
//        make.height.mas_equalTo(KFit_H6S(450));
//    }];
    
    XLInformationV *lbback = [[XLInformationV alloc] informationWithTitle:@"身份证正面信息"];
    [self.backview addSubview:lbback];
    [lbback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    UIButton *shibieZM = [[UIButton alloc] init];
    [lbback addSubview:shibieZM];
    [shibieZM setTitle:@"拍照识别" forState:UIControlStateNormal];
    [shibieZM setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    shibieZM.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    shibieZM.imageEdgeInsets = UIEdgeInsetsMake(0, KFit_W6S(140), 0, 0);
    shibieZM.titleEdgeInsets = UIEdgeInsetsMake(0, -KFit_W6S(80), 0, 0);
    [shibieZM setTitleColor:kColor_N(120, 126, 125) forState:UIControlStateNormal];
    [shibieZM addTarget:self action:@selector(paizhaoZM) forControlEvents:UIControlEventTouchUpInside];
    [shibieZM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(180), KFit_H6S(40)));
        make.bottom.mas_equalTo(lbback).mas_offset(-KFit_H6S(18));
    }];
    
    self.SFZforms = [[FormsV alloc] init];
    [self.backview addSubview:self.SFZforms];
    [self.SFZforms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(lbback.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(540));
    }];
    
    
    XLCache *cache = [XLCache singleton];
    [cache.sys_user_sex_value indexOfObject:_model.sex];
    self.SFZforms.name.subfield.text = _model.studentName;
    self.SFZforms.gender.subfield.text = cache.sys_user_sex_title[[cache.sys_user_sex_value indexOfObject:_model.sex]];
    self.SFZforms.gender.subfield.tag = [_model.sex integerValue];
    self.SFZforms.ethnic.subfield.text = cache.ethnicTitleArr[[cache.ethnicValueArr indexOfObject:_model.nation]];
    self.SFZforms.ethnic.subfield.tag = [_model.nation integerValue];
    self.SFZforms.birthday.subfield.text = [XLCommonUse datetimestampToString:_model.birthday];
    self.SFZforms.address.subfield.text = _model.idcardAddress;
    self.SFZforms.IdNumber.subfield.text = _model.idcard;
    
    
    XLInformationV *lbbacktwo = [[XLInformationV alloc] informationWithTitle:@"身份证反面信息"];
    [self.backview addSubview:lbbacktwo];
    [lbbacktwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(self.SFZforms.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    
    UIButton *shibieFM = [[UIButton alloc] init];
    [lbbacktwo addSubview:shibieFM];
    [shibieFM setTitle:@"拍照识别" forState:UIControlStateNormal];
    [shibieFM setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
    shibieFM.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    shibieFM.imageEdgeInsets = UIEdgeInsetsMake(0, KFit_W6S(140), 0, 0);
    shibieFM.titleEdgeInsets = UIEdgeInsetsMake(0, -KFit_W6S(80), 0, 0);
    [shibieFM setTitleColor:kColor_N(120, 126, 125) forState:UIControlStateNormal];
    [shibieFM addTarget:self action:@selector(paizhaoFM) forControlEvents:UIControlEventTouchUpInside];
    [shibieFM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(180), KFit_H6S(40)));
        make.bottom.mas_equalTo(lbbacktwo).mas_offset(-KFit_H6S(18));
    }];
    
    kWeakSelf(self)
    self.start_time = [[XLInformationV alloc] informationWithTitle:@"有效期起始" SubTitle:@"" TSSubTitle:@"请选择日期" Must:YES Click:YES];
    self.start_time.subfield.text = [XLCommonUse datetimestampToString:_model.idcardStartDate];
    self.start_time.senterBlock = ^{
        [CGXPickerView showDatePickerWithTitle:@"有效期起始" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            weakself.start_time.subfield.text = selectValue;
        }];
    };
    self.end_time = [[XLInformationV alloc] informationWithTitle:@"有效期结束" SubTitle:@"" TSSubTitle:@"请选择日期" Must:YES Click:YES];
    self.end_time.subfield.text = _model.idcardEndDate;
    self.end_time.senterBlock = ^{
        [CGXPickerView showDatePickerWithTitle:@"有效期结束" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            weakself.end_time.subfield.text = selectValue;
        }];
    };
    [self.backview addSubview:self.start_time];
    [self.backview addSubview:self.end_time];
    [self.start_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(lbbacktwo.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    [self.end_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(self.start_time.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    
    XLInformationV *lbbackthree = [[XLInformationV alloc] informationWithTitle:@"报名信息"];
    [self.backview addSubview:lbbackthree];
    [lbbackthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(self.end_time.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.signUpTwo = [[SignUpTwoFormsV alloc] init];
    [self.backview addSubview:self.signUpTwo];
    [self.signUpTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(lbbackthree.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(540));
    }];
    
    self.signUpTwo.phone.subfield.text = _model.studentPhone;
    self.signUpTwo.hukou.subfield.text = cache.student_is_enter_type_title[[cache.student_is_enter_type_value indexOfObject:_model.enterType]];
    self.signUpTwo.hukou.subfield.tag = [_model.enterType integerValue];
    
    self.signUpTwo.carType.subfield.text = cache.student_license_type_title[[cache.student_license_type_value indexOfObject:_model.carType]];
    self.signUpTwo.carType.subfield.tag = [_model.carType integerValue];
    
    self.signUpTwo.price.subfield.text = _model.signupPrice;
    self.signUpTwo.school.subfield.text = cache.teamCode_title[[cache.teamCode_value indexOfObject:_model.teamCode]];
    self.signUpTwo.school.subfield.tag = [_model.teamCode integerValue];
    
    self.signUpTwo.type.subfield.text = cache.student_apply_type_title[[cache.student_apply_type_value indexOfObject:_model.applicationType]];
    self.signUpTwo.type.subfield.tag = [_model.applicationType integerValue];
    XLInformationV *baokao = [[XLInformationV alloc] informationWithTitle:@"请填写其他信息"];
    [self.backview addSubview:baokao];
    [baokao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.signUpTwo.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.otherForms = [[OtherFormsV alloc] init];
    [self.backview addSubview:self.otherForms];
    [self.otherForms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(baokao.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(270));
    }];
    self.otherForms.referees.subfield.text = _model.recommender;
    self.otherForms.note.subfield.text =_model.remark;
    ///1:未缴费 2：已缴费
    if ([_model.isPay  isEqual: @"1"]) {
        self.otherForms.state.subfield.text = @"未收费";
        self.otherForms.state.subfield.tag = 1;
    }else{
        self.otherForms.state.subfield.text = @"已收费";
        self.otherForms.state.subfield.tag = 2;
    }
    
    
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
}


- (void)setModel:(FMMainModel *)model{
    _model = model;
    
    
}

- (void)paizhaoZM{
    AVCaptureViewController *AVCaptureVC = [[AVCaptureViewController alloc] init];
    AVCaptureVC.delegate = self;
    [self.navigationController pushViewController:AVCaptureVC animated:YES];
}

- (void)cardInformationScanning:(IDInfo *)info{
    XLCache *cache = [XLCache singleton];
    self.SFZforms.name.subfield.text = info.name;
    
    self.SFZforms.gender.subfield.text = info.gender;
    self.SFZforms.gender.subfield.tag = [cache.sys_user_sex_value[[cache.sys_user_sex_title indexOfObject:info.gender]] integerValue];
    
    NSString *ethnic = [NSString stringWithFormat:@"%@族",info.nation];
    self.SFZforms.ethnic.subfield.text = ethnic;
    self.SFZforms.ethnic.subfield.tag = [cache.ethnicValueArr [[cache.ethnicTitleArr indexOfObject:ethnic]] integerValue];
    self.SFZforms.address.subfield.text = info.address;
    self.SFZforms.IdNumber.subfield.text = info.num;
    self.SFZforms.birthday.subfield.text = [self birthdayStrFromIdentityCard:info.num];
}
-(void)paizhaoFM{
    JQAVCaptureViewController *AVCaptureVC = [[JQAVCaptureViewController alloc] init];
    AVCaptureVC.delegate = self;
    [self.navigationController pushViewController:AVCaptureVC animated:YES];
}


- (void)cardInformationScanningFM:(IDInfo *)info{
    NSArray *arr = [info.valid componentsSeparatedByString:@"-"];
    if (arr.count == 2) {
        NSString *stat = [arr firstObject];
        if (stat.length == 8) {
            NSString * year = [[arr firstObject] substringWithRange:NSMakeRange(0, 4)];
            NSString * month = [[arr firstObject] substringWithRange:NSMakeRange(4, 2)];
            NSString * day = [[arr firstObject] substringWithRange:NSMakeRange(6,2)];
            NSString *y = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            self.start_time.subfield.text = y;
        }
        NSString *end = [arr lastObject];
        if (end.length == 8) {
            NSString * year = [end substringWithRange:NSMakeRange(0, 4)];
            NSString * month = [end substringWithRange:NSMakeRange(4, 2)];
            NSString * day = [end substringWithRange:NSMakeRange(6,2)];
            NSString *y = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            self.end_time.subfield.text = y;
        }
        
    }
    //    self.start_time.subfield.text = info.
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
