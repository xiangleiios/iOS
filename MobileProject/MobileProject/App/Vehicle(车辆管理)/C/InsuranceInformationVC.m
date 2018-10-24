//
//  InsuranceInformationVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/3.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "InsuranceInformationVC.h"
#import "XLInformationV.h"
#import "MSSBrowseNetworkViewController.h"
@interface InsuranceInformationVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)NSMutableArray *browseItemArray;
@end

@implementation InsuranceInformationVC
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
        make.height.mas_equalTo(KFit_H6S(270));
    }];
    
    
    XLInformationV *qiangxian = [[XLInformationV alloc] informationWithTitle:@"交强险公司" SubTitle:_model.trafficInsuranceCompanyName];
    XLInformationV *qiangxian_time = [[XLInformationV alloc] informationWithTitle:@"强险购买日期" SubTitle:_model.trafficInsuranceBuyTime];
    XLInformationV *qiangxian_end_time = [[XLInformationV alloc] informationWithTitle:@"强险到期日期" SubTitle:_model.trafficInsuranceExpireTime];

    [v addSubview:qiangxian];
    [v addSubview:qiangxian_time];
    [v addSubview:qiangxian_end_time];

    
    NSArray *arr = @[qiangxian,qiangxian_time,qiangxian_end_time];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(v);
    }];
    
    
    UILabel *lb = [[UILabel alloc] init];
    [self.backview addSubview:lb];
    lb.text = @"交强险扫描件照片";
    lb.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(v.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
    }];
    
    UIView *imgback = [[UIView alloc] init];
    [self.backview addSubview:imgback];
    [imgback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(lb.mas_bottom).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(180));
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    [imgback addSubview:img];
    [img sd_setImageWithURL:[NSURL URLWithString:_model.trafficInsurancePic] placeholderImage:[UIImage imageNamed:@"lb-jiazaitu"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgback.mas_top);
        make.left.mas_equalTo(imgback.mas_left).mas_offset(KFit_W6S(30));
        make.height.width.mas_equalTo(KFit_W6S(150));
    }];
    img.userInteractionEnabled = YES;
    img.tag = 0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [img addGestureRecognizer:tap];
    
    UIImageView *imageView = [self.view viewWithTag:0 + 100];
    MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
    browseItem.bigImageUrl = KURLIma(_model.trafficInsurancePic);// 加载网络图片大图地址
    browseItem.smallImageView = imageView;// 小图
    [self.browseItemArray addObject:browseItem];
    
    
    UILabel *lbback = [[UILabel alloc] init];
    lbback.backgroundColor = kColor_N(240, 240, 240);
    [self.backview addSubview:lbback];
    [lbback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(imgback.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(20));
    }];
 
    UIView *vtwo = [[UIView alloc] init];
    [self.backview addSubview:vtwo];
    [vtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(imgback.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(270));
    }];
    
    
    XLInformationV *shangxian = [[XLInformationV alloc] informationWithTitle:@"商险公司" SubTitle:_model.businessInsuranceCompanyName];
    XLInformationV *shangxian_time = [[XLInformationV alloc] informationWithTitle:@"商险购买日期" SubTitle:_model.businessInsuranceBuyTime];
    XLInformationV *shangxian_end_time = [[XLInformationV alloc] informationWithTitle:@"商险到期日期" SubTitle:_model.businessInsuranceExpireTime];
    
    [vtwo addSubview:shangxian];
    [vtwo addSubview:shangxian_time];
    [vtwo addSubview:shangxian_end_time];
    
    
    NSArray *arrtwo = @[shangxian,shangxian_time,shangxian_end_time];
    [arrtwo mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arrtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(vtwo);
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    [self.backview addSubview:lbtwo];
    lbtwo.text = @"商险扫描件照片";
    lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(vtwo.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
    }];
    
    
    UIView *imgbacktwo = [[UIView alloc] init];
    [self.backview addSubview:imgbacktwo];
    [imgbacktwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(lbtwo.mas_bottom).mas_offset(KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(180));
    }];
    
    UIImageView *imgtwo = [[UIImageView alloc] init];
    [imgbacktwo addSubview:imgtwo];
    [imgtwo sd_setImageWithURL:[NSURL URLWithString:_model.businessInsurancePic] placeholderImage:[UIImage imageNamed:@"lb-jiazaitu"]];
    [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgbacktwo.mas_top);
        make.left.mas_equalTo(imgbacktwo.mas_left).mas_offset(KFit_W6S(30));
        make.height.width.mas_equalTo(KFit_W6S(150));
    }];
    imgtwo.userInteractionEnabled = YES;
    imgtwo.tag = 1;
    UITapGestureRecognizer *taptwo = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [imgtwo addGestureRecognizer:taptwo];
    
    UIImageView *imageViewtwo = [self.view viewWithTag:1 + 100];
    MSSBrowseModel *browseItemtwo = [[MSSBrowseModel alloc]init];
    browseItemtwo.bigImageUrl = KURLIma(_model.businessInsurancePic);// 加载网络图片大图地址
    browseItemtwo.smallImageView = imageViewtwo;// 小图
    [self.browseItemArray addObject:browseItemtwo];
    
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
    
    
}

-(void)tapView:(UITapGestureRecognizer *)sender{
    UIImageView *img=(UIImageView *)sender.view;
    MSSBrowseNetworkViewController *bvc = [[MSSBrowseNetworkViewController alloc]initWithBrowseItemArray:self.browseItemArray currentIndex:img.tag];
    
    //             bvc.isEqualRatio = NO;// 大图小图不等比时需要设置这个属性（建议等比）
    //    [bvc.navigationController fm_setStatusBarBackgroundColor:[UIColor clearColor]];
    [bvc showBrowseViewController];
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
