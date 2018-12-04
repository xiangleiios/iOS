//
//  AddInformationVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/10.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddInformationVC.h"
#import "XLInformationV.h"
#import "CGXPickerView.h"
#import "FormsV.h"
#import "XLCache.h"
#import <AipOcrSdk/AipOcrSdk.h>
@interface AddInformationVC ()<UIAlertViewDelegate>
{
    // 默认的识别成功的回调
    void (^_successHandler)(id);
    // 默认的识别失败的回调
    void (^_failHandler)(NSError *);
}
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;

@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)XLInformationV *pho;

@property (nonatomic , strong)XLInformationV *start_time;
@property (nonatomic , strong)XLInformationV *end_time;
//@property (nonatomic , strong)XLInformationV *hukou;


@property (nonatomic , strong)FormsAddV *SFZforms;


@property (nonatomic , strong)SignUpFormsV *signUpForms;
@property (nonatomic , strong)OtherFormsV *otherForms;


@property (nonatomic , strong)NSMutableDictionary *studentDic;
@end

@implementation AddInformationVC

- (NSMutableDictionary *)studentDic{
    if (_studentDic == nil) {
        _studentDic = [NSMutableDictionary dictionary];
    }
    return _studentDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"填写个人信息"];
    [[AipOcrService shardService] authWithAK:@"iY6mYTyvN2Wn4GedChGMMSdf" andSK:@"HM6ZrPzN7ebTI1gcPOO0rEdsDQANrmkS"];
    [self laodScroll];
    [self loadsub];
    [self loadSaveBut];
    [self configCallback];
    // Do any additional setup after loading the view.
}
- (void)laodScroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
    
    self.backview = [[XLView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scroll addSubview:self.backview];
    

}

