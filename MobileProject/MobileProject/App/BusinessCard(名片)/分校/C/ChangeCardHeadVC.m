//
//  ChangeCardHeadVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/31.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ChangeCardHeadVC.h"

#import "FormsV.h"
#import "XLInformationV.h"
#import "CourseV.h"
#import "TemplateV.h"
#import "XLCache.h"

#import "UploadPicturesV.h"
#import "SchoolLable.h"
#import "GDSearchMapVC.h"
#import "TSView.h"
#define BUT_W KFit_W6S(150)
@interface ChangeCardHeadVC ()<UIImagePickerControllerDelegate,GDSearchMapVCDelegate,AMapSearchDelegate>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)UIImageView *headImg;
@property (nonatomic , strong)FXAdmissionsFormsV *admissions;
@property (nonatomic , strong)CourseFormsV *course;
@property (nonatomic , strong)NSMutableArray *couresArr;

@property (nonatomic , strong)XLView *imgBackView;
@property (nonatomic , strong)UIButton *add_photo;
@property (nonatomic , strong)NSMutableArray *imgarr;
@property (nonatomic , strong)UIButton *UpAttachment;
@property (nonatomic , strong)NSMutableArray *butarr;
@property (nonatomic , strong)XLInformationV *keCheng;
@property (nonatomic , strong)XLInformationV *environment;
@property (nonatomic , strong)NSString *scanPhotoIp;  //图片头
@property (nonatomic , strong)NSMutableArray *imageviewArr;
@property (nonatomic , strong)UploadPicturesV *jiaoXueHuanJing;
@property (nonatomic , strong)UploadPicturesV *xuanChuan;
@property (nonatomic , strong)UploadPicturesV *jiaoXueZiZhi;
@property (nonatomic , strong)UploadPicturesV *jiaoXuePingPai;
@property (nonatomic , strong)UploadPicturesV *jiaoXueRongYu;
@property (nonatomic , strong)SchoolLable *schoolLb;

@property (nonatomic , strong)NSArray *teamSchoolTags; ///标签入口

@property (nonatomic , strong)NSDictionary *province;
@property (nonatomic , strong)NSDictionary *city;
@property (nonatomic , strong)NSDictionary *areadic;
@property (nonatomic , assign)CGFloat latitude;///纬度
@property (nonatomic , assign)CGFloat longitude;///经度
@end

@implementation ChangeCardHeadVC
-(void)setProvince:(NSDictionary *)province{
    _province = [province copy];
    KKLog(@"%@",_province);
}
- (void)setCity:(NSDictionary *)city{
    _city = [city copy];
    KKLog(@"%@",_city);
}
- (void)setAreadic:(NSDictionary *)areadic{
    _areadic = [areadic copy];
//    if (_province[@"name"]&&_city[@"name"]&&_areadic[@"name"]) {
//        self.admissions.addressarea.subfield.text = [NSString stringWithFormat:@"%@-%@-%@",_province[@"name"],_city[@"name"],_areadic[@"name"]];
//    }
    self.admissions.addressarea.subfield.text = [NSString stringWithFormat:@"%@-%@-%@",_province[@"name"],_city[@"name"],_areadic[@"name"]];
    
}

- (NSMutableArray *)butarr{
    if (_butarr==nil) {
        _butarr=[NSMutableArray array];
    }
    return _butarr;
}

- (NSMutableArray *)imgarr{
    if (_imgarr==nil) {
        _imgarr=[NSMutableArray array];
    }
    return _imgarr;
}
- (NSMutableArray *)imageviewArr{
    if (_imageviewArr==nil) {
        _imageviewArr=[NSMutableArray array];
    }
    return _imageviewArr;
}
- (NSMutableArray *)couresArr{
    if (_couresArr == nil) {
        _couresArr = [NSMutableArray array];
    }
    return _couresArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self laodNavigation];
    
    [self laodScroll];
    
    [self loadSubview];
    [self refreshData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setTitle:@"修改资料"];
    kWeakSelf(self)
    UIButton *but =  [self.navigationView addRightButtonWithTitle:@"保存" clickCallBack:^(UIView *view) {
        [weakself nextVC];
    }];
    [but setTitleColor:kColor_N(15, 115, 238) forState:UIControlStateNormal];
}


