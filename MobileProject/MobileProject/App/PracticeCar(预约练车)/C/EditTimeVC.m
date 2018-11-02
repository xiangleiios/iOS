//
//  EditTimeVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "EditTimeVC.h"
#import "XLInformationV.h"
#import "CGXPickerView.h"
#import "XLCache.h"
@interface EditTimeVC ()
@property (nonatomic , strong)XLInformationV *state;
@property (nonatomic , strong)XLInformationV *end;
@property (nonatomic , strong)XLInformationV *subjects;
@property (nonatomic , strong)XLInformationV *type;
@end

@implementation EditTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSunview];
    [self loadBut];
    // Do any additional setup after loading the view.
}

- (void)loadSunview{
    UIView *v = [[UIView alloc] init];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(360));
    }];
    kWeakSelf(self)
    self.state = [[XLInformationV alloc] informationWithTitle:@"开始时间" SubTitle:@"" TSSubTitle:@"请选择开始时间" Must:NO Click:YES];
    self.state.senterBlock = ^{
        [CGXPickerView showDatePickerWithTitle:@"开始时间" DateType:UIDatePickerModeTime DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            weakself.state.subfield.text = selectValue;
        }];
    };
    self.end = [[XLInformationV alloc] informationWithTitle:@"结束时间" SubTitle:@"" TSSubTitle:@"请选择结束时间" Must:NO Click:YES];
    self.end.senterBlock = ^{
        [CGXPickerView showDatePickerWithTitle:@"结束时间" DateType:UIDatePickerModeTime DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            weakself.end.subfield.text = selectValue;
        }];
    };
    self.subjects = [[XLInformationV alloc] informationWithTitle:@"练习科目" SubTitle:@"" TSSubTitle:@"请选择练习科目" Must:NO Click:YES];
    self.subjects.senterBlock = ^{
        [CGXPickerView showStringPickerWithTitle:@"练习科目" DataSource:@[@"科二",@"科三"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            NSLog(@"%@",selectValue);
            weakself.subjects.subfield.text = selectValue;
        }];
    };
    
    self.type = [[XLInformationV alloc] informationWithTitle:@"驾照类型" SubTitle:@"" TSSubTitle:@"请选择驾照类型" Must:NO Click:YES];
    self.type.senterBlock = ^{
        [CGXPickerView showStringPickerWithTitle:@"驾照类型" DataSource:[XLCache singleton].student_license_type_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            NSLog(@"%@",selectValue);
            weakself.type.subfield.text = selectValue;
            weakself.type.subfield.tag = [[XLCache singleton].student_license_type_value[[selectRow intValue]] intValue];
        }];
    };
    self.type.subfield.text = [[XLCache singleton].student_license_type_title firstObject];
    self.type.subfield.tag = [[[XLCache singleton].student_license_type_value firstObject] integerValue];
    [v addSubview:self.state];
    [v addSubview:self.end];
    [v addSubview:self.subjects];
    [v addSubview:self.type];
    NSArray *arr = @[self.state, self.end,self.subjects ,self.type];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(v);
    }];
    
    if (self.model) {
        XLCache *cache = [XLCache singleton];
        self.state.subfield.text = [XLCommonUse TimeToInterceptHHmm:_model.startTime];
        self.end.subfield.text = [XLCommonUse TimeToInterceptHHmm:_model.endTime];
        self.subjects.subfield.text = _model.keMu;
        self.type.subfield.text = [NSString stringWithFormat:@"%@",cache.student_license_type_title[[cache.student_license_type_value indexOfObject:_model.licenseType]]];
        self.type.subfield.tag = [_model.licenseType integerValue];
    }
}

- (void)loadBut{
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    [img setImage:[UIImage imageNamed:@"white_bg_"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(164));
    }];
    
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"保存" forState:UIControlStateNormal];
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
}

- (void)toSave{
    if (self.state.subfield.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请选择开始时间"];
        return;
    }
    if (self.end.subfield.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请选择结束时间"];
        return;
    }
    if (self.subjects.subfield.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请选择练习科目"];
        return;
    }
    if (self.type.subfield.text.length < 1) {
        [MBProgressHUD showMsgHUD:@"请选择驾照类型"];
        return;
    }
    NSString *time = [XLCommonUse TimeToInterceptYYYYMMdd:[NSDate date]];
//    NSArray *startArr = [self.state.subfield.text componentsSeparatedByString:@":"];
//    NSArray *endArr = [self.end.subfield.text componentsSeparatedByString:@":"];
    NSString *start = [NSString stringWithFormat:@"%@ %@:00",time,self.state.subfield.text];
    NSString *end = [NSString stringWithFormat:@"%@ %@:00",time,self.end.subfield.text];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:self.groundId forKey:@"groundId"];
    [dic setObject:start forKey:@"startTime"];
    [dic setObject:end forKey:@"endTime"];
    [dic setObject:self.subjects.subfield.text forKey:@"keMu"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)self.type.subfield.tag] forKey:@"licenseType"];
    
    NSString *url;
    
    if (self.editorType == 1) {
        url = POSTTrainingModuleAdd;
    }else if(self.editorType == 0){
        [dic setObject:_model.idid forKey:@"id"];
        url = POSTTrainingModuleEdit;
    }else if (self.editorType == 2){
        NSString *starttime = [NSString stringWithFormat:@"%@ %@:00",[XLCommonUse TimeToInterceptYYYYMMddWithStr:self.selectTime],self.state.subfield.text];
        NSString *endtime = [NSString stringWithFormat:@"%@ %@:00",[XLCommonUse TimeToInterceptYYYYMMddWithStr:self.selectTime],self.end.subfield.text];
        [dic setObject:starttime forKey:@"startTime"];
        [dic setObject:endtime forKey:@"endTime"];
        url = POSTTrainingInfoAdd;
    }else if (self.editorType == 3){
        [dic setObject:_model.idid forKey:@"id"];
        NSString *starttime = [NSString stringWithFormat:@"%@ %@:00",[XLCommonUse TimeToInterceptYYYYMMddWithStr:self.selectTime],self.state.subfield.text];
        NSString *endtime = [NSString stringWithFormat:@"%@ %@:00",[XLCommonUse TimeToInterceptYYYYMMddWithStr:self.selectTime],self.end.subfield.text];
        [dic setObject:starttime forKey:@"startTime"];
        [dic setObject:endtime forKey:@"endTime"];
        url = POSTTrainingInfoEdit;
    }
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showMsgHUD:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
        
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
