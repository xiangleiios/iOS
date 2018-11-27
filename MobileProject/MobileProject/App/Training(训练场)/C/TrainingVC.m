//
//  TrainingVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/17.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "TrainingVC.h"
#import "XLInformationV.h"
#import "CGXPickerView.h"
#import "XLCache.h"
#import "AddressV.h"
#import "AllCoachLBV.h"
#import "GDMapVC.h"
#import "GDSearchMapVC.h"
@interface TrainingVC ()<GDSearchMapVCDelegate,AMapSearchDelegate>
@property (nonatomic , strong)XLInformationV *school;
@property (nonatomic , strong)XLInformationV *fenXiao;
@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)XLInformationV *area;
@property (nonatomic , strong)XLInformationV *address;
@property (nonatomic , strong)UIButton *choose;
@property (nonatomic, strong)AMapSearchAPI *search;
@property (nonatomic , assign)CGFloat latitude;///纬度
@property (nonatomic , assign)CGFloat longitude;///经度
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@end

@implementation TrainingVC
- (NSMutableArray *)selectArr{
    if (_selectArr == nil) {
        _selectArr = [NSMutableArray array];
    }
    return _selectArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    [self loadSubview];
    [self loadBut];
    // Do any additional setup after loading the view.
}
#pragma mark - 导航相关
- (void)laodNavigation{
    kWeakSelf(self)
    self.choose = [self.navigationView addRightButtonWithTitle:@"删除" clickCallBack:^(UIView *view) {
        [weakself delectTrain];
    }];
    [self.choose setTitleColor:kColor_N(0, 112, 234) forState:UIControlStateNormal];
    self.choose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
}
- (void)loadBut{
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
//    [next setTitle:@"保存" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(toSave) forControlEvents:UIControlEventTouchUpInside];
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
    
    if (self.type) {
        [next setTitle:@"保存" forState:UIControlStateNormal];
    }else{
        [next setTitle:@"保存" forState:UIControlStateNormal];
    }
}