- (void)laodScroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
    
    self.backview = [[XLView alloc] init];
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backview.backgroundColor = kColor_N(240, 240, 240);
    [self.scroll addSubview:self.backview];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.view addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.scroll.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
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

- (void)loadSubview{
    XLInformationV *jiBenZiLiao = [[XLInformationV alloc] informationWithTitle:@"基本信息" Subtitle:@"" Must:YES];
    [self.backview addSubview:jiBenZiLiao];
    [jiBenZiLiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    

    
    self.admissions = [[FXAdmissionsFormsV alloc] init];
    [self.backview addSubview:self.admissions];
    self.admissions.backgroundColor = [UIColor whiteColor];
    [self.admissions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(jiBenZiLiao.mas_bottom);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(540));
    }];
    self.province = @{@"name":_model.provice};
    self.city = @{@"name":_model.city};
    self.areadic = @{@"name":_model.county};
    self.admissions.address.subfield.text = _model.detailAddress;
    self.latitude = _model.latitude;
    self.longitude = _model.latitude;
    kWeakSelf(self)
    
    self.admissions.addressarea.senterBlock = ^{
        [weakself.view endEditing:YES];
        GDSearchMapVC *vc = [[GDSearchMapVC alloc] init];
        vc.delegate = weakself;
        [weakself.navigationController pushViewController:vc animated:YES];
    };
    
    _keCheng = [[XLInformationV alloc] informationWithTitle:@"培训课程" ButTile:@"创建课程" ButImg:@"add_cj"];
    [self.backview addSubview:_keCheng];
    _keCheng.senterBlock = ^{
        CourseV *v = [[CourseV alloc] init];
        v.vc = weakself;
        v.idid = weakself.model.idid;
        [v show];
    };
    [_keCheng mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.admissions.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.course = [[CourseFormsV alloc] initWithDataArr:_model.classList];
    self.course.senterBlockInt = ^(int tag) {
        CourseV *v = [[CourseV alloc] initWithDictionary:_model.classList[tag]];
        v.vc = weakself;
        v.idid = weakself.model.idid;
        [v show];
    };
    //    KKLog(@"kecheng ::::%@",_model.classList);
    [self.backview addSubview:self.course];
    [self.course mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_keCheng.mas_bottom);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(140) * _model.classList.count);
    }];
    
    
    XLInformationV *introduce = [[XLInformationV alloc] informationWithTitle:@"驾校详情" ButTile:nil ButImg:nil];
    [self.backview addSubview:introduce];
