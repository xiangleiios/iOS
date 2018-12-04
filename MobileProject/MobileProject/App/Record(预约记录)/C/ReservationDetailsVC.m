//
//  ReservationDetailsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ReservationDetailsVC.h"
#import "XLInformationV.h"
#import "ReservationRecordListMyVC.h"
@interface ReservationDetailsVC ()
@property (nonatomic ,strong)XLInformationV *KE;
@property (nonatomic ,strong)XLInformationV *KS;
@property (nonatomic , strong)UILabel *studentType;
@end

@implementation ReservationDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"预约详情"];
    self.view.backgroundColor = kColor_N(240, 240, 240);
    [self loadSub];
    [self laodDetail];
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
    name.text = _model.schoolName;
    name.font = [UIFont systemFontOfSize:kFit_Font6(20)];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(img);
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(10));
        make.height.mas_equalTo(KFit_H6S(50));
    }];
    
    UILabel *type = [[UILabel alloc] init];
    [v addSubview:type];
    type.textColor = [UIColor whiteColor];
    _studentType = type;
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
    didian.text = [NSString stringWithFormat:@"练车地点：%@",_model.trainingAddress];
    didian.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [didian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(35));
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_W6S(40));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    UILabel *shijian = [[UILabel alloc] init];
    [v addSubview:shijian];
    shijian.textColor = [UIColor whiteColor];
    shijian.text = [NSString stringWithFormat:@"练车时间：%@",_model.trainingTime];
    shijian.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [shijian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(35));
        make.top.mas_equalTo(didian.mas_bottom).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    XLCache *cache = [XLCache singleton];
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
    XLInformationV *xiangmu = [[XLInformationV alloc] informationWithTitle:@"练车项目" SubTitle:_model.keMu];
    xiangmu.titlelb.textColor = [UIColor blackColor];
    XLInformationV *jiazhao = [[XLInformationV alloc] informationWithTitle:@"驾照类型" SubTitle:cache.student_license_type_title[[cache.student_license_type_value indexOfObject:_model.licenseType]]];
    jiazhao.titlelb.textColor = [UIColor blackColor];
    XLInformationV *yuyueshijian = [[XLInformationV alloc] informationWithTitle:@"预约时间" SubTitle:_model.createTime];
    yuyueshijian.titlelb.textColor = [UIColor blackColor];
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
    
    XLInformationV *tongji = [[XLInformationV alloc] informationWithTitle:@"练车统计" SubTitle:@"练车记录" TSSubTitle:@"" Must:NO Click:YES];
    tongji.senterBlock = ^{
        ReservationRecordListMyVC *vc = [[ReservationRecordListMyVC alloc] init];
        vc.dic = @{@"type":@"2",@"sysStudentCode":_model.sysStudentCode};
        [self.navigationController pushViewController:vc animated:YES];
    };
    XLInformationV *kemuer = [[XLInformationV alloc] informationWithTitle:@"科二练习" SubTitle:@"已预约0次/共0小时"];
    kemuer.titlelb.textColor = [UIColor blackColor];
    XLInformationV *kemusan = [[XLInformationV alloc] informationWithTitle:@"科三练习" SubTitle:@"已预约0次/共0小时"];
    kemusan.titlelb.textColor = [UIColor blackColor];
    self.KE = kemuer;
    self.KS = kemusan;
    [vthree addSubview:tongji];
    [vthree addSubview:kemuer];
    [vthree addSubview:kemusan];
    
    NSArray *arrtwo = @[tongji,kemuer,kemusan];
    [arrtwo mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arrtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vtwo).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(vtwo).mas_offset(-KFit_W6S(30));
    }];
    
    
    if ([_model.type intValue] == 3) {
        UIView *four = [[UIView alloc] init];
        [self.view addSubview:four];
        four.layer.cornerRadius = kFit_Font6(5);
        four.layer.masksToBounds = YES;
        four.backgroundColor = [UIColor whiteColor];
        [four mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(35));
            make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(35));
            make.top.mas_equalTo(vthree.mas_bottom).mas_offset(KFit_H6S(20));
            make.height.mas_equalTo(KFit_H6S(270));
        }];
        
        NSData *jsondata = [_model.memo dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic =  [NSJSONSerialization JSONObjectWithData:jsondata options:NSJSONReadingMutableContainers error:nil];
        NSString *str;
        if ([_model.isCancel intValue] == 0) {
            str=@"学员取消";
        }else{
            str=@"教练取消";
        }
        XLInformationV *leixin = [[XLInformationV alloc] informationWithTitle:@"取消类型" SubTitle:str];
        leixin.titlelb.textColor = [UIColor blackColor];
        XLInformationV *yuanying = [[XLInformationV alloc] informationWithTitle:@"取消原因" SubTitle:dic[@"memo"]];
        yuanying.titlelb.textColor = [UIColor blackColor];
        
        XLInformationV *quxiaoshijian = [[XLInformationV alloc] informationWithTitle:@"取消时间" SubTitle:dic[@"updateTime"]];
        quxiaoshijian.titlelb.textColor = [UIColor blackColor];
        self.KE = kemuer;
        self.KS = kemusan;
        [four addSubview:leixin];
        [four addSubview:yuanying];
        [four addSubview:quxiaoshijian];
        
        NSArray *arrthree = @[leixin,yuanying,quxiaoshijian];
        [arrthree mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arrthree mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(vtwo).mas_offset(KFit_W6S(30));
            make.right.mas_equalTo(vtwo).mas_offset(-KFit_W6S(30));
        }];
        
    }
}

- (void)laodDetail{
    NSString *url = [NSString stringWithFormat:POSTGetTrainingRecordInfo,_model.idid];
//    NSDictionary *dic = @{@"id":_model.idid};
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            switch ([responseObject[@"type"] intValue]) {
                case 0:
                    _studentType.text = @"等待练车";
                    break;
                case 1:
                    _studentType.text = @"练车中";
                    break;
                case 2:
                    _studentType.text = @"已完成";
                    break;
                case 3:
                    _studentType.text = @"已取消";
                    break;
                    
                default:
                    break;
            }
            NSArray *arr = responseObject[@"keMuCount"];
            if (arr) {
                for (NSDictionary *dic in arr) {
                    if ([dic[@"keMu"]  isEqual: @"科二"]) {
                        float h = [dic[@"hasHour"] intValue]/60.0;
                        NSString * testNumber = [NSString stringWithFormat:@"%.1lf",h];
                        NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
                        self.KE.titlelb.text = [NSString stringWithFormat:@"已预约%@次/共%@小时",dic[@"number"],outNumber];
                    }else if ([dic[@"keMu"]  isEqual: @"科三"]){
                        float h = [dic[@"hasHour"] intValue]/60.0;
                        NSString * testNumber = [NSString stringWithFormat:@"%.1lf",h];
                        NSString * outNumber = [NSString stringWithFormat:@"%@",@(testNumber.floatValue)];
                        self.KE.titlelb.text = [NSString stringWithFormat:@"已预约%@次/共%@小时",dic[@"number"],outNumber];
                    }
                }
            }
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