- (void)loadSubview{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
    
    self.backview = [[XLView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scroll addSubview:self.backview];
    
    
    UIView *v = [[UIView alloc] init];
    [self.backview addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(630));
    }];
    
    kWeakSelf(self)
    XLInformationV *baokao = [[XLInformationV alloc] informationWithTitle:@"基本信息"];
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    NSArray *arrname = (NSArray *)[defaults objectForKey:SchoolList];
    self.school = [[XLInformationV alloc] informationWithTitle:@"所属总校" SubTitle:@"" TSSubTitle:@"请选择总校" Must:YES Click:YES];
    
    self.fenXiao = [[XLInformationV alloc] informationWithTitle:@"所属分校" SubTitle:@"" TSSubTitle:@"请选择分校" Must:YES Click:NO];
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
    
    
    
    
    self.name = [[XLInformationV alloc] informationWithTitle:@"训练场名称" SubTitle:@"" TSSubTitle:@"请输入训练场名称" Must:YES Click:NO];
    self.area = [[XLInformationV alloc] informationWithTitle:@"训练场区域" SubTitle:@"" TSSubTitle:@"请选择区域" Must:YES Click:YES];
    self.area.senterBlock = ^{
        [weakself.view endEditing:YES];
        GDSearchMapVC *vc = [[GDSearchMapVC alloc] init];
        vc.delegate = weakself;
        [weakself.navigationController pushViewController:vc animated:YES];
//        AddressV *v = [[AddressV alloc] init];
//        v.vc = weakself;
//        [v show];
    };
    self.address = [[XLInformationV alloc] informationWithTitle:@"详细地址" SubTitle:@"" TSSubTitle:@"请输入训练场详细地址" Must:YES Click:NO];
    
    XLInformationV *jiaol = [[XLInformationV alloc] informationWithTitle:@"分配教练" SubTitle:@"" TSSubTitle:@"" Must:YES Click:NO];
    jiaol.userInteractionEnabled = NO;
    
    
    [v addSubview:baokao];
    [v addSubview:self.school];
    [v addSubview:self.fenXiao];
    [v addSubview:self.name];
    [v addSubview:self.area];
    [v addSubview:self.address];
    [v addSubview:jiaol];
    NSArray *arr = @[baokao,self.school,self.fenXiao,self.name,self.area,self.address,jiaol];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(v);
    }];
    if (self.model) {
        XLCache *cache = [XLCache singleton];
        self.name.subfield.text = _model.teamTrainingName;
        self.province = @{@"name":_model.province};
        self.city = @{@"name":_model.city};
        self.areadic = @{@"name":_model.area};
        self.address.subfield.text = _model.address;
        self.latitude = _model.latitude;
        self.longitude = _model.latitude;
        self.school.subfield.text = cache.teamCode_title[[cache.teamCode_value indexOfObject:_model.teamSchoolId]];
        self.school.subfield.tag = [_model.teamSchoolId integerValue];
        self.fenXiao.subfield.text = _model.teamSchoolName;
    }
    if (self.type == 0) {
        kWeakSelf(self)
        UIButton * choose = [self.navigationView addRightButtonWithTitle:@"删除" clickCallBack:^(UIView *view) {
            [weakself delectTrain];
            
        }];
        [choose setTitleColor:kColor_N(0, 112, 234) forState:UIControlStateNormal];
        choose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    
    XLView *bg = [[XLView alloc] init];
    bg.backgroundColor = [UIColor whiteColor];
    [self.backview addSubview:bg];
    [bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(v.mas_bottom).mas_offset(-1);
        make.height.mas_equalTo(KFit_H6S(450));
    }];
    float w = KFit_W6S(160);
    float h = KFit_H6S(55);
    for (int i = 0 ; i < self.coachArr.count ; i++) {
        FMCoachModel * model = self.coachArr[i];
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(KFit_W6S(30) + i%4*(w +KFit_W6S(15)), i/4*(h + KFit_H6S(15)), w, h)];
        [bg addSubview:but];
        but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(15)];
        but.tag = i;
        [but setTitle:model.coachName forState:UIControlStateNormal];
        [but setTitleColor:ZTColor forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [but setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateSelected];
        but.layer.cornerRadius = 3;
        but.layer.masksToBounds = YES;
        but.layer.borderColor = ZTColor.CGColor;
        but.layer.borderWidth = 0.5;
        [self.selectArr addObject:but];
        [but addTarget:self action:@selector(butselect:) forControlEvents:UIControlEventTouchUpInside];
        for (NSString *str in self.model.coachIds) {
            if ([str integerValue] == [model.idid integerValue]) {
                but.selected = YES;
            }
        }
    }
    [bg mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo([bg getLayoutCellHeightWithFlex:KFit_H6S(20)]);
    }];
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
}
- (void)butselect:(UIButton *)senter{
    senter.selected = !senter.selected;
}
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
    self.area.subfield.text = [NSString stringWithFormat:@"%@-%@-%@",_province[@"name"],_city[@"name"],_areadic[@"name"]];
    KKLog(@"%@",_area);
}

- (void)setModel:(FMMainModel *)model{
    _model = model;
    
}
- (void)toSave{
    if (self.name.subfield.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请填写训练场名称"];
        return;
    }
    if (self.name.subfield.text.length > 10) {
        [MBProgressHUD showMsgHUD:@"训练场名称不能大于10个字符"];
        return;
    }
    if (self.address.subfield.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请填写训练场详细地址"];
        return;
    }
    if (self.area.subfield.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请选择训练场详区域"];
        return;
    }
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.selectArr.count; i ++) {
        UIButton *but = self.selectArr[i];
        if (but.selected) {
            FMCoachModel *model = self.coachArr[i];
            [arr addObject:model.idid];
        }
    }
    if (arr.count < 1) {
        [MBProgressHUD showMsgHUD:@"绑定教练"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.province[@"name"] forKey:@"province"];
    [dic setObject:self.city[@"name"] forKey:@"city"];
    [dic setObject:self.areadic[@"name"] forKey:@"area"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)self.school.subfield.tag] forKey:@"teamSchoolId"];
    [dic setObject:self.name.subfield.text forKey:@"teamTrainingName"];
    [dic setObject:self.address.subfield.text forKey:@"address"];
    [dic setObject:[NSString stringWithFormat:@"%f",self.latitude] forKey:@"latitude"];
    [dic setObject:[NSString stringWithFormat:@"%f",self.longitude] forKey:@"longitude"];
    [dic setObject:arr forKey:@"coachIds"];

    NSString *url;
    if (self.type) {
        url =POSTAddTeamtraining;//新增
        [dic setObject:@"0" forKey:@"status"];
//        status=0
    }else{
        url =POSTEditTeamtraining;//编辑
        [dic setObject:self.model.teamTrainingId forKey:@"teamTrainingId"];
        [dic setObject:@"0" forKey:@"status"];
    }
    [MBProgressHUD showLoadingHUD:@"正在保存"];
    
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        [MBProgressHUD hideHUD];
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showMsgHUD:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        [MBProgressHUD hideHUD];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)delectTrain{
    XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:@"是否删除" sureBtn:@"确定" cancleBtn:@"取消"];
    [alert showXLAlertView];
    alert.resultIndex = ^(NSInteger index) {
        KKLog(@"%ld",(long)index);
        if (index == 2) {
            NSString *url = [NSString stringWithFormat:POSTRemoveTeamtraining,_model.teamTrainingId];
            [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
                [MBProgressHUD hideHUD];
                KKLog(@"%@",responseObject);
                if (kResponseObjectStatusCodeIsEqual(200)) {
                    [MBProgressHUD showMsgHUD:@"删除成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [MBProgressHUD showMsgHUD:responseObject[@"message"]];
                }
            } failureBlock:^(NSError *error) {
                KKLog(@"%@", error);
                [MBProgressHUD hideHUD];
            } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                
            }];
        }
    };
    
}

