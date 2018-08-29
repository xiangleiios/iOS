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
@interface StudentDetailsEditorVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;

@property (nonatomic , strong)FormsV *SFZforms;
@property (nonatomic , strong)SignUpTwoFormsV *signUpTwo;
@property (nonatomic , strong)XLInformationV *start_time;
@property (nonatomic , strong)XLInformationV *end_time;
@property (nonatomic , strong)OtherFormsV *otherForms;
@end

@implementation StudentDetailsEditorVC

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
    [next setTitle:@"保存" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    next.backgroundColor = kColor_N(0, 112, 234);
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
- (void)nextVC{
    
    
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
    
    self.SFZforms = [[FormsV alloc] init];
    [self.view addSubview:self.SFZforms];
    [self.SFZforms mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(lbback.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(540));
    }];
    
    XLInformationV *lbbacktwo = [[XLInformationV alloc] informationWithTitle:@"身份证反面信息"];
    [self.backview addSubview:lbbacktwo];
    [lbbacktwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(self.SFZforms.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    kWeakSelf(self)
    self.start_time = [[XLInformationV alloc] informationWithTitle:@"有效期起始" SubTitle:@"" TSSubTitle:@"请选择日期" Must:YES Click:YES];
    self.start_time.senterBlock = ^{
        [CGXPickerView showDatePickerWithTitle:@"有效期起始" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            weakself.start_time.subfield.text = selectValue;
        }];
    };
    self.end_time = [[XLInformationV alloc] informationWithTitle:@"有效期结束" SubTitle:@"" TSSubTitle:@"请选择日期" Must:YES Click:YES];
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
