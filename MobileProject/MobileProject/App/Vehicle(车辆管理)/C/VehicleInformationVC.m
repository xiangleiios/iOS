//
//  VehicleInformationVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/27.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "VehicleInformationVC.h"
#import "XLInformationV.h"
@interface VehicleInformationVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;

@property (nonatomic , strong)XLInformationV *bianhao;
@property (nonatomic , strong)XLInformationV *duibie;
@property (nonatomic , strong)XLInformationV *fuzeren;
@property (nonatomic , strong)XLInformationV *pho;
@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)XLInformationV *end_time;
@property (nonatomic , strong)XLInformationV *chelianghao;
@property (nonatomic , strong)XLInformationV *goumai_time;
@property (nonatomic , strong)XLInformationV *zhuce_time;
@property (nonatomic , strong)XLInformationV *chejia;
@property (nonatomic , strong)XLInformationV *fadongji;
@property (nonatomic , strong)XLInformationV *beizhu;
@property (nonatomic , strong)NSMutableArray *browseItemArray;
@end

@implementation VehicleInformationVC
-(NSMutableArray *)browseItemArray{
    if (_browseItemArray==nil) {
        _browseItemArray=[NSMutableArray array];
    }
    return _browseItemArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_N(240, 240, 240);
    
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
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    
    self.backview = [[XLView alloc] init];
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backview.backgroundColor = [UIColor whiteColor];
    [self.scroll addSubview:self.backview];
    
}

- (void)loadDataview{
    UIView *v = [[UIView alloc] init];
    [self.backview addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(990));
    }];
    
    self.bianhao = [[XLInformationV alloc] informationWithTitle:@"车辆编号" SubTitle:_model.carNumber];
    self.duibie = [[XLInformationV alloc] informationWithTitle:@"所属队别" SubTitle:_model.schoolName];
    self.fuzeren = [[XLInformationV alloc] informationWithTitle:@"负责人" SubTitle:_model.user];
    self.pho = [[XLInformationV alloc] informationWithTitle:@"联系电话" SubTitle:_model.userPhoneNumber];
    self.name = [[XLInformationV alloc] informationWithTitle:@"车辆名称" SubTitle:_model.carName];
    self.chelianghao = [[XLInformationV alloc] informationWithTitle:@"车辆号" SubTitle:_model.plateNumber];
    self.goumai_time = [[XLInformationV alloc] informationWithTitle:@"购买日期" SubTitle:_model.buyTime];
    self.zhuce_time = [[XLInformationV alloc] informationWithTitle:@"注册日期" SubTitle:_model.registerTime];
    self.chejia = [[XLInformationV alloc] informationWithTitle:@"车架号" SubTitle:_model.vin];
    self.fadongji = [[XLInformationV alloc] informationWithTitle:@"发动机" SubTitle:_model.engineNumber];
    self.beizhu = [[XLInformationV alloc] informationWithTitle:@"备注" SubTitle:_model.remark];
    
    
    [v addSubview:self.bianhao];
    [v addSubview:self.duibie];
    [v addSubview:self.fuzeren];
    [v addSubview:self.pho];
    [v addSubview:self.name];
    [v addSubview:self.chelianghao];
    [v addSubview:self.goumai_time];
    [v addSubview:self.zhuce_time];
    [v addSubview:self.chejia];
    [v addSubview:self.fadongji];
    [v addSubview:self.beizhu];
    
    
    NSArray *arr = @[self.bianhao,self.duibie,self.fuzeren,self.pho,self.name,self.chelianghao,self.goumai_time,self.zhuce_time,self.chejia,self.fadongji,self.beizhu];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(v);
    }];
    
    
//    UILabel *lb = [[UILabel alloc] init];
//    [self.backview addSubview:lb];
//    lb.text = @"图片";
//    lb.font = [UIFont systemFontOfSize:kFit_Font6(16)];
//    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
//        make.top.mas_equalTo(v.mas_bottom);
//        make.height.mas_equalTo(KFit_H6S(90));
//        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
//    }];
    
    
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
