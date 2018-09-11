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
#define BUT_W KFit_W6S(150)
@interface ChangeCardVC ()<UIImagePickerControllerDelegate>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)UIImageView *headImg;
@property (nonatomic , strong)AdmissionsFormsV *admissions;
@property (nonatomic , strong)CourseFormsV *course;
@property (nonatomic , strong)NSMutableArray *couresArr;
@property (nonatomic , strong)UITextView *textView;
@property (nonatomic , strong)XLView *imgBackView;
@property (nonatomic , strong)UIButton *add_photo;
@property (nonatomic ,strong)NSMutableArray *imgarr;
@property (nonatomic , strong)UIButton *UpAttachment;
@property (nonatomic ,strong)NSMutableArray *butarr;
@property (nonatomic ,strong)XLInformationV *keCheng;
@property (nonatomic ,strong)NSString *scanPhotoIp;  //图片头
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
    XLInformationV *jiBenZiLiao = [[XLInformationV alloc] informationWithTitle:@"基本资料"];
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
    [self.backview addSubview:self.headImg];
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
        CourseV *v = [[CourseV alloc] initWithDictionary:_model.classList[tag]];
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
    
    XLInformationV *environment = [[XLInformationV alloc] informationWithTitle:@"教学环境图" ButTile:nil ButImg:nil];
    [self.backview addSubview:environment];
    [environment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inqutBack.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
    }];
    
    self.imgBackView = [[XLView alloc] init];
    self.imgBackView.backgroundColor = [UIColor whiteColor];
    [self.backview addSubview:self.imgBackView];
    
    self.UpAttachment=[[UIButton alloc]initWithFrame:CGRectMake(KFit_W6S(30), KFit_W6S(30), BUT_W, BUT_W)];
    [self.UpAttachment setImage:[UIImage imageNamed:@"add_photo"] forState:UIControlStateNormal];
    [self.UpAttachment addTarget:self action:@selector(PhotoLibrary) forControlEvents:UIControlEventTouchUpInside];
    [self.imgBackView addSubview:self.UpAttachment];
    
//    se
    
    [self.imgBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(environment.mas_bottom).mas_offset(1);
        make.height.mas_equalTo([self.imgBackView getLayoutCellHeightWithFlex:KFit_H6S(30)]);
    }];
    
    
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
}
#pragma mark - 要上传的图片显示；
- (void)loadimgview{
    int j=0;
    for (int i=0; i<self.imgarr.count; i++) {
        UIImageView *imgv= [[UIImageView alloc] init];
        NSString *str = [NSString stringWithFormat:@"%@%@",self.scanPhotoIp,self.imgarr[i]];
        KKLog(@"tupian dizhi : %@",str);
        [imgv sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"lb-jiazaitu"]];
        imgv.frame=CGRectMake(i%3*(KFit_W6S(20)+BUT_W)+ KFit_W6S(30),i/3*(KFit_W6S(20)+BUT_W)+ KFit_W6S(30), BUT_W, BUT_W);;
        [self.imgBackView addSubview:imgv];
        
        /*删除按钮 */
        UIButton *but=[[UIButton alloc]init];
        [self.backview addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imgv).mas_offset(-KFit_H6S(15));
            make.left.mas_equalTo(imgv.mas_right).mas_offset(-KFit_H6S(15));
            make.width.height.mas_equalTo(KFit_H6S(30));
        }];
        [but setImage:[UIImage imageNamed:@"icon_delet"] forState:UIControlStateNormal];
        but.tag=i;
        [but addTarget:self action:@selector(deleteimgdata:) forControlEvents:UIControlEventTouchUpInside];
        [self.butarr addObject:but];
        j++;
    }
    self.UpAttachment.frame=CGRectMake(j%3*(KFit_W6S(20)+BUT_W) + KFit_W6S(30),j/3*(KFit_W6S(20)+BUT_W)+ KFit_W6S(30), BUT_W, BUT_W);
    self.UpAttachment.hidden=NO;
    
}
#pragma mark -删除图片和数据
- (void)deleteimgdata:(UIButton *)sender{
    [self.imgarr removeObjectAtIndex:sender.tag];
    [self loadimgview];
}


//照片库
- (void)PhotoLibrary{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];;
}

#pragma mark -相册代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    KKLog(@"%@    ----- %@",picker,info);
    [self uploadPictures:info[UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)uploadPictures:(UIImage *)image{
    [MBProgressHUD showLoadingHUD:@"正在上传图片"];
    
//    [FMNetworkHelper fm_setValue:[User UserOb].token forHTTPHeaderKey:@"token"];
//    [FMNetworkHelper fm_setValue:@"Mobile" forHTTPHeaderKey:@"loginType"];
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
            [self.imgarr addObject:dic[@"url"]];
//            [self.imgarr addObject:dic[@"img"]];
            [self loadimgview];
           
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideLoadingHUD];
    }];
}