//    introduce.senterBlock = ^{
//        TemplateV *v = [[TemplateV alloc] init];
//        v.vc = weakself;
//        [v show];
//    };
    [introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.course.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    UIView *inqutBack = [[UIView alloc] init];
    [self.backview addSubview:inqutBack];
    inqutBack.backgroundColor = [UIColor whiteColor];
    [inqutBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introduce.mas_bottom);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(250));
    }];
    
    UIImageView *box = [[UIImageView alloc] init];
    [box setImage:[UIImage imageNamed:@"box"]];
    [inqutBack addSubview:box];
    [box mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(inqutBack).mas_offset(KFit_W6S(30));
        make.right.bottom.mas_equalTo(inqutBack).mas_offset(-KFit_W6S(30));
    }];
    
    
    self.textView = [[UITextView alloc] init];
    self.textView.backgroundColor = [UIColor clearColor];
    [inqutBack addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(inqutBack).mas_offset(KFit_W6S(50));
        make.right.bottom.mas_equalTo(inqutBack).mas_offset(-KFit_W6S(50));
    }];
    
    self.schoolLb = [[SchoolLable alloc] init];
    [self.backview addSubview:self.schoolLb];
    [self.schoolLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inqutBack.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(180));
    }];
    
    XLInformationV *xc =[[XLInformationV alloc] informationWithTitle:@"分校封面" Subtitle:@"最多可上传1张" Must:YES];
    [self.backview addSubview:xc];
    [xc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.schoolLb.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    self.xuanChuan = [[UploadPicturesV alloc] init];
    [self.backview addSubview:self.xuanChuan];
    self.xuanChuan.vc = self;
    self.xuanChuan.type = 1;//可裁剪
    self.xuanChuan.num = 1;
    [self.xuanChuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view );
        make.top.mas_equalTo(xc.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(210));
    }];
    
    TSView *lbone = [[TSView alloc] init];
    [self.backview addSubview:lbone];
    lbone.tslb.text = @"可上传分校门头，品牌logo等照片";
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(80));
        make.top.mas_equalTo(self.xuanChuan.mas_bottom).mas_offset(-KFit_H6S(10));
    }];
    
    _environment = [[XLInformationV alloc] informationWithTitle:@"教学环境" Subtitle:@"最多可上传9张" Must:YES];
    [self.backview addSubview:_environment];
    [_environment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbone.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.jiaoXueHuanJing = [[UploadPicturesV alloc] init];
    [self.backview addSubview:self.jiaoXueHuanJing];
    self.jiaoXueHuanJing.vc = self;
    self.jiaoXueHuanJing.num = 9;
    [self.jiaoXueHuanJing mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view );
        make.top.mas_equalTo(_environment.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(210));
    }];
    TSView *lbtwo = [[TSView alloc] init];
    [self.backview addSubview:lbtwo];
    lbtwo.tslb.text = @"可上传分校门头，品牌logo等照片";
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(80));
        make.top.mas_equalTo(self.jiaoXueHuanJing.mas_bottom).mas_offset(-KFit_H6S(10));
    }];
    
    
    XLInformationV *zz =[[XLInformationV alloc] informationWithTitle:@"驾校资质" Subtitle:@"最多可上传3张" Must:NO];
    [self.backview addSubview:zz];
    [zz mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbtwo.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    self.jiaoXueZiZhi = [[UploadPicturesV alloc] init];
    [self.backview addSubview:self.jiaoXueZiZhi];
    self.jiaoXueZiZhi.vc = self;
    self.jiaoXueZiZhi.num = 3;
    [self.jiaoXueZiZhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view );
        make.top.mas_equalTo(zz.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(210));
    }];
    TSView *lbthree = [[TSView alloc] init];
    [self.backview addSubview:lbthree];
    lbthree.tslb.text = @"可上传驾校营业执照或其他资质图等照片";
    [lbthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(80));
        make.top.mas_equalTo(self.jiaoXueZiZhi.mas_bottom).mas_offset(-KFit_H6S(10));
    }];
    
    
    
    XLInformationV *pp =[[XLInformationV alloc] informationWithTitle:@"品牌认证" Subtitle:@"最多可上传3张" Must:NO];
    [self.backview addSubview:pp];
    [pp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbthree.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    self.jiaoXuePingPai = [[UploadPicturesV alloc] init];
    [self.backview addSubview:self.jiaoXuePingPai];
    self.jiaoXuePingPai.vc = self;
    self.jiaoXuePingPai.num = 3;
    [self.jiaoXuePingPai mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view );
        make.top.mas_equalTo(pp.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(210));
    }];
    TSView *lbfour = [[TSView alloc] init];
    [self.backview addSubview:lbfour];
    lbfour.tslb.text = @"可上传驾校品牌授权(加盟),品牌注册(连锁)等照片";
    [lbfour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(80));
        make.top.mas_equalTo(self.jiaoXuePingPai.mas_bottom).mas_offset(-KFit_H6S(10));
    }];
    
    
    XLInformationV *ry =[[XLInformationV alloc] informationWithTitle:@"驾校荣誉" Subtitle:@"最多可上传3张" Must:NO];
    [self.backview addSubview:ry];
    [ry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbfour.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    self.jiaoXueRongYu = [[UploadPicturesV alloc] init];
    [self.backview addSubview:self.jiaoXueRongYu];
    self.jiaoXueRongYu.vc = self;
    self.jiaoXueRongYu.num = 3;
    [self.jiaoXueRongYu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view );
        make.top.mas_equalTo(ry.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(210));
    }];
    
    TSView *lbfire = [[TSView alloc] init];
    [self.backview addSubview:lbfire];
    lbfire.tslb.text = @"可上传驾校获奖证书、锦旗等照片";
    [lbfire mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(80));
        make.top.mas_equalTo(self.jiaoXueRongYu.mas_bottom).mas_offset(-KFit_H6S(10));
    }];
    
}