- (void)GDSearchMapVCDelegateWith:(AMapPOI *)amapPOI And:(nonnull AMapReGeocodeSearchResponse *)response{
    KKLog(@"%@",amapPOI);
    CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(amapPOI.location.latitude,amapPOI.location.longitude);//纬度，经度
    self.latitude = amapPOI.location.latitude;
    self.longitude = amapPOI.location.longitude;
    self.province = @{@"name":response.regeocode.addressComponent.province};
    self.city = @{@"name":response.regeocode.addressComponent.city};
    self.areadic = @{@"name":response.regeocode.addressComponent.district};
    self.address.subfield.text = amapPOI.address;
}
- (void)GDSearchMapVCDelegateWithAddressComponent:(AMapReGeocodeSearchResponse *)response And:(AMapPOI *)amapPOI{
    KKLog(@"%@",response);
    self.province = @{@"name":response.regeocode.addressComponent.province};
    self.city = @{@"name":response.regeocode.addressComponent.city};
    self.areadic = @{@"name":response.regeocode.addressComponent.district};
    self.address.subfield.text =response.regeocode.formattedAddress;
    NSInteger n = response.regeocode.addressComponent.province.length + response.regeocode.addressComponent.city.length + response.regeocode.addressComponent.district.length;
    self.address.subfield.text = [response.regeocode.formattedAddress substringFromIndex:n];
    self.latitude = amapPOI.location.latitude;
    self.longitude = amapPOI.location.longitude;
}



//- (void)loadAddressWith:(AMapReGeocodeSearchResponse *)response{
//    self.province = @{@"name":response.regeocode.addressComponent.province};
//    self.city = @{@"name":response.regeocode.addressComponent.city};
//    self.areadic = @{@"name":response.regeocode.addressComponent.district};
//    self.address.subfield.text =response.regeocode.formattedAddress;
//    NSInteger n = response.regeocode.addressComponent.province.length + response.regeocode.addressComponent.city.length + response.regeocode.addressComponent.district.length;
//    self.address.subfield.text = [response.regeocode.formattedAddress substringFromIndex:n];//截取范围内的字符串
//}
/*
#pragma mark - Navigation
 ///格式化地址
 @property (nonatomic, copy)   NSString             *formattedAddress;
 ///地址组成要素
 @property (nonatomic, strong) AMapAddressComponent *addressComponent;
 
 ///道路信息 AMapRoad 数组
 @property (nonatomic, strong) NSArray<AMapRoad *> *roads;
 ///道路路口信息 AMapRoadInter 数组
 @property (nonatomic, strong) NSArray<AMapRoadInter *> *roadinters;
 ///兴趣点信息 AMapPOI 数组
 @property (nonatomic, strong) NSArray<AMapPOI *> *pois;
 ///兴趣区域信息 AMapAOI 数组
 @property (nonatomic, strong) NSArray<AMapAOI *> *aois;
 
 
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
