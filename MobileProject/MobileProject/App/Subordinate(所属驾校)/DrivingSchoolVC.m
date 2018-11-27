//
//  DrivingSchoolVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/25.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "DrivingSchoolVC.h"
#import "XLInformationV.h"
#import "MSSBrowseNetworkViewController.h"
@interface DrivingSchoolVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;

@property (nonatomic , strong)XLInformationV *jiaoxiao;
@property (nonatomic , strong)XLInformationV *fendeiName;
@property (nonatomic , strong)XLInformationV *fenduiType;
@property (nonatomic , strong)XLInformationV *jiaofei;
@property (nonatomic , strong)XLInformationV *baozhengjin;
@property (nonatomic , strong)XLInformationV *stat_time;
@property (nonatomic , strong)XLInformationV *end_time;
@property (nonatomic , strong)XLInformationV *fuzeren;
@property (nonatomic , strong)XLInformationV *pho;
@property (nonatomic , strong)XLInformationV *shenfenz;
@property (nonatomic , strong)XLInformationV *shangxian;
@property (nonatomic , strong)XLInformationV *address;
@property (nonatomic , strong)XLInformationV *beizhu;
@property (nonatomic , strong)NSMutableArray *imgArr;
@property (nonatomic , strong)NSMutableArray *browseItemArray;
@end

@implementation DrivingSchoolVC
-(NSMutableArray *)browseItemArray{
    if (_browseItemArray==nil) {
        _browseItemArray=[NSMutableArray array];
    }
    return _browseItemArray;
}
- (NSMutableArray *)imgArr{
    if (_imgArr == nil) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"所属驾校"];
    [self laodScroll];
    [self laodData];
    
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
//        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
    
    self.backview = [[XLView alloc] init];
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.scroll addSubview:self.backview];
    
}


- (void)loadDataview{
    
    UIView *v = [[UIView alloc] init];
    [self.backview addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(1170));
    }];
    
    self.jiaoxiao = [[XLInformationV alloc] informationWithTitle:@"所属驾校" SubTitle:_model.deptFatherName];
    self.fendeiName = [[XLInformationV alloc] informationWithTitle:@"分队名" SubTitle:_model.name];
    self.fenduiType = [[XLInformationV alloc] informationWithTitle:@"分队类型" SubTitle:_model.typeName];
    self.jiaofei = [[XLInformationV alloc] informationWithTitle:@"缴费类型" SubTitle:_model.payName];
    self.baozhengjin = [[XLInformationV alloc] informationWithTitle:@"保证金" SubTitle:_model.ensureCost];
    self.stat_time = [[XLInformationV alloc] informationWithTitle:@"合同起始时间" SubTitle:_model.contractTimeStart];
    self.end_time = [[XLInformationV alloc] informationWithTitle:@"合同结束时间" SubTitle:_model.contractTimeEnd];
    self.fuzeren = [[XLInformationV alloc] informationWithTitle:@"负责人" SubTitle:_model.leader];
    self.pho = [[XLInformationV alloc] informationWithTitle:@"联系电话" SubTitle:_model.phone];
    NSString *card;
    if (_model.leaderIdCard.length == 18) {
        card = [NSString stringWithFormat:@"%@******%@", [_model.leaderIdCard substringToIndex:4], [_model.leaderIdCard substringFromIndex:14]];
    }else{
        card = @"";
    }
    
    self.shenfenz = [[XLInformationV alloc] informationWithTitle:@"负责人身份证号" SubTitle:card];
    self.shangxian = [[XLInformationV alloc] informationWithTitle:@"报名上限" SubTitle:_model.upperLimitNumber];
    self.address = [[XLInformationV alloc] informationWithTitle:@"地址" SubTitle:_model.address];
    self.beizhu = [[XLInformationV alloc] informationWithTitle:@"备注" SubTitle:_model.remark];
    
    [v addSubview:self.jiaoxiao];
    [v addSubview:self.fendeiName];
    [v addSubview:self.fenduiType];
    [v addSubview:self.jiaofei];
    [v addSubview:self.baozhengjin];
    [v addSubview:self.stat_time];
    [v addSubview:self.end_time];
    [v addSubview:self.fuzeren];
    [v addSubview:self.pho];
    [v addSubview:self.shenfenz];
    [v addSubview:self.shangxian];
    [v addSubview:self.address];
    [v addSubview:self.beizhu];
    
    
    NSArray *arr = @[self.jiaoxiao,self.fendeiName,self.fenduiType,self.jiaofei,self.baozhengjin,self.stat_time,self.end_time,self.fuzeren,self.pho,self.shenfenz,self.shangxian,self.address,self.beizhu];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(v);
    }];
    
    
    UILabel *lb = [[UILabel alloc] init];
    [self.backview addSubview:lb];
    lb.text = @"图片";
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
        make.height.mas_equalTo(KFit_H6S(150));
    }];
    
    if (![_model.idCardFrontUrl  isEqual: @""] ) {
        [self.imgArr addObject:_model.idCardFrontUrl];
    }
    if (![_model.idCardBackUrl  isEqual:@""]) {
        [self.imgArr addObject:_model.idCardBackUrl];
    }
    if (![_model.contractUrl  isEqual:@""]) {
        [self.imgArr addObject:_model.contractUrl];
    }
    for (int i = 0; i<self.imgArr.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(KFit_W6S(30)+i * KFit_W6S(180), 0, KFit_W6S(150), KFit_W6S(150))];
        img.userInteractionEnabled = YES;
        img.tag=i;
        [imgback addSubview:img];
        [img sd_setImageWithURL:[NSURL URLWithString:self.imgArr[i]] placeholderImage:[UIImage imageNamed:@"lb-jiazaitu"]];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)];
        [img addGestureRecognizer:tap];
        
        UIImageView *imageView = [self.view viewWithTag:i + 100];
        MSSBrowseModel *browseItem = [[MSSBrowseModel alloc]init];
        browseItem.bigImageUrl = KURLIma(self.imgArr[i]);// 加载网络图片大图地址
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



- (void)laodData{
    NSString *url = [NSString stringWithFormat:POSTTeamSchoolTeamSchoolInfo,self.idid];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        self.model = [FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
        [self loadDataview];
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
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

@end
