//
//  RegistrationInformationVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/27.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "RegistrationInformationVC.h"
#import "XLInformationV.h"
#import "MSSBrowseNetworkViewController.h"

@interface RegistrationInformationVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;

@property (nonatomic , strong)XLInformationV *dengji;
@property (nonatomic , strong)XLInformationV *pingding_time;
@property (nonatomic , strong)XLInformationV *xiaci_time;
@property (nonatomic , strong)XLInformationV *jibie;
@property (nonatomic , strong)XLInformationV *qixian;
@property (nonatomic , strong)NSMutableArray *browseItemArray;
@end

@implementation RegistrationInformationVC
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
        make.height.mas_equalTo(KFit_H6S(450));
    }];
    
    NSString *str = [_model.isRating  isEqual: @"1"]?@"否":@"是";
    
    self.dengji = [[XLInformationV alloc] informationWithTitle:@"是否进行等级评定" SubTitle:str];
    self.pingding_time = [[XLInformationV alloc] informationWithTitle:@"等级评定日期" SubTitle:_model.ratingTime];
    self.xiaci_time = [[XLInformationV alloc] informationWithTitle:@"下次等级评定日期" SubTitle:_model.ratingNextCheckTime];
    
    NSString *str1;
    if ([_model.ratingLevel  isEqual: @"1"]) {
        str1 = @"一级";
    }else if ([_model.ratingLevel  isEqual: @"2"]){
        str1 = @"二级";
    }else if ([_model.ratingLevel  isEqual: @"3"]){
        str1 = @"三级";
    }
    self.jibie = [[XLInformationV alloc] informationWithTitle:@"等级评定级别" SubTitle:str1];
    self.qixian = [[XLInformationV alloc] informationWithTitle:@"等级评定有限期限" SubTitle:_model.ratingExpireTime];
    
    [v addSubview:self.dengji];
    [v addSubview:self.pingding_time];
    [v addSubview:self.xiaci_time];
    [v addSubview:self.jibie];
    [v addSubview:self.qixian];
    
    NSArray *arr = @[self.dengji,self.pingding_time,self.xiaci_time,self.jibie,self.qixian];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(v);
    }];
    
    
    UILabel *lb = [[UILabel alloc] init];
    [self.backview addSubview:lb];
    lb.text = @"等级评定扫描照片";
    lb.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(v.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(90));
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
    }];
    
    if (![_model.ratingLevelPic  isEqual:@""] && ![_model.isRating  isEqual: @"1"]) {
        
    
    UIImageView *img = [[UIImageView alloc] init];
    [self.backview addSubview:img];
    img.userInteractionEnabled = YES;
    img.tag = 0;
    [img sd_setImageWithURL:[NSURL URLWithString:_model.ratingLevelPic] placeholderImage:[UIImage imageNamed:@"lb-jiazaitu"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lb.mas_bottom);
        make.left.mas_equalTo(self.backview.mas_left).mas_offset(KFit_W6S(30));
        make.height.width.mas_equalTo(KFit_W6S(150));
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
    [img addGestureRecognizer:tap];
    
    UIImageView *imageView = [self.view viewWithTag:0 + 100];
    MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
    browseItem.bigImageUrl = KURLIma(_model.ratingLevelPic);// 加载网络图片大图地址
    browseItem.smallImageView = imageView;// 小图
    [self.browseItemArray addObject:browseItem];
        
    }
    
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
