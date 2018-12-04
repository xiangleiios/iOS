//
//  StudentDetailsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/7.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "StudentDetailsVC.h"
#import "XLInformationV.h"
#import "XLCache.h"
#define FONT kFit_Font6(16)
@interface StudentDetailsVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)XLInformationV *gender;
@property (nonatomic , strong)XLInformationV *ethnic;
@property (nonatomic , strong)XLInformationV *birthday;
@property (nonatomic , strong)XLInformationV *address;
@property (nonatomic , strong)XLInformationV *IdNumber;
@property (nonatomic , strong)XLInformationV *start_time;
@property (nonatomic , strong)XLInformationV *enf_time;
@property (nonatomic , strong)XLInformationV *pho;
@property (nonatomic , strong)XLInformationV *hukou;
@property (nonatomic , strong)XLInformationV *carType;
@property (nonatomic , strong)XLInformationV *type;
//@property (nonatomic , strong)XLInformationV *price;
@property (nonatomic , strong)XLInformationV *school;
@property (nonatomic , strong)XLInformationV *referees;
@property (nonatomic , strong)XLInformationV *note;
@property (nonatomic , strong)XLInformationV *jiaolian;
//@property (nonatomic , strong)XLInformationV *state;

@end

@implementation StudentDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"报名信息"];
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
        make.bottom.mas_equalTo(self.view);
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
}


- (void)loadDataview{
    XLCache *cache = [XLCache singleton];
    UIView *vone = [[UIView alloc] init];
    [self.backview addSubview:vone];
    [vone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(450));
    }];
    XLInformationV *SFZZM = [[XLInformationV alloc] informationWithTitle:@"身份证正面信息"];
    self.name = [[XLInformationV alloc] informationWithTitle:@"姓名" SubTitle:_model.studentName];
    self.gender = [[XLInformationV alloc] informationWithTitle:@"性别" SubTitle:cache.sys_user_sex_title[[cache.sys_user_sex_value indexOfObject:_model.sex]]];
    
    self.ethnic = [[XLInformationV alloc] informationWithTitle:@"民族" SubTitle:cache.ethnicTitleArr[[cache.ethnicValueArr indexOfObject:_model.nation]]];
    
    self.birthday = [[XLInformationV alloc] informationWithTitle:@"出生年月日" SubTitle:[XLCommonUse datetimestampToString:_model.birthday]];
    
    
    
    [vone addSubview:SFZZM];
    [vone addSubview:self.name];
    [vone addSubview:self.gender];
    [vone addSubview:self.ethnic];
    [vone addSubview:self.birthday];
    
    NSArray *arrone = @[SFZZM,self.name,self.gender,self.ethnic,self.birthday];
    [arrone mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arrone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(vone);
    }];
    
    
    UILabel *titleLable = [[UILabel alloc] init];
    [self.backview addSubview:titleLable];
    titleLable.text = @"地址";
    titleLable.font = [UIFont systemFontOfSize:FONT];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(vone.mas_bottom).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(280));
    }];
    
    UILabel *subLable = [[UILabel alloc] init];
    [self.backview addSubview:subLable];
    subLable.text = _model.idcardAddress?_model.idcardAddress:@" ";
    subLable.textColor = kColor_N(143, 155, 178);
    subLable.textAlignment = NSTextAlignmentRight;
    subLable.font = [UIFont systemFontOfSize:FONT];
    subLable.numberOfLines = 0;
    [subLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(titleLable);
        //            make.height.mas_equalTo(self);
        make.left.mas_equalTo(titleLable.mas_right).mas_offset(KFit_W6S(20));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.backview addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(subLable.mas_bottom).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(1);
    }];

    
    
    UIView *vtwo = [[UIView alloc] init];
    [self.backview addSubview:vtwo];
    [vtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(lb.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(1170));
    }];
    
    self.IdNumber = [[XLInformationV alloc] informationWithTitle:@"身份证号" SubTitle:_model.idcard];
    XLInformationV *SFZFM = [[XLInformationV alloc] informationWithTitle:@"身份证反面信息"];
    
    self.start_time = [[XLInformationV alloc] informationWithTitle:@"有效期起始" SubTitle:[XLCommonUse datetimestampToString:_model.idcardStartDate]];
    self.enf_time = [[XLInformationV alloc] informationWithTitle:@"有效期结束" SubTitle:_model.idcardEndDate];
    XLInformationV *baomin = [[XLInformationV alloc] informationWithTitle:@"报名信息"];
    
    
    self.pho = [[XLInformationV alloc] informationWithTitle:@"手机号" SubTitle:_model.studentPhone];
    self.hukou = [[XLInformationV alloc] informationWithTitle:@"本外地" SubTitle:cache.student_is_enter_type_title[[cache.student_is_enter_type_value indexOfObject:_model.enterType]]];
    
    self.carType = [[XLInformationV alloc] informationWithTitle:@"车型" SubTitle:cache.student_license_type_title[[cache.student_license_type_value indexOfObject:_model.carType]]];
    
