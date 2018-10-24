//
//  ReservationDetailsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ReservationDetailsVC.h"
#import "XLInformationV.h"
@interface ReservationDetailsVC ()

@end

@implementation ReservationDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"预约详情"];
    self.view.backgroundColor = kColor_N(240, 240, 240);
    [self loadSub];
    // Do any additional setup after loading the view.
}

- (void)loadSub{
    UIView *v = [[UIView alloc] init];
    [self.view addSubview:v];
    v.backgroundColor = kColor_N(0, 112, 234);
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(400));
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    [v addSubview:img];
    [img setImage:[UIImage imageNamed:@"jxiao"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(35));
        make.top.mas_equalTo(v).mas_offset(KFit_H6S(70));
        make.width.height.mas_equalTo(KFit_W6S(48));
    }];
    
    UILabel *name = [[UILabel alloc] init];
    [v addSubview:name];
    name.textColor = [UIColor whiteColor];
    name.text = @"光谷驾校";
    name.font = [UIFont systemFontOfSize:kFit_Font6(20)];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(img);
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(10));
        make.height.mas_equalTo(KFit_H6S(50));
    }];
    
    UILabel *type = [[UILabel alloc] init];
    [v addSubview:type];
    type.textColor = [UIColor whiteColor];
    type.text = @"光谷驾校";
    type.textAlignment = NSTextAlignmentCenter;
    type.layer.cornerRadius = kFit_Font6(3);
    type.layer.masksToBounds = YES;
    type.layer.borderColor = [UIColor whiteColor].CGColor;
    type.layer.borderWidth = 0.5;
    type.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(img);
        make.right.mas_equalTo(v.mas_right).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(60));
        make.width.mas_equalTo(KFit_W6S(160));
    }];
    
    UILabel *didian = [[UILabel alloc] init];
    [v addSubview:didian];
    didian.textColor = [UIColor whiteColor];
    didian.text = @"练车地点：光谷驾校";
    didian.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [didian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(35));
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_W6S(40));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    UILabel *shijian = [[UILabel alloc] init];
    [v addSubview:shijian];
    shijian.textColor = [UIColor whiteColor];
    shijian.text = @"练车地点：光谷驾校";
    shijian.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [shijian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(35));
        make.top.mas_equalTo(didian.mas_bottom).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    UIView *vtwo = [[UIView alloc] init];
    vtwo.backgroundColor = [UIColor whiteColor];
    vtwo.layer.cornerRadius = kFit_Font6(5);
    vtwo.layer.masksToBounds = YES;
    [self.view addSubview:vtwo];
    [vtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(35));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(35));
        make.top.mas_equalTo(v.mas_bottom).mas_offset(-KFit_H6S(90));
        make.height.mas_equalTo(KFit_H6S(270));
    }];
    XLInformationV *xiangmu = [[XLInformationV alloc] informationWithTitle:@"练车项目" SubTitle:@"科目二"];
    XLInformationV *jiazhao = [[XLInformationV alloc] informationWithTitle:@"练车项目" SubTitle:@"科目二"];
    XLInformationV *yuyueshijian = [[XLInformationV alloc] informationWithTitle:@"练车项目" SubTitle:@"科目二"];
    
    [vtwo addSubview:xiangmu];
    [vtwo addSubview:jiazhao];
    [vtwo addSubview:yuyueshijian];
    
    NSArray *arr = @[xiangmu,jiazhao,yuyueshijian];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vtwo).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(vtwo).mas_offset(-KFit_W6S(30));
    }];
    
    
    UIView *vthree = [[UIView alloc] init];
    vthree.layer.cornerRadius = kFit_Font6(5);
    vthree.layer.masksToBounds = YES;
    [self.view addSubview:vthree];
    vthree.backgroundColor = [UIColor whiteColor];
    [vthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(35));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(35));
        make.top.mas_equalTo(vtwo.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(270));
    }];
    
    XLInformationV *tongji = [[XLInformationV alloc] informationWithTitle:@"练车项目" SubTitle:@"科目二"];
    XLInformationV *kemuer = [[XLInformationV alloc] informationWithTitle:@"练车项目" SubTitle:@"科目二"];
    XLInformationV *kemusan = [[XLInformationV alloc] informationWithTitle:@"练车项目" SubTitle:@"科目二"];
    
    [vthree addSubview:tongji];
    [vthree addSubview:kemuer];
    [vthree addSubview:kemusan];
    
    NSArray *arrtwo = @[tongji,kemuer,kemusan];
    [arrtwo mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arrtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vtwo).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(vtwo).mas_offset(-KFit_W6S(30));
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