- (void)laodCoutesView{
    
}


- (void)refreshData{
    [MBProgressHUD showLoadingHUD:@"正在加载"];
    //    NSString *url = POSTgGetEnrollInfoInfo;
    NSString *url1 = [NSString stringWithFormat:@"%@?id=%@",POSTTeamSchoolEnrollInfo,self.idid];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.idid forKey:@"id"];
//    [dic setObject:@"1" forKey:@"operaType"];
    [FMNetworkHelper fm_request_postWithUrlString:url1 isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"11111%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
//        self.scanPhotoIp = responseObject[@"scanPhotoIp"];
        self.model = [FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingHUD];
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
//    [FMNetworkHelper fm_request_getWithUrlString:url1 isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
//        
//        
//    } failureBlock:^(NSError *error) {
//        
//    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//        
//    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:KURLIma(_model.headImg)] placeholderImage:[UIImage imageNamed:@"head_nor"]];
    XLCache *cache = [XLCache singleton];
    self.admissions.name.subfield.text = _model.name;
    
//    self.admissions.gender.subfield.text = cache.sys_user_sex_title[[cache.sys_user_sex_value indexOfObject:_model.sex]];
//    self.admissions.gender.subfield.tag = [_model.sex integerValue];
//
    KKLog(@"%@",_model.schoolDeptId);
    self.admissions.school.subfield.text = cache.teamCode_title[[cache.schoolDeptId indexOfObject:_model.schoolDeptId]];
    self.admissions.school.subfield.tag = [_model.schoolDeptId integerValue];
    
//    self.admissions.seniority.subfield.text = _model.coachAge;
    
    self.admissions.phone.subfield.text = _model.enrollPhone;
    
    self.admissions.names.subfield.text = _model.deptName;
    KKLog(@"%@",_model.deptAddress);
    self.admissions.address.subfield.text = _model.detailAddress;
    self.textView.text = _model.introduce;
    self.course.dataArr = _model.classList;
    if (_model.url1 && ![_model.url1  isEqual: @""] && ![self.imgarr containsObject:_model.url1]) {
        [self.imgarr addObject:_model.url1];
        UIImageView *img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.scanPhotoIp,_model.url1]]];
        [self.imageviewArr addObject:img];
    }
    if (_model.url2&& ![_model.url2  isEqual: @""] && ![self.imgarr containsObject:_model.url2]) {
        [self.imgarr addObject:_model.url2];
        UIImageView *img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.scanPhotoIp,_model.url2]]];
        [self.imageviewArr addObject:img];
    }
    if (_model.url3&& ![_model.url3  isEqual: @""] && ![self.imgarr containsObject:_model.url3]) {
        [self.imgarr addObject:_model.url3];
        UIImageView *img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.scanPhotoIp,_model.url3]]];
        [self.imageviewArr addObject:img];
    }
    if (_model.url4 && ![_model.url4  isEqual: @""] && ![self.imgarr containsObject:_model.url4]) {
        [self.imgarr addObject:_model.url4];
        UIImageView *img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.scanPhotoIp,_model.url4]]];
        [self.imageviewArr addObject:img];
    }
    if (_model.url5&& ![_model.url5  isEqual: @""] && ![self.imgarr containsObject:_model.url5]) {
        [self.imgarr addObject:_model.url5];
        UIImageView *img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.scanPhotoIp,_model.url5]]];
        [self.imageviewArr addObject:img];
    }
    if (_model.url6&& ![_model.url6  isEqual: @""] && ![self.imgarr containsObject:_model.url6]) {
        [self.imgarr addObject:_model.url6];
        UIImageView *img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.scanPhotoIp,_model.url6]]];
        [self.imageviewArr addObject:img];
    }
    if (_model.url7&& ![_model.url7  isEqual: @""] && ![self.imgarr containsObject:_model.url7]) {
        [self.imgarr addObject:_model.url7];
        UIImageView *img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.scanPhotoIp,_model.url7]]];
        [self.imageviewArr addObject:img];
    }
    if (_model.url8&& ![_model.url8  isEqual: @""] && ![self.imgarr containsObject:_model.url8]) {
        [self.imgarr addObject:_model.url8];
        UIImageView *img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.scanPhotoIp,_model.url8]]];
        [self.imageviewArr addObject:img];
    }
    if (_model.url9&& ![_model.url9  isEqual: @""] && ![self.imgarr containsObject:_model.url9]) {
        [self.imgarr addObject:_model.url9];
        UIImageView *img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",self.scanPhotoIp,_model.url9]]];
        [self.imageviewArr addObject:img];
    }
    [self.course mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_keCheng.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(140) * _model.classList.count);
    }];
    if (_model.headImg.length > 1 ) {
        if (self.xuanChuan.dataArr.count < 1) {
            
            [self.xuanChuan.dataArr addObjectsFromArray:[_model.headImg componentsSeparatedByString:@","]];
            [self.xuanChuan relodData];
        }
    }
    if (self.jiaoXueHuanJing.dataArr.count < 1) {
        
        [self.jiaoXueHuanJing.dataArr addObjectsFromArray:self.imgarr];
        [self.jiaoXueHuanJing relodData];
    }
    
    if (_model.schoolAptitude.length > 1 ) {
        if (self.jiaoXueZiZhi.dataArr.count < 1) {
            
            [self.jiaoXueZiZhi.dataArr addObjectsFromArray:[_model.schoolAptitude componentsSeparatedByString:@","]];
            [self.jiaoXueZiZhi relodData];
        }
    }
    
    if (_model.brandAuthentication.length > 1 ) {
        if (self.jiaoXuePingPai.dataArr.count < 1) {
            
            [self.jiaoXuePingPai.dataArr addObjectsFromArray:[_model.brandAuthentication componentsSeparatedByString:@","]];
            [self.jiaoXuePingPai relodData];
        }
    }
    if (_model.schoolHonor.length > 1 ) {
        if (self.jiaoXueRongYu.dataArr.count < 1) {
            
            [self.jiaoXueRongYu.dataArr addObjectsFromArray:[_model.schoolHonor componentsSeparatedByString:@","]];
            [self.jiaoXueRongYu relodData];
        }
    }
    if (_model.teamSchoolTags.length > 1) {
        self.teamSchoolTags = [_model.teamSchoolTags componentsSeparatedByString:@","];
        self.schoolLb.dataArr = self.teamSchoolTags;
    }
    
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
//    [self loadimgview];
    
}
- (void)nextVC{
    if (self.admissions.phone.subfield.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请填写手机号"];
        return;
    }
    if (self.textView.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请填写驾校详情"];
        return;
    }
    if (self.jiaoXueHuanJing.dataArr.count < 1) {
        [MBProgressHUD showMsgHUD:@"请上传教学环境图"];
        return;
    }
    if (self.xuanChuan.dataArr.count < 1) {
        [MBProgressHUD showMsgHUD:@"请上传分校封面"];
        return;
    }
    if (self.schoolLb.dataArr.count < 1) {
        [MBProgressHUD showMsgHUD:@"请选择标签"];
        return;
    }
    if (self.course.dataArr.count < 1) {
        [MBProgressHUD showMsgHUD:@"请添加班型"];
        return;
    }
    NSString *url = POSTTeamSchoolEdit;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.idid forKey:@"id"];
    [dic setObject:self.admissions.name.subfield.text forKey:@"name"];
