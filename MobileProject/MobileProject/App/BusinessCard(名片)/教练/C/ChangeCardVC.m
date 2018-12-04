//
//  ChangeCardVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ChangeCardVC.h"
#import "FormsV.h"
#import "XLInformationV.h"
#import "CourseV.h"
#import "TemplateV.h"
#import "XLCache.h"
#import "UploadPicturesV.h"
#import "CGXPickerView.h"
#define BUT_W KFit_W6S(150)
@interface ChangeCardVC ()<UIImagePickerControllerDelegate>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)UIImageView *headImg;
@property (nonatomic , strong)AdmissionsFormsV *admissions;
@property (nonatomic , strong)CourseFormsV *course;
@property (nonatomic , strong)NSMutableArray *couresArr;

@property (nonatomic , strong)XLView *imgBackView;
@property (nonatomic , strong)UIButton *add_photo;
@property (nonatomic ,strong)NSMutableArray *imgarr;
@property (nonatomic , strong)UIButton *UpAttachment;
@property (nonatomic ,strong)NSMutableArray *butarr;
@property (nonatomic ,strong)XLInformationV *keCheng;
@property (nonatomic ,strong)XLInformationV *environment;
@property (nonatomic ,strong)NSString *scanPhotoIp;  //图片头
@property (nonatomic , strong)NSMutableArray *imageviewArr;


@property (nonatomic , strong)UploadPicturesV *jiaoXueHuanJing;
@property (nonatomic , strong)UploadPicturesV *jiaoXueRongYu;
@property (nonatomic , strong)UploadPicturesV *jiaoXueChengGuo;
@property (nonatomic ,strong)XLInformationV *istuiguang;
@property (nonatomic , assign)NSInteger tuguang;
@end

@implementation ChangeCardVC

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
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
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
    
    UIView *v = [[UIView alloc] init];
    [self.backview addSubview:v];
    v.backgroundColor = [UIColor whiteColor];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(jiBenZiLiao.mas_bottom);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(160));
    }];
    
    UILabel *head = [[UILabel alloc] init];
    [self.backview addSubview:head];
    head.text = @"头像";
    [head mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backview).mas_equalTo(KFit_W6S(30));
        make.top.mas_equalTo(jiBenZiLiao.mas_bottom).mas_offset(KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(220), KFit_W6S(40)));
    }];
    
    
    self.headImg = [[UIImageView alloc] init];
    self.headImg.userInteractionEnabled = YES;
    [self.backview addSubview:self.headImg];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUp)];
    // 允许用户交互
    [self.headImg addGestureRecognizer:tap];
    
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(jiBenZiLiao.mas_bottom).mas_offset(KFit_H6S(20));
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(120), KFit_W6S(120)));
    }];
    self.headImg.layer.cornerRadius = KFit_W6S(60);
    self.headImg.layer.masksToBounds = YES;
   
    
    self.admissions = [[AdmissionsFormsV alloc] init];
    [self.backview addSubview:self.admissions];
    self.admissions.backgroundColor = [UIColor whiteColor];
    [self.admissions mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(720));
    }];
    
    kWeakSelf(self)
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
        CourseV *v = [[CourseV alloc] initWithDictionary:weakself.model.classList[tag]];
        v.vc = weakself;
        v.idid = weakself.model.idid;
        [v show];
    };