//    self.price = [[XLInformationV alloc] informationWithTitle:@"报考价格" SubTitle:_model.signupPrice];
    self.school = [[XLInformationV alloc] informationWithTitle:@"报考驾校" SubTitle:cache.teamCode_title[[cache.teamCode_value indexOfObject:_model.teamCode]]];
    
    self.type = [[XLInformationV alloc] informationWithTitle:@"申请类型" SubTitle:cache.student_apply_type_title[[cache.student_apply_type_value indexOfObject:_model.applicationType]]];
    XLInformationV *oter = [[XLInformationV alloc] informationWithTitle:@"其他信息"];
    
    self.referees = [[XLInformationV alloc] informationWithTitle:@"推荐人" SubTitle:_model.recommender];
    
    self.jiaolian = [[XLInformationV alloc] informationWithTitle:@"报名教练" SubTitle:_model.coachName?_model.coachName:@"分校"];
    [vtwo addSubview:self.IdNumber];
    [vtwo addSubview:SFZFM];
    [vtwo addSubview:self.start_time];
    [vtwo addSubview:self.enf_time];
    [vtwo addSubview:baomin];
    [vtwo addSubview:self.pho];
    [vtwo addSubview:self.hukou];
    [vtwo addSubview:self.carType];
//    [vtwo addSubview:self.price];
    [vtwo addSubview:self.school];
    [vtwo addSubview:self.type];
    [vtwo addSubview:oter];
    [vtwo addSubview:self.referees];
    [vtwo addSubview:self.jiaolian];
    
    NSArray *arrtwo = @[self.IdNumber,SFZFM,self.start_time,self.enf_time,baomin,self.pho,self.hukou,self.carType,self.school,self.type,oter,self.referees,self.jiaolian];
    [arrtwo mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arrtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(vone);
    }];
    
    
    
    UILabel *titleLabletwo = [[UILabel alloc] init];
    [self.backview addSubview:titleLabletwo];
    titleLabletwo.text = @"备注";
    titleLabletwo.font = [UIFont systemFontOfSize:FONT];
    [titleLabletwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(vtwo.mas_bottom).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(280));
    }];
    
    UILabel *subLabletwo = [[UILabel alloc] init];
    [self.backview addSubview:subLabletwo];

    subLabletwo.text = _model.remark?_model.remark:@" ";
    subLabletwo.textColor = kColor_N(143, 155, 178);
    subLabletwo.textAlignment = NSTextAlignmentRight;
    subLabletwo.font = [UIFont systemFontOfSize:FONT];
    subLabletwo.numberOfLines = 0;
    [subLabletwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(titleLabletwo);
        //            make.height.mas_equalTo(self);
        make.left.mas_equalTo(titleLabletwo.mas_right).mas_offset(KFit_W6S(20));
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    [self.backview addSubview:lbtwo];
    lbtwo.backgroundColor = kColor_N(240, 240, 240);
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(subLabletwo.mas_bottom).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(1);
    }];
//    NSString *str;
//    if ([_model.isPay  isEqual: @"1"]) {
//        str = @"未缴费";
//
//    }else{
//        str =  @"已缴费";
//
//    }
//    self.state = [[XLInformationV alloc] informationWithTitle:@"收费状态" SubTitle:str];
//    [self.backview addSubview:self.state];
//    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.backview);
//        make.top.mas_equalTo(lbtwo.mas_bottom);
//        make.height.mas_equalTo(KFit_H6S(90));
//    }];
//
//    self.name = [[XLInformationV alloc] informationWithTitle:@"姓名" SubTitle:_model.studentName];
//    self.name = [[XLInformationV alloc] informationWithTitle:@"姓名" SubTitle:_model.studentName];
    
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
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