//    [dic setObject:[NSString stringWithFormat:@"%ld",self.admissions.gender.subfield.tag] forKey:@"sex"];
    [dic setObject:[NSString stringWithFormat:@"%ld",self.admissions.school.subfield.tag] forKey:@"schoolDeptId"];
//    [dic setObject:self.admissions.seniority.subfield.text forKey:@"coachAge"];
    [dic setObject:self.admissions.phone.subfield.text forKey:@"enrollPhone"];
    [dic setObject:self.admissions.names.subfield.text forKey:@"deptName"];
    [dic setObject:self.admissions.address.subfield.text forKey:@"detailAddress"];
    [dic setObject:self.textView.text forKey:@"introduce"];
    [dic setObject:self.admissions.school.subfield.text forKey:@"schoolName"];
//    [dic setObject:self.admissions.names.subfield.text forKey:@"deptName"];
    
    [dic setObject:[self.jiaoXueZiZhi.dataArr componentsJoinedByString:@","] forKey:@"schoolAptitude"];
    [dic setObject:[self.jiaoXuePingPai.dataArr componentsJoinedByString:@","] forKey:@"brandAuthentication"];
    [dic setObject:[self.jiaoXueRongYu.dataArr componentsJoinedByString:@","] forKey:@"schoolHonor"];
    [dic setObject:[self.schoolLb.dataArr componentsJoinedByString:@","] forKey:@"teamSchoolTags"];