- (void)loadsub{
    XLInformationV *jiben = [[XLInformationV alloc] informationWithTitle:@"基本信息"];
    [self.backview addSubview:jiben];
    [jiben mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    self.name = [[XLInformationV alloc] informationWithTitle:@"姓名" SubTitle:@"" TSSubTitle:@"请填写真实姓名" Must:YES Click:NO];
    [self.backview addSubview:self.name];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(jiben.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    self.pho = [[XLInformationV alloc] informationWithTitle:@"手机号" SubTitle:@"" TSSubTitle:@"请填写真实手机号" Must:YES Click:NO];
    [self.backview addSubview:self.pho];
    [self.pho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.name.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [self.backview addSubview:but];
//    [but setTitle:@"请填写更多信息" forState:UIControlStateNormal];
    
    
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"请填写更多信息 >"];
    NSRange titleRange = {0,[title length]};
    [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
    [title addAttribute:NSForegroundColorAttributeName value:kColor_N(169, 174, 184)  range:NSMakeRange(0,[title length])];
    [title addAttribute:NSUnderlineColorAttributeName value:kColor_N(169, 174, 184) range:(NSRange){0,[title length]}];
    [but setAttributedTitle:title forState:UIControlStateNormal];
    [but.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [but setTitleColor:kColor_N(169, 174, 184) forState:UIControlStateNormal];
    [but addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.pho.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
}

- (void)show:(UIButton *)senter{
    senter.hidden = YES;
    [self loadAllInformationZM];
    [self loadAllInformationFM];
    [self loadAllInformationBK];
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
}


- (void)loadAllInformationZM{
    XLInformationV *SFZZM = [[XLInformationV alloc] informationWithTitle:@"身份证正面信息"];
    [self.backview addSubview:SFZZM];
    [SFZZM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.pho.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    UIView *v = [[UIView alloc] init];
    [self.backview addSubview:v];
    v.backgroundColor = [UIColor whiteColor];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(SFZZM.mas_bottom);
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
    [but addTarget:self action:@selector(paizhaoZM) forControlEvents:UIControlEventTouchUpInside];
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
    
    
    self.SFZforms = [[FormsAddV alloc] init];
    [self.backview addSubview:self.SFZforms];
    [self.SFZforms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(v.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(450));
    }];
    
}

- (void)loadAllInformationFM{
    XLInformationV *SFZFM = [[XLInformationV alloc] informationWithTitle:@"身份证反面信息"];
    [self.backview addSubview:SFZFM];
    [SFZFM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.SFZforms.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    UIView *v = [[UIView alloc] init];
    [self.backview addSubview:v];
    v.backgroundColor = [UIColor whiteColor];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(SFZFM.mas_bottom);
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
    [but addTarget:self action:@selector(paizhaoFM) forControlEvents:UIControlEventTouchUpInside];
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
    lbtwo.text = @"身份证反面";
    lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    lbtwo.textColor = kColor_N(64, 75, 105);
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(but.mas_right).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(backView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(backView).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UIView *inqutview = [[UIView alloc] init];
    [self.backview addSubview:inqutview];
    [inqutview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(180));
    }];
    
    kWeakSelf(self)
    self.start_time = [[XLInformationV alloc] informationWithTitle:@"有效期起始" SubTitle:@"" TSSubTitle:@"请选择日期" Must:YES Click:YES];
    self.start_time.senterBlock = ^{
        [weakself.view endEditing:YES];
        [CGXPickerView showDatePickerWithTitle:@"有效期起始" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            weakself.start_time.subfield.text = selectValue;
        }];
    };
    self.end_time = [[XLInformationV alloc] informationWithTitle:@"有效期结束" SubTitle:@"" TSSubTitle:@"请选择日期" Must:YES Click:YES];
    self.end_time.senterBlock = ^{
        [weakself.view endEditing:YES];
        [CGXPickerView showDatePickerWithTitle:@"有效期结束" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            weakself.end_time.subfield.text = selectValue;
        }];
    };
    self.start_time.red.textColor = [UIColor blackColor];
    self.end_time.red.textColor = [UIColor blackColor];
    [inqutview addSubview:self.start_time];
    [inqutview addSubview:self.end_time];

    
//    NSString *dizhi = self.studentDic[@"idcardAddress"];
//    if([dizhi rangeOfString:@"武汉"].location !=NSNotFound)//_roaldSearchText
//    {
//        NSLog(@"yes");
//        self.hukou.subfield.text = [[XLCache singleton].student_is_enter_type_title firstObject];
//        self.hukou.subfield.tag = [[[XLCache singleton].student_is_enter_type_value firstObject] integerValue];
//    }
//    else
//    {
//        NSLog(@"no");
//        self.hukou.subfield.text = [[XLCache singleton].student_is_enter_type_title lastObject];
//        self.hukou.subfield.tag = [[[XLCache singleton].student_is_enter_type_value lastObject] integerValue];
//    }
    
    
    NSArray *arr = @[self.start_time,self.end_time];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
    }];
}



- (void)loadAllInformationBK{
    XLInformationV *baokao = [[XLInformationV alloc] informationWithTitle:@"报考信息"];
    [self.backview addSubview:baokao];
    [baokao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.end_time.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.signUpForms = [[SignUpFormsV alloc] init];
    [self.backview addSubview:self.signUpForms];
    [self.signUpForms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(baokao.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(360));
    }];
    
    XLInformationV *qita = [[XLInformationV alloc] informationWithTitle:@"请填写其他信息"];
    [self.backview addSubview:qita];
    [qita mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.signUpForms.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.otherForms = [[OtherFormsV alloc] init];
    [self.backview addSubview:self.otherForms];
    [self.otherForms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(qita.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(180));
    }];
    
}

- (void)loadSaveBut{
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"保存" forState:UIControlStateNormal];
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


#pragma mark - 保存

- (void)nextVC{
//    if (self.signUpForms.carType.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请选择车型"];
//        return;
//    }
//    if (self.signUpForms.school.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请选择驾校"];
//        return;
//    }
//    if (self.signUpForms.type.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请选择申请类型"];
//        return;
//    }
//    if (self.start_time.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请选择有效期开始时间"];
//        return;
//    }
//    if (self.end_time.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请选择有效期结束时间"];
//        return;
//    }
//    if (self.signUpForms.hukou.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请选择本/外地户口"];
//        return;
//    }
//    if (![XLCommonUse compareOneDay:self.start_time.subfield.text withAnotherDay:self.end_time.subfield.text]) {
//        [MBProgressHUD showMsgHUD:@"有效期结束时间必须大于开始时间"];
//        return;
//    }
    if (self.name.subfield.text.length <= 0) {
        [MBProgressHUD showMsgHUD:@"请填写姓名"];
        return;
    }
    if (self.name.subfield.text.length >= 6) {
        [MBProgressHUD showMsgHUD:@"请填写正确的姓名"];
        return;
    }
//
//    if (self.SFZforms.gender.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请选择性别"];
//        return;
//    }
//    if (self.SFZforms.ethnic.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请选择民族"];
//        return;
//    }
//    if (self.SFZforms.birthday.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请选择出生年月日"];
//        return;
//    }
//    if (self.SFZforms.address.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请填写住址"];
//        return;
//    }
//    if (self.SFZforms.IdNumber.subfield.text.length <= 0) {
//        [MBProgressHUD showMsgHUD:@"请填写身份证号码"];
//        return;
//    }
//    if (![XLCommonUse checkUserID:self.SFZforms.IdNumber.subfield.text]) {
//        [MBProgressHUD showMsgHUD:@"请填写正确的身份证号码"];
//        return;
//    }
    if (self.pho.subfield.text.length <= 0) {
//        XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"请填写手机号"];
//        [alert showPrompt];
        [MBProgressHUD showMsgHUD:@"请填写手机号"];
        return;
    }
    if (self.pho.subfield.text.length != 11) {
//        XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"请填写正确的手机号"];
//        [alert showPrompt];
        [MBProgressHUD showMsgHUD:@"请填写正确的手机号"];
        return;
    }
    
    [self.studentDic setValue:self.name.subfield.text forKey:@"studentName"];
    
    if (self.SFZforms.gender.subfield.text.length > 0) {
        [self.studentDic setValue:[NSString stringWithFormat:@"%ld",(long)self.SFZforms.gender.subfield.tag] forKey:@"sex"];
    }
    
    if (self.SFZforms.ethnic.subfield.text.length > 0) {
        [self.studentDic setValue:[NSString stringWithFormat:@"%ld",(long)self.SFZforms.ethnic.subfield.tag] forKey:@"nation"];
    }
    
    if (self.SFZforms.birthday.subfield.text.length > 0) {
        [self.studentDic setValue:[XLCommonUse dateConversionTimeStamp:self.SFZforms.birthday.subfield.text] forKey:@"birthday"];
        
    }
    
    //    [XLCommonUse dateConversionTimeStamp:self.SFZforms.birthday.subfield.text]
    
    [self.studentDic setValue:self.SFZforms.address.subfield.text forKey:@"idcardAddress"];
    [self.studentDic setValue:self.SFZforms.IdNumber.subfield.text forKey:@"idcard"];
    
    if (self.start_time.subfield.text.length > 0) {
        [self.studentDic setObject:[XLCommonUse dateConversionTimeStamp:self.start_time.subfield.text] forKey:@"idcardStartDate"];
    }
    
    
    [self.studentDic setObject:self.end_time.subfield.text forKey:@"idcardEndDate"];
    
    if (self.signUpForms.hukou.subfield.text.length > 0) {
        [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.signUpForms.hukou.subfield.tag] forKey:@"enterType"];
        
    }
    
    [self.studentDic setObject:self.pho.subfield.text forKey:@"studentPhone"];
    
    if (self.signUpForms.carType.subfield.text.length > 0) {
        [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.signUpForms.carType.subfield.tag] forKey:@"carType"];
    }
    
    if (self.signUpForms.school.subfield.text.length > 0) {
        [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.signUpForms.school.subfield.tag] forKey:@"teamCode"];
    }else{
        [self.studentDic setObject:[[XLCache singleton].teamCode_value firstObject] forKey:@"teamCode"];
    }
    
    if (self.signUpForms.type.subfield.text.length > 0) {
        [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.signUpForms.type.subfield.tag] forKey:@"applicationType"];
    }
    
    
    [self.studentDic setObject:self.otherForms.referees.subfield.text forKey:@"recommender"];
    [self.studentDic setObject:self.otherForms.note.subfield.text forKey:@"remark"];
    //    [self.studentDic setObject:[NSString stringWithFormat:@"%ld",(long)self.otherForms.state.subfield.tag] forKey:@"isPay"];
    if (!USERFZR) {
        [self.studentDic setObject:[User UserOb].userId forKey:@"coachId"];
    }
    
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