//    KKLog(@"kecheng ::::%@",_model.classList);
    [self.backview addSubview:self.course];
    [self.course mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_keCheng.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(140) * _model.classList.count);
    }];
    
    
    XLInformationV *introduce = [[XLInformationV alloc] informationWithTitle:@"自我介绍" ButTile:@"选择模板" ButImg:nil];
    [self.backview addSubview:introduce];
    introduce.senterBlock = ^{
        TemplateV *v = [[TemplateV alloc] init];
        v.vc = weakself;
        [v show];
    };
    [introduce mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.course.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    UIView *inqutBack = [[UIView alloc] init];
    [self.backview addSubview:inqutBack];
    inqutBack.backgroundColor = [UIColor whiteColor];
    [inqutBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(introduce.mas_bottom).mas_offset(1);
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
    
    _environment = [[XLInformationV alloc] informationWithTitle:@"教学环境" Subtitle:@"最多可上传9张" Must:YES];
    [self.backview addSubview:_environment];
    [_environment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inqutBack.mas_bottom).mas_offset(KFit_H6S(20));
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
    
    XLInformationV *ry =[[XLInformationV alloc] informationWithTitle:@"驾校荣誉" Subtitle:@"最多可上传3张" Must:NO];
    [self.backview addSubview:ry];
    [ry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jiaoXueHuanJing.mas_bottom).mas_offset(KFit_H6S(20));
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
    
    
    XLInformationV *cg =[[XLInformationV alloc] informationWithTitle:@"教练成果" Subtitle:@"最多可上传3张" Must:NO];
    [self.backview addSubview:cg];
    [cg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.jiaoXueRongYu.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    self.jiaoXueChengGuo = [[UploadPicturesV alloc] init];
    [self.backview addSubview:self.jiaoXueChengGuo];
    self.jiaoXueChengGuo.vc = self;
    self.jiaoXueChengGuo.num = 3;
    [self.jiaoXueChengGuo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view );
        make.top.mas_equalTo(cg.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(210));
    }];
    
//    kWeakSelf(self)
    self.istuiguang = [[XLInformationV alloc] informationWithTitle:@"学员端推广" SubTitle:@"" TSSubTitle:@"" Must:NO Click:YES];
    self.istuiguang.backgroundColor = [UIColor whiteColor];
    [self.backview addSubview:self.istuiguang];
    [self.istuiguang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(self.jiaoXueChengGuo.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    self.istuiguang.senterBlock = ^{
        [weakself.view endEditing:YES];
        [CGXPickerView showStringPickerWithTitle:@"是否在学员端推广" DataSource:@[@"否",@"是"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            NSLog(@"%@",selectValue);
            weakself.istuiguang.subfield.text = selectValue;
            weakself.tuguang = [selectRow integerValue];
        }];
    };
    KKLog(@"%@",self.model.isShow);
    
//    self.imgBackView = [[XLView alloc] init];
//    self.imgBackView.backgroundColor = [UIColor whiteColor];
//    [self.backview addSubview:self.imgBackView];
//
//
//
//    [self.imgBackView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.backview);
//        make.top.mas_equalTo(_environment.mas_bottom).mas_offset(1);
//        make.height.mas_equalTo([self.imgBackView getLayoutCellHeightWithFlex:KFit_H6S(30)]);
//    }];
    
    
    
}

- (void)viewDidLayoutSubviews{
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
}



- (void)laodCoutesView{
    
}


- (void)refreshData{

//    NSString *url = POSTgGetEnrollInfoInfo;
//    NSString *url1 = [NSString stringWithFormat:@"%@?id=%@&operaType=1",POSTgGetEnrollInfoInfo,self.idid];
//    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
//    [dic setObject:self.idid forKey:@"id"];
//    [dic setObject:@"1" forKey:@"operaType"];
//
//    [FMNetworkHelper fm_request_getWithUrlString:url1 isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
//        KKLog(@"%@",responseObject);
//        self.scanPhotoIp = responseObject[@"scanPhotoIp"];
//        self.model = [FMMainModel mj_objectWithKeyValues:responseObject[@"enrollInfo"]];
//
//    } failureBlock:^(NSError *error) {
//
//    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
//
//    }];
    User *uer = [User UserOb];
    KKLog(@"%@",uer.userId);
    NSString *url = [NSString stringWithFormat:POSTCoachEnrollInfo,[User UserOb].userId];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            self.scanPhotoIp = responseObject[@"scanPhotoIp"];
            FMMainModel *model = [FMMainModel mj_objectWithKeyValues:responseObject[@"data"]];
            self.model = model;
            
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:KURLIma(self.model.headPic)] placeholderImage:[UIImage imageNamed:@"head_nor"]];
    XLCache *cache = [XLCache singleton];
    self.admissions.name.subfield.text = _model.name;
    
    self.admissions.gender.subfield.text = cache.sys_user_sex_title[[cache.sys_user_sex_value indexOfObject:_model.sex]];
    self.admissions.gender.subfield.tag = [_model.sex integerValue];
    
    KKLog(@"%@",_model.schoolDeptId);
//    self.admissions.school.subfield.text = cache.teamCode_title[[cache.schoolDeptId indexOfObject:_model.schoolDeptId]];
    self.admissions.school.subfield.text = _model.schoolName;
    self.admissions.school.subfield.tag = [_model.schoolDeptId integerValue];
    
    self.admissions.seniority.subfield.text = _model.coachAge;
    
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
    if (self.jiaoXueHuanJing.dataArr.count < 1) {
        
        [self.jiaoXueHuanJing.dataArr addObjectsFromArray:self.imgarr];
        [self.jiaoXueHuanJing relodData];
    }
    if (_model.coachHonor.length > 1 ) {
        if (self.jiaoXueRongYu.dataArr.count < 1) {
            [self.jiaoXueRongYu.dataArr addObjectsFromArray:[_model.coachHonor componentsSeparatedByString:@","]];
            [self.jiaoXueRongYu relodData];
        }
    }
    if ([_model.isShow integerValue] == 2) {
        self.istuiguang.subfield.text = @"是";
        self.tuguang = 1;
    }else{
        self.istuiguang.subfield.text = @"否";
        self.tuguang = 0;
    }
    if (_model.teachHarvest.length > 1 ) {
        if (self.jiaoXueChengGuo.dataArr.count < 1) {
            [self.jiaoXueChengGuo.dataArr addObjectsFromArray:[_model.teachHarvest componentsSeparatedByString:@","]];
            [self.jiaoXueChengGuo relodData];
        }
    }
    
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
    
}
- (void)nextVC{
    
    if (self.tuguang == 1) {
        if (self.jiaoXueHuanJing.dataArr.count < 1) {
            [MBProgressHUD showMsgHUD:@"请上传教学环境图"];
            return;
        }
        if (self.course.dataArr.count < 1) {
            [MBProgressHUD showMsgHUD:@"请添加班型"];
            return;
        }
        if (self.textView.text.length < 1) {
            [MBProgressHUD showMsgHUD:@"请添加自我介绍"];
            return;
        }
        if (self.admissions.seniority.subfield.text.length < 1) {
            [MBProgressHUD showMsgHUD:@"请填写教龄"];
            return;
        }
    }
    NSString *url = POSTEnrollInfoEdit;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.idid forKey:@"id"];
    [dic setObject:[NSString stringWithFormat:@"%ld",self.admissions.gender.subfield.tag] forKey:@"sex"];
    [dic setObject:self.admissions.seniority.subfield.text forKey:@"coachAge"];
    [dic setObject:self.textView.text forKey:@"introduce"];
    [dic setObject:@"" forKey:@"url1"];
    [dic setObject:@"" forKey:@"url2"];
    [dic setObject:@"" forKey:@"url3"];
    [dic setObject:@"" forKey:@"url4"];
    [dic setObject:@"" forKey:@"url5"];
    [dic setObject:@"" forKey:@"url6"];
    [dic setObject:@"" forKey:@"url7"];
    [dic setObject:@"" forKey:@"url8"];
    [dic setObject:@"" forKey:@"url9"];
    [dic setObject:self.model.coachId forKey:@"coachId"];
    for (int i = 0; i <self.jiaoXueHuanJing.dataArr.count; i++) {
        NSString *key = [NSString stringWithFormat:@"url%d",(i + 1)];
        [dic setObject:self.jiaoXueHuanJing.dataArr[i] forKey:key];
    }
    [dic setObject:[self.jiaoXueChengGuo.dataArr componentsJoinedByString:@","] forKey:@"teachHarvest"];
    [dic setObject:[self.jiaoXueRongYu.dataArr componentsJoinedByString:@","] forKey:@"coachHonor"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)self.tuguang] forKey:@"isCheck"];
    
    [dic setObject:self.model.schoolDeptId forKey:@"schoolDeptId"];
    [dic setObject:self.model.deptId forKey:@"deptId"];
    
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