//    [dic setObject:[self.jiaoXueZiZhi.dataArr componentsJoinedByString:@","] forKey:@""];
    
    [dic setObject:self.model.teamSchoolId forKey:@"teamSchoolId"];
//    if (self.xuanChuan.dataArr.count > 0 ) {
        [dic setObject:[self.xuanChuan.dataArr firstObject] forKey:@"headImg"];
//    }
    
    [dic setObject:@"" forKey:@"url1"];
    [dic setObject:@"" forKey:@"url2"];
    [dic setObject:@"" forKey:@"url3"];
    [dic setObject:@"" forKey:@"url4"];
    [dic setObject:@"" forKey:@"url5"];
    [dic setObject:@"" forKey:@"url6"];
    [dic setObject:@"" forKey:@"url7"];
    [dic setObject:@"" forKey:@"url8"];
    [dic setObject:@"" forKey:@"url9"];
    [dic setObject:self.province[@"name"] forKey:@"provice"];
    [dic setObject:self.city[@"name"] forKey:@"city"];
    [dic setObject:self.areadic[@"name"] forKey:@"county"];
    [dic setObject:[NSString stringWithFormat:@"%f",self.latitude] forKey:@"latitude"];
    [dic setObject:[NSString stringWithFormat:@"%f",self.longitude] forKey:@"longitude"];
    for (int i = 0; i <self.jiaoXueHuanJing.dataArr.count; i++) {
        NSString *key = [NSString stringWithFormat:@"url%d",(i + 1)];
        [dic setObject:self.jiaoXueHuanJing.dataArr[i] forKey:key];
    }
    
    [MBProgressHUD showLoadingHUD:@"正在提交保存"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"11111%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if ([responseObject[@"code"] intValue] == 200) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"保存成功" SuccessOrFailure:YES];
            [alert showPrompt];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingHUD];
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    //    [dic setObject:<#(nonnull id)#> forKey:@"name"];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)viewDidLayoutSubviews{
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
}

- (void)GDSearchMapVCDelegateWith:(AMapPOI *)amapPOI And:(nonnull AMapReGeocodeSearchResponse *)response{
    KKLog(@"%@",amapPOI);
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(amapPOI.location.latitude,amapPOI.location.longitude);//纬度，经度
    self.latitude = amapPOI.location.latitude;
    self.longitude = amapPOI.location.longitude;
    self.province = @{@"name":response.regeocode.addressComponent.province};
    self.city = @{@"name":response.regeocode.addressComponent.city};
    self.areadic = @{@"name":response.regeocode.addressComponent.district};
    self.admissions.address.subfield.text = amapPOI.address;
}
- (void)GDSearchMapVCDelegateWithAddressComponent:(AMapReGeocodeSearchResponse *)response And:(AMapPOI *)amapPOI{
    KKLog(@"%@",response);
    self.province = @{@"name":response.regeocode.addressComponent.province};
    self.city = @{@"name":response.regeocode.addressComponent.city};
    self.areadic = @{@"name":response.regeocode.addressComponent.district};
//    self.address.subfield.text =response.regeocode.formattedAddress;
    NSInteger n = response.regeocode.addressComponent.province.length + response.regeocode.addressComponent.city.length + response.regeocode.addressComponent.district.length;
    self.admissions.address.subfield.text = [response.regeocode.formattedAddress substringFromIndex:n];
    self.latitude = amapPOI.location.latitude;
    self.longitude = amapPOI.location.longitude;
}


@end