#pragma mark - 拍照识别
- (void)paizhaoZM{
    UIViewController *vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardFont
                                 andImageHandler:^(UIImage *image) {
                                     
                                     [[AipOcrService shardService] detectIdCardFrontFromImage:image
                                                                                  withOptions:nil
                                                                               successHandler:_successHandler
                                                                                  failHandler:_failHandler];
                                 }];
    
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)paizhaoFM{
    UIViewController *vc =
    [AipCaptureCardVC ViewControllerWithCardType:CardTypeIdCardBack
                                 andImageHandler:^(UIImage *image) {
                                     
                                     [[AipOcrService shardService] detectIdCardBackFromImage:image
                                                                                 withOptions:nil
                                                                              successHandler:_successHandler
                                                                                 failHandler:_failHandler];
                                 }];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)configCallback {
    __weak typeof(self) weakSelf = self;
    
    // 这是默认的识别成功的回调
    _successHandler = ^(id result){
        NSLog(@"%@", result);
        dispatch_async(dispatch_get_main_queue(), ^{
            // code here
            NSDictionary *dic = result[@"words_result"];
            XLCache *cache = [XLCache singleton];
            if ([result[@"words_result_num"] intValue] == 3) {
                NSString *stat = dic[@"签发日期"][@"words"];
                if (stat.length == 8) {
                    NSString * year = [stat substringWithRange:NSMakeRange(0, 4)];
                    NSString * month = [stat substringWithRange:NSMakeRange(4, 2)];
                    NSString * day = [stat substringWithRange:NSMakeRange(6,2)];
                    NSString *y = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
                    weakSelf.start_time.subfield.text = y;
                }
                NSString *end = dic[@"失效日期"][@"words"];
                if (end.length == 8) {
                    NSString * year = [end substringWithRange:NSMakeRange(0, 4)];
                    NSString * month = [end substringWithRange:NSMakeRange(4, 2)];
                    NSString * day = [end substringWithRange:NSMakeRange(6,2)];
                    NSString *y = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
                    weakSelf.end_time.subfield.text = y;
                }
            }else{
                
                weakSelf.name.subfield.text = dic[@"姓名"][@"words"];
                weakSelf.SFZforms.gender.subfield.text = dic[@"性别"][@"words"];
                if (dic[@"民族"][@"words"]) {
                    NSString *ethnic = [NSString stringWithFormat:@"%@族",dic[@"民族"][@"words"]];
                    weakSelf.SFZforms.ethnic.subfield.text = ethnic;
                    weakSelf.SFZforms.ethnic.subfield.tag = [cache.ethnicValueArr [[cache.ethnicTitleArr indexOfObject:ethnic]] integerValue];
                }
                weakSelf.SFZforms.gender.subfield.tag = [cache.sys_user_sex_value[[cache.sys_user_sex_title indexOfObject:dic[@"性别"][@"words"]]] integerValue];
                weakSelf.SFZforms.address.subfield.text = dic[@"住址"][@"words"];
                weakSelf.SFZforms.IdNumber.subfield.text = dic[@"公民身份号码"][@"words"];
                weakSelf.SFZforms.birthday.subfield.text = [weakSelf birthdayStrFromIdentityCard:dic[@"公民身份号码"][@"words"]];
                
                
            }
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        });
        
    };
    
    _failHandler = ^(NSError *error){
        NSLog(@"%@", error);
        NSString *msg = [NSString stringWithFormat:@"%li:%@", (long)[error code], [error localizedDescription]];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [[[UIAlertView alloc] initWithTitle:@"识别失败" message:msg delegate:weakSelf cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
        }];
    };
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


#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