- (void)changeUp{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请选择添加途径" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //        NSLog(@"取消");
        [self PhotoLibrary];
    }];
    
    UIAlertAction *cancelBtXJ = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self xiangji];
        NSLog(@"取消");
        
    }];
    //添加确定
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定");
        
    }];
    //设置`确定`按钮的颜色
    //    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    //将action添加到控制器
    [alertVc addAction:cancelBtn];
    [alertVc addAction:cancelBtXJ];
    [alertVc addAction :sureBtn];
    //展示
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
}


///
- (void)xiangji{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView * alerr = [[UIAlertView alloc]initWithTitle:@"警告!" message:@"未找到该硬件设备或设备已损坏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alerr show];
    }else{
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.allowsEditing = YES;
    }
    //利用模态进行调用系统框架
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    
}
//照片库
- (void)PhotoLibrary{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = YES;
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];;
}

#pragma mark -相册代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    KKLog(@"%@    ----- %@",picker,info);
    [self uploadPictures:info[UIImagePickerControllerEditedImage]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)uploadPictures:(UIImage *)image{
    [MBProgressHUD showLoadingHUD:@"正在上传图片"];
    
    
    NSString *url = POSTUpLoadFile;
    
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[User UserOb].token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:@"Mobile" forHTTPHeaderField:@"loginType"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.1) name:@"file" fileName:@"tupian.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功返货=============%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic =responseObject[@"data"][@"data"];
            //            [self.imgarr addObject:dic[@"url"]];
            [self chengHeader:dic[@"url"]];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideLoadingHUD];
    }];
}




- (void)chengHeader:(NSString *)img{
    NSString *url;
    NSDictionary *dic;
    if (USERFZR) {
        url = [NSString stringWithFormat:POSTUpdateTeamUserHeadImg,img];
    }else{
        url = POSTUpdateCoach;
        dic = @{@"headPic":img};
    }
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:KURLIma(img) forKey:@"teamUserHead"];
            [defaults synchronize];
            [User UserOb].teamUserHead = KURLIma(img);
            [self.headImg sd_setImageWithURL:[NSURL URLWithString:KURLIma(img)] placeholderImage:[UIImage imageNamed:@"touxiang_nor"]];
            
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}


@end
