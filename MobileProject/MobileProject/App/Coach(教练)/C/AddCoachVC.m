//
//  AddCoachVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/16.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddCoachVC.h"
#import "XLInformationV.h"
#import "CGXPickerView.h"
@interface AddCoachVC ()
@property (nonatomic , strong)XLInformationV *school;
@property (nonatomic , strong)XLInformationV *fenXiao;
@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)XLInformationV *pho;
@property (nonatomic , strong)UIImageView *head;
@end

@implementation AddCoachVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"添加教练"];
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)loadSubview{
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.text = @"头像";
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(self.view.mas_top).mas_offset(KFit_H6S(50) + kNavBarH);
        make.height.mas_equalTo(KFit_H6S(35));
    }];
    UIButton *but = [[UIButton alloc] init];
    [self.view addSubview:but];
    [but setImage:[UIImage imageNamed:@"arrows_right_icon"] forState:UIControlStateNormal];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(20));
        make.centerY.mas_equalTo(lb);
        make.width.mas_equalTo(KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.head = [[UIImageView alloc] init];
    [self.view addSubview:self.head];
    [self.head setImage:[UIImage imageNamed:@"head_nor"]];
    [self.head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(but.mas_left).mas_offset(-KFit_W6S(10));
        make.centerY.mas_equalTo(lb);
        make.width.height.mas_equalTo(KFit_H6S(100));
    }];
    
    UILabel *line = [[UILabel alloc] init];
    [self.view addSubview:line];
    line.backgroundColor = kColor_N(240, 240, 240);
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(lb.mas_bottom).mas_offset(KFit_H6S(50));
        make.height.mas_equalTo(kFit_Font6(1));
    }];
    
    UIView *view = [[UIView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(line.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(360));
    }];
    
    
    kWeakSelf(self)
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    NSArray *arrname = (NSArray *)[defaults objectForKey:SchoolList];
    
    self.school = [[XLInformationV alloc] informationWithTitle:@"所属总校" SubTitle:@"" TSSubTitle:@"请选择总校" Must:YES Click:YES];
    
    self.fenXiao = [[XLInformationV alloc] informationWithTitle:@"所属分校" SubTitle:@"" TSSubTitle:@"请选择分校" Must:NO Click:NO];
    self.fenXiao.userInteractionEnabled = NO;
    self.fenXiao.subfield.text = arrname[0][@"teamName"];
    self.school.senterBlock = ^{
        [CGXPickerView showStringPickerWithTitle:@"总校" DataSource:[XLCache singleton].teamCode_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            NSLog(@"%@",selectValue);
            int i = [selectRow intValue];
            weakself.school.subfield.text = selectValue;
            weakself.school.subfield.tag = [[XLCache singleton].teamCode_value[[selectRow intValue]] intValue];
            weakself.fenXiao.subfield.text = arrname[i][@"teamName"];
        }];
    };
    self.school.subfield.text = [[XLCache singleton].teamCode_title firstObject];
    self.school.subfield.tag = [[[XLCache singleton].teamCode_value firstObject] integerValue];
    
    
    self.name = [[XLInformationV alloc] informationWithTitle:@"教练名称" SubTitle:@"" TSSubTitle:@"请填写真实姓名" Must:YES Click:NO];
    
    self.pho = [[XLInformationV alloc] informationWithTitle:@"教练手机号" SubTitle:@"" TSSubTitle:@"请填写教练手机号码" Must:YES Click:NO];
    
    [view addSubview:self.school];
    [view addSubview:self.fenXiao];
    [view addSubview:self.name];
    [view addSubview:self.pho];
    
    NSArray *arr = @[self.school,self.fenXiao,self.name,self.pho];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(view);
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