- (void)laodCoutesView{
    
}


- (void)refreshData{
    [FMNetworkHelper fm_setValue:[User UserOb].token forHTTPHeaderKey:@"token"];
    [FMNetworkHelper fm_setValue:@"Mobile" forHTTPHeaderKey:@"loginType"];
//    NSString *url = POSTgGetEnrollInfoInfo;
    NSString *url1 = [NSString stringWithFormat:@"%@?id=%@&operaType=1",POSTgGetEnrollInfoInfo,self.idid];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.idid forKey:@"id"];
    [dic setObject:@"1" forKey:@"operaType"];
    
    [FMNetworkHelper fm_request_getWithUrlString:url1 isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        self.scanPhotoIp = responseObject[@"scanPhotoIp"];
        self.model = [FMMainModel mj_objectWithKeyValues:responseObject[@"enrollInfo"]];
        
    } failureBlock:^(NSError *error) {
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:_model.headImg] placeholderImage:[UIImage imageNamed:@"pacture_nor"]];
    XLCache *cache = [XLCache singleton];
    self.admissions.name.subfield.text = _model.name;
    
    self.admissions.gender.subfield.text = cache.sys_user_sex_title[[cache.sys_user_sex_value indexOfObject:_model.sex]];
    self.admissions.gender.subfield.tag = [_model.sex integerValue];
    
    KKLog(@"%@",_model.schoolDeptId);
    self.admissions.school.subfield.text = cache.teamCode_title[[cache.teamCode_value indexOfObject:_model.schoolDeptId]];
    self.admissions.school.subfield.tag = [_model.schoolDeptId integerValue];
    
    self.admissions.seniority.subfield.text = _model.coachAge;
    
    self.admissions.phone.subfield.text = _model.enrollPhone;
    
    self.admissions.names.subfield.text = _model.deptName;
    
    self.admissions.address.subfield.text = _model.deptAddress;
    self.textView.text = _model.introduce;
    self.course.dataArr = _model.classList;
    if (_model.url1) {
        [self.imgarr addObject:_model.url1];
    }
    if (_model.url2) {
        [self.imgarr addObject:_model.url2];
    }
    if (_model.url3) {
        [self.imgarr addObject:_model.url4];
    }
    if (_model.url4) {
        [self.imgarr addObject:_model.url4];
    }
    if (_model.url5) {
        [self.imgarr addObject:_model.url5];
    }
    if (_model.url6) {
        [self.imgarr addObject:_model.url6];
    }
    if (_model.url7) {
        [self.imgarr addObject:_model.url7];
    }
    if (_model.url8) {
        [self.imgarr addObject:_model.url8];
    }
    if (_model.url9) {
        [self.imgarr addObject:_model.url9];
    }
    [self.course mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_keCheng.mas_bottom).mas_offset(1);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(140) * _model.classList.count);
    }];
    [self loadimgview];
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
}
- (void)nextVC{
    [FMNetworkHelper fm_setValue:[User UserOb].token forHTTPHeaderKey:@"token"];
    [FMNetworkHelper fm_setValue:@"Mobile" forHTTPHeaderKey:@"loginType"];
    NSString *url = POSTEnrollInfoEdit;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.model.idid forKey:@"id"];
    [dic setObject:self.admissions.name.subfield.text forKey:@"name"];
    [dic setObject:[NSString stringWithFormat:@"%ld",self.admissions.gender.subfield.tag] forKey:@"sex"];
    [dic setObject:[NSString stringWithFormat:@"%ld",self.admissions.school.subfield.tag] forKey:@"schoolDeptId"];
    [dic setObject:self.admissions.seniority.subfield.text forKey:@"coachAge"];
    [dic setObject:self.admissions.phone.subfield.text forKey:@"enrollPhone"];
    [dic setObject:self.admissions.names.subfield.text forKey:@"deptName"];
    [dic setObject:self.admissions.address.subfield.text forKey:@"deptAddress"];
    [dic setObject:self.textView.text forKey:@"introduce"];
    for (int i = 0; i <self.imgarr.count; i++) {
        NSString *key = [NSString stringWithFormat:@"url%d",(i + 1)];
        [dic setObject:_imgarr[i] forKey:key];
    }
    [MBProgressHUD showLoadingHUD:@"正在提交保存"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"11111%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if ([responseObject[@"code"] intValue] == 200) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"保存成功" SuccessOrFailure:YES];
            [alert showPrompt];
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

@end
