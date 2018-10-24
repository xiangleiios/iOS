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
@interface TrainingVC ()
@property (nonatomic , strong)XLInformationV *school;
@property (nonatomic , strong)XLInformationV *fenXiao;
@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)XLInformationV *area;
@property (nonatomic , strong)XLInformationV *address;
@property (nonatomic , strong)UIButton *choose;
@end

@implementation TrainingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubview];
    [self loadBut];
    // Do any additional setup after loading the view.
}
#pragma mark - 导航相关
- (void)laodNavigation{
    kWeakSelf(self)
    self.choose = [self.navigationView addRightButtonWithTitle:@"删除" clickCallBack:^(UIView *view) {
       
    }];
    [self.choose setTitleColor:kColor_N(0, 112, 234) forState:UIControlStateNormal];
    self.choose.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
}
- (void)loadBut{
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


- (void)loadSubview{
    UIView *v = [[UIView alloc] init];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(540));
    }];
    
    kWeakSelf(self)
    XLInformationV *baokao = [[XLInformationV alloc] informationWithTitle:@"基本信息"];
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    NSArray *arrname = (NSArray *)[defaults objectForKey:SchoolList];
    self.school = [[XLInformationV alloc] informationWithTitle:@"所属总校" SubTitle:@"" TSSubTitle:@"请选择总校" Must:YES Click:YES];
    
    self.fenXiao = [[XLInformationV alloc] informationWithTitle:@"所属分校" SubTitle:@"" TSSubTitle:@"请选择分校" Must:YES Click:NO];
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
        AddressV *v = [[AddressV alloc] init];
        v.vc = self;
        [v show];
    };
    self.address = [[XLInformationV alloc] informationWithTitle:@"详细地址" SubTitle:@"" TSSubTitle:@"请输入训练场详细地址" Must:YES Click:NO];
    
    
    
    
    
    [v addSubview:baokao];
    [v addSubview:self.school];
    [v addSubview:self.fenXiao];
    [v addSubview:self.name];
    [v addSubview:self.area];
    [v addSubview:self.address];
    NSArray *arr = @[baokao,self.school,self.fenXiao,self.name,self.area,self.address];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(v);
    }];
    
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
- (void)toSave{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
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
