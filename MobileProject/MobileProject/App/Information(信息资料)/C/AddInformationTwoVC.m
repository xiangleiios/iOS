//
//  AddInformationTwoVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddInformationTwoVC.h"
#import "XLInformationV.h"
#import "CGXPickerView.h"
#import "AddInformationThreeVC.h"
#import "JQAVCaptureViewController.h"
#import "IDInfo.h"
@interface AddInformationTwoVC ()<JQAVCaptureViewControllerDelegate>
@property (nonatomic , strong)XLInformationV *start_time;
@property (nonatomic , strong)XLInformationV *end_time;
@property (nonatomic , strong)XLInformationV *hukou;
@end

@implementation AddInformationTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self laodNavigation];
    
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)laodNavigation{
    [self.navigationView setTitle:@"填写资料"];
    //添加一个带图片的按钮，如果这个按钮只有点击事件，可以这样写，更加简洁。
    //    [self.navigationView addRightButtonWithImage:kImage(@"gift") hightImage:kImage(@"wo-guayuwomen") clickCallBack:^(UIView *view) {
    //
    //    }];
}

- (void)loadSubview{
    UIView *v = [[UIView alloc] init];
    [self.view addSubview:v];
    v.backgroundColor = kColor_N(240, 240, 240);
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(320));
    }];
    
    UIView *backView = [[UIView alloc] init];
    [v addSubview:backView];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5;
    backView.layer.masksToBounds = YES;
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v).mas_offset(KFit_H6S(40));
        make.bottom.mas_equalTo(v).mas_offset(-KFit_H6S(40));
        make.left.mas_equalTo(v).mas_offset(KFit_H6S(50));
        make.right.mas_equalTo(v).mas_offset(-KFit_H6S(50));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [backView addSubview:but];
    [but setImage:[UIImage imageNamed:@"card_nor"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(IdentificationCrdFM) forControlEvents:UIControlEventTouchUpInside];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backView);
        make.left.mas_equalTo(backView).mas_offset(KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(250), KFit_H6S(160)));
    }];
    
    UILabel *lbone = [[UILabel alloc] init];
    [backView addSubview:lbone];
    lbone.text = @"点击读取身份证信息";
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(but.mas_right).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(backView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(backView).mas_offset(-KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UILabel *lbtwo = [[UILabel alloc] init];
    [backView addSubview:lbtwo];
    lbtwo.text = @"身份证反面";
    lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    lbtwo.textColor = kColor_N(64, 75, 105);
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(but.mas_right).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(backView).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(backView).mas_offset(KFit_H6S(25));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UIView *inqutview = [[UIView alloc] init];
    [self.view addSubview:inqutview];
    [inqutview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(v.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(360));
    }];
    
    kWeakSelf(self)
    self.start_time = [[XLInformationV alloc] informationWithTitle:@"有效期起始" SubTitle:@"" TSSubTitle:@"请选择日期" Must:YES Click:YES];
    self.start_time.senterBlock = ^{
        [weakself.view endEditing:YES];
        [CGXPickerView showDatePickerWithTitle:@"有效期起始" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            weakself.start_time.subfield.text = selectValue;
        }];
    };
    self.end_time = [[XLInformationV alloc] informationWithTitle:@"有效期结束" SubTitle:@"" TSSubTitle:@"请选择日期" Must:YES Click:YES];
    self.end_time.senterBlock = ^{
        [weakself.view endEditing:YES];
        [CGXPickerView showDatePickerWithTitle:@"有效期结束" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
            NSLog(@"%@",selectValue);
            weakself.end_time.subfield.text = selectValue;
        }];
    };
    
    self.hukou = [[XLInformationV alloc] informationWithTitle:@"本/外地" SubTitle:@"" TSSubTitle:@"" Must:YES Click:YES];
    self.hukou.senterBlock = ^{
        [weakself.view endEditing:YES];
        [CGXPickerView showStringPickerWithTitle:@"本/外地" DataSource:@[@"本地",@"外地"] DefaultSelValue:@"本地" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
            NSLog(@"%@",selectValue);
            weakself.hukou.subfield.text = selectValue;
        }];
    };
    XLInformationV *lbback = [[XLInformationV alloc] informationWithTitle:@"请填写户口信息"];
    [inqutview addSubview:self.start_time];
    [inqutview addSubview:self.end_time];
    [inqutview addSubview:lbback];
    [inqutview addSubview:self.hukou];
    
    
    NSArray *arr = @[self.start_time,self.end_time,lbback,self.hukou];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
    }];
    
    
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"下一步" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(nextVC) forControlEvents:UIControlEventTouchUpInside];
    next.backgroundColor = kColor_N(0, 112, 234);
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


- (void)IdentificationCrdFM{
    JQAVCaptureViewController *AVCaptureVC = [[JQAVCaptureViewController alloc] init];
    AVCaptureVC.delegate = self;
    [self.navigationController pushViewController:AVCaptureVC animated:YES];
}

- (void)cardInformationScanningFM:(IDInfo *)info{
    NSArray *arr = [info.valid componentsSeparatedByString:@"-"];
    if (arr.count == 2) {
        NSString *stat = [arr firstObject];
        if (stat.length == 8) {
            NSString * year = [[arr firstObject] substringWithRange:NSMakeRange(0, 4)];
            NSString * month = [[arr firstObject] substringWithRange:NSMakeRange(4, 2)];
            NSString * day = [[arr firstObject] substringWithRange:NSMakeRange(6,2)];
            NSString *y = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            self.start_time.subfield.text = y;
        }
        NSString *end = [arr lastObject];
        if (end.length == 8) {
            NSString * year = [end substringWithRange:NSMakeRange(0, 4)];
            NSString * month = [end substringWithRange:NSMakeRange(4, 2)];
            NSString * day = [end substringWithRange:NSMakeRange(6,2)];
            NSString *y = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
            self.end_time.subfield.text = y;
        }
        
    }
//    self.start_time.subfield.text = info.
}

- (void)nextVC{
    AddInformationThreeVC *vc = [[AddInformationThreeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
