//
//  FormsV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FormsV.h"
#import "CGXPickerView.h"
#import "XLCache.h"
@implementation FormsV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        kWeakSelf(self)
        self.name = [[XLInformationV alloc] informationWithTitle:@"姓名" SubTitle:@"" TSSubTitle:@"请输入姓名" Must:YES Click:NO];
        self.gender = [[XLInformationV alloc] informationWithTitle:@"性别" SubTitle:@"" TSSubTitle:@"请选择性别" Must:YES Click:YES];
        self.gender.red.textColor = [UIColor blackColor];
        self.gender.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"性别" DataSource:[XLCache singleton].sys_user_sex_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.gender.subfield.text = selectValue;
                weakself.gender.subfield.tag = [[XLCache singleton].sys_user_sex_value[[selectRow intValue]] intValue];
            }];
        };
        self.ethnic = [[XLInformationV alloc] informationWithTitle:@"民族" SubTitle:@"" TSSubTitle:@"请选择民族" Must:YES Click:YES];
        self.ethnic.red.textColor = [UIColor blackColor];
        self.ethnic.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"民族" DataSource:[XLCache singleton].ethnicTitleArr DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@    %@",selectValue,selectRow);
                weakself.ethnic.subfield.text = selectValue;
                weakself.ethnic.subfield.tag = [[XLCache singleton].ethnicValueArr[[selectRow intValue]] intValue];
            }];
        };
        self.birthday = [[XLInformationV alloc] informationWithTitle:@"出生年月日" SubTitle:@"" TSSubTitle:@"请选择出生年月日" Must:YES Click:YES];
        self.birthday.red.textColor = [UIColor blackColor];
        self.birthday.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showDatePickerWithTitle:@"出生年月日" DateType:UIDatePickerModeDate DefaultSelValue: weakself.birthday.subfield.text MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
                NSLog(@"%@",selectValue);
                weakself.birthday.subfield.text = selectValue;
            }];
        };
        self.address = [[XLInformationV alloc] informationWithTitle:@"住址" SubTitle:@"" TSSubTitle:@"请填写地址" Must:YES Click:NO];
        self.address.red.textColor = [UIColor blackColor];
        self.IdNumber = [[XLInformationV alloc] informationWithTitle:@"身份证号码" SubTitle:@"" TSSubTitle:@"请填写身份证号" Must:YES Click:NO];
        self.IdNumber.red.textColor = [UIColor blackColor];
        [self addSubview:self.name];
        [self addSubview:self.gender];
        [self addSubview:self.ethnic];
        [self addSubview:self.birthday];
        [self addSubview:self.address];
        [self addSubview:self.IdNumber];
        
        
        NSArray *arr = @[self.name,self.gender,self.ethnic,self.birthday,self.address,self.IdNumber];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
        }];
    }
    return self;
}
@end



@implementation FormsAddV

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        kWeakSelf(self)
//        self.name = [[XLInformationV alloc] informationWithTitle:@"姓名" SubTitle:@"" TSSubTitle:@"请输入姓名" Must:YES Click:NO];
        self.gender = [[XLInformationV alloc] informationWithTitle:@"性别" SubTitle:@"" TSSubTitle:@"请选择性别" Must:YES Click:YES];
        
        self.gender.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"性别" DataSource:[XLCache singleton].sys_user_sex_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.gender.subfield.text = selectValue;
                weakself.gender.subfield.tag = [[XLCache singleton].sys_user_sex_value[[selectRow intValue]] intValue];
            }];
        };
        self.ethnic = [[XLInformationV alloc] informationWithTitle:@"民族" SubTitle:@"" TSSubTitle:@"请选择民族" Must:YES Click:YES];
        self.ethnic.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"民族" DataSource:[XLCache singleton].ethnicTitleArr DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@    %@",selectValue,selectRow);
                weakself.ethnic.subfield.text = selectValue;
                weakself.ethnic.subfield.tag = [[XLCache singleton].ethnicValueArr[[selectRow intValue]] intValue];
            }];
        };
        self.birthday = [[XLInformationV alloc] informationWithTitle:@"出生年月日" SubTitle:@"" TSSubTitle:@"请选择出生年月日" Must:YES Click:YES];
        self.birthday.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showDatePickerWithTitle:@"出生年月日" DateType:UIDatePickerModeDate DefaultSelValue: weakself.birthday.subfield.text MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
                NSLog(@"%@",selectValue);
                weakself.birthday.subfield.text = selectValue;
            }];
        };
        self.address = [[XLInformationV alloc] informationWithTitle:@"住址" SubTitle:@"" TSSubTitle:@"请填写地址" Must:YES Click:NO];
        self.IdNumber = [[XLInformationV alloc] informationWithTitle:@"身份证号码" SubTitle:@"" TSSubTitle:@"请填写身份证号" Must:YES Click:NO];
//        [self addSubview:self.name];
        [self addSubview:self.gender];
        [self addSubview:self.ethnic];
        [self addSubview:self.birthday];
        [self addSubview:self.address];
        [self addSubview:self.IdNumber];
        
        self.gender.red.textColor = [UIColor blackColor];
        self.ethnic.red.textColor = [UIColor blackColor];
        self.birthday.red.textColor = [UIColor blackColor];
        self.address.red.textColor = [UIColor blackColor];
        self.IdNumber.red.textColor = [UIColor blackColor];
        
        NSArray *arr = @[self.gender,self.ethnic,self.birthday,self.address,self.IdNumber];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
        }];
    }
    return self;
}
@end

#pragma mark - 其他报名信息  添加学员
@implementation SignUpFormsV
- (instancetype)init
{
    self = [super init];
    if (self) {
        kWeakSelf(self)
        self.hukou = [[XLInformationV alloc] informationWithTitle:@"本外地" SubTitle:@"" TSSubTitle:@"" Must:YES Click:YES];
        self.hukou.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"本外地" DataSource:[XLCache singleton].student_is_enter_type_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.hukou.subfield.text = selectValue;
                weakself.hukou.subfield.tag = [[XLCache singleton].student_is_enter_type_value[[selectRow intValue]] intValue];
            }];
        };
        self.carType = [[XLInformationV alloc] informationWithTitle:@"车型" SubTitle:@"" TSSubTitle:@"" Must:YES Click:YES];
        self.carType.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"车型" DataSource:[XLCache singleton].student_license_type_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.carType.subfield.text = selectValue;
                weakself.carType.subfield.tag = [[XLCache singleton].student_license_type_value[[selectRow intValue]] intValue];
            }];
        };
        self.carType.subfield.text = [[XLCache singleton].student_license_type_title firstObject];
        self.carType.subfield.tag = [[[XLCache singleton].student_license_type_value firstObject] integerValue];
        
//        self.price = [[XLInformationV alloc] informationWithTitle:@"报考价格" SubTitle:@"" TSSubTitle:@"请输入报名金额" Must:NO Click:NO];
        self.school = [[XLInformationV alloc] informationWithTitle:@"报考驾校" SubTitle:@"" TSSubTitle:@"请选择报考驾校" Must:YES Click:YES];
        self.school.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"报考驾校" DataSource:[XLCache singleton].teamCode_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.school.subfield.text = selectValue;
                weakself.school.subfield.tag = [[XLCache singleton].teamCode_value[[selectRow intValue]] intValue];
            }];
        };
        self.school.subfield.text = [[XLCache singleton].teamCode_title firstObject];
        self.school.subfield.tag = [[[XLCache singleton].teamCode_value firstObject] integerValue];
        
        self.type = [[XLInformationV alloc] informationWithTitle:@"申请类型" SubTitle:@"" TSSubTitle:@"请选择申请类型" Must:YES Click:YES];
        self.type.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"申请类型" DataSource:[XLCache singleton].student_apply_type_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.type.subfield.text = selectValue;
                weakself.type.subfield.tag = [[XLCache singleton].student_apply_type_value[[selectRow intValue]] intValue];
            }];
        };
        self.type.subfield.text = [[XLCache singleton].student_apply_type_title firstObject];
        self.type.subfield.tag = [[[XLCache singleton].student_apply_type_value firstObject] integerValue];
        
        [self addSubview:self.hukou];
        [self addSubview:self.carType];
//        [self addSubview:self.price];
        [self addSubview:self.school];
//        [self addSubview:self.jiaKao];
        [self addSubview:self.type];
        self.hukou.red.textColor = [UIColor blackColor];
        self.carType.red.textColor = [UIColor blackColor];
        self.school.red.textColor = [UIColor blackColor];
        self.type.red.textColor = [UIColor blackColor];
        
        NSArray *arr = @[self.hukou,self.carType,self.school,self.type];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
        }];
        
    }
    return self;
}


@end


#pragma mark - 报考信息表单2 详情中显示
@implementation SignUpTwoFormsV
- (instancetype)init
{
    self = [super init];
    if (self) {
        kWeakSelf(self)
        self.phone = [[XLInformationV alloc] informationWithTitle:@"手机号" SubTitle:@"" TSSubTitle:@"请输入手机号" Must:YES Click:NO];
        
        self.hukou = [[XLInformationV alloc] informationWithTitle:@"本外地" SubTitle:@"" TSSubTitle:@"" Must:YES Click:YES];
        self.hukou.red.textColor = [UIColor blackColor];
        self.hukou.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"本外地" DataSource:[XLCache singleton].student_is_enter_type_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.hukou.subfield.text = selectValue;
                weakself.hukou.subfield.tag = [[XLCache singleton].student_is_enter_type_value[[selectRow intValue]] intValue];
            }];
        };
        
        self.carType = [[XLInformationV alloc] informationWithTitle:@"车型" SubTitle:@"" TSSubTitle:@"" Must:YES Click:YES];
        self.carType.red.textColor = [UIColor blackColor];
        self.carType.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"车型" DataSource:[XLCache singleton].student_license_type_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.carType.subfield.text = selectValue;
                weakself.carType.subfield.tag = [[XLCache singleton].student_license_type_value[[selectRow intValue]] intValue];
            }];
        };
        
        
//        self.price = [[XLInformationV alloc] informationWithTitle:@"报考价格" SubTitle:@"" TSSubTitle:@"请输入报名金额" Must:NO Click:NO];
        
        self.school = [[XLInformationV alloc] informationWithTitle:@"报考驾校" SubTitle:@"" TSSubTitle:@"请选择报考驾校" Must:YES Click:YES];
        self.school.red.textColor = [UIColor blackColor];
        self.school.senterBlock = ^{
            [weakself endEditing:YES];
            KKLog(@"%@",[XLCache singleton].teamCode_title);
            [CGXPickerView showStringPickerWithTitle:@"报考驾校" DataSource:[XLCache singleton].teamCode_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.school.subfield.text = selectValue;
                weakself.school.subfield.tag = [[XLCache singleton].teamCode_value[[selectRow intValue]] intValue];
            }];
        };
        
        
        self.type = [[XLInformationV alloc] informationWithTitle:@"申请类型" SubTitle:@"" TSSubTitle:@"请选择申请类型" Must:YES Click:YES];
        self.type.red.textColor = [UIColor blackColor];
        self.type.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"申请类型" DataSource:[XLCache singleton].student_apply_type_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.type.subfield.text = selectValue;
                weakself.type.subfield.tag = [[XLCache singleton].student_apply_type_value[[selectRow intValue]] intValue];
            }];
        };
        [self addSubview:self.phone];
        [self addSubview:self.hukou];
        [self addSubview:self.carType];
//        [self addSubview:self.price];
        [self addSubview:self.school];
//        [self addSubview:self.jiaKao];
        [self addSubview:self.type];
        
        NSArray *arr = @[self.phone,self.hukou,self.carType,self.school,self.type];
//        NSArray *arr = @[self.phone,self.hukou,self.carType,self.price,self.school,self.jiaKao,self.type];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
        }];
        
    }
    return self;
}

@end

#pragma mark - 其他报考信息表单
@implementation OtherFormsV


- (instancetype)init
{
    self = [super init];
    if (self) {
//        kWeakSelf(self)
        self.referees = [[XLInformationV alloc] informationWithTitle:@"推荐人" SubTitle:@"" TSSubTitle:@"请输入推荐人" Must:NO Click:NO];
        self.note = [[XLInformationV alloc] informationWithTitle:@"备注" SubTitle:@"" TSSubTitle:@"请输入备注" Must:NO Click:NO];
        self.coach = [[XLInformationV alloc] informationWithTitle:@"报名教练" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.coach.userInteractionEnabled = NO;
        self.coach.subfield.textColor = ZTColor;
//        self.state.senterBlock = ^{
//            [weakself endEditing:YES];
//            [CGXPickerView showStringPickerWithTitle:@"收费状态" DataSource:@[@"未收费",@"已收费"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
//
//                weakself.state.subfield.text = selectValue;
//                weakself.state.subfield.tag = [selectRow integerValue] + 1; ///1:未缴费 2：已缴费
//                NSLog(@"%@  %ld",selectValue,weakself.state.subfield.tag);
//            }];
//        };
        [self addSubview:self.referees];
        [self addSubview:self.note];
        [self addSubview:self.coach];
        
        NSArray *arr = @[self.referees,self.note,self.coach];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
        }];
    }
    return self;
}



@end





@implementation AdmissionsFormsV

- (instancetype)init
{
    self = [super init];
    if (self) {
        kWeakSelf(self)
        self.name = [[XLInformationV alloc] informationWithTitle:@"姓名" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.name.userInteractionEnabled = NO;
        self.name.subfield.textColor = kColor_N(210, 210, 210);
        
        self.gender = [[XLInformationV alloc] informationWithTitle:@"性别" SubTitle:@"" TSSubTitle:@"" Must:NO Click:YES];
        self.gender.senterBlock = ^{
            [weakself endEditing:YES];
            [CGXPickerView showStringPickerWithTitle:@"性别" DataSource:[XLCache singleton].sys_user_sex_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.gender.subfield.text = selectValue;
                weakself.gender.subfield.tag = [[XLCache singleton].sys_user_sex_value[[selectRow intValue]] intValue];
            }];
        };
        self.school = [[XLInformationV alloc] informationWithTitle:@"驾校" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.school.userInteractionEnabled = NO;
        self.school.subfield.textColor = kColor_N(210, 210, 210);
//        self.school.senterBlock = ^{
//            [weakself endEditing:YES];
//            [CGXPickerView showStringPickerWithTitle:@"报考驾校" DataSource:[XLCache singleton].teamCode_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
//                NSLog(@"%@",selectValue);
//                weakself.school.subfield.text = selectValue;
//                weakself.school.subfield.tag = [[XLCache singleton].schoolDeptId[[selectRow intValue]] intValue];
//                NSLog(@"%@",[XLCache singleton].teamCode_value[[selectRow intValue]]);
//            }];
//        };
        XLInformationV *peixun = [[XLInformationV alloc] informationWithTitle:@"招生培训资料" Subtitle:@"" Must:YES];
        
        self.seniority = [[XLInformationV alloc] informationWithTitle:@"教龄" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.phone = [[XLInformationV alloc] informationWithTitle:@"招生电话" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.phone.userInteractionEnabled = NO;
        self.phone.subfield.textColor = kColor_N(210, 210, 210);
        self.names = [[XLInformationV alloc] informationWithTitle:@"分校名称" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.names.userInteractionEnabled = NO;
        self.names.subfield.textColor = kColor_N(210, 210, 210);
        self.address = [[XLInformationV alloc] informationWithTitle:@"分校地址" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.address.userInteractionEnabled = NO;
        self.address.subfield.textColor = kColor_N(210, 210, 210);
        [self addSubview:self.name];
        [self addSubview:self.gender];
        [self addSubview:self.school];
        
        [self addSubview:peixun];
        
        [self addSubview:self.seniority];
        [self addSubview:self.phone];
        [self addSubview:self.names];
        [self addSubview:self.address];
        
        
        NSArray *arr = @[self.name,self.gender,self.school,peixun,self.seniority,self.phone,self.names,self.address];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
        }];
        
    }
    return self;
}


@end



@implementation CourseFormsV

- (instancetype)initWithDataArr:(NSArray *)data{
    self = [super init];
    if (self) {
        self.dataArr = data;
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr{
    _dataArr = dataArr;
    [_backview removeFromSuperview];
    _backview = [[XLView alloc] init];
    [self addSubview:_backview];
    [_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self);
    }];
    XLCache *cache = [XLCache singleton];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < dataArr.count; i++) {
        NSDictionary *dic = dataArr[i];
        NSString *str;
        if (!dic[@"licenseType"] || ![dic[@"licenseType"]  isEqual:@""]) {
            str =  cache.student_license_type_title[[cache.student_license_type_value indexOfObject:dic[@"licenseType"]]];
        }else{
            str = @"";
        }
//        str =  cache.student_license_type_title[[cache.student_license_type_value indexOfObject:dic[@"licenseType"]]];
        XLInformationV *v = [[XLInformationV alloc] informationWithTitle:dic[@"courseName"] CarType:str SubTitle:dic[@"courseIntroduce"]?dic[@"courseIntroduce"]:@"" Price:dic[@"coursePrice"]?dic[@"coursePrice"]:@""];
        v.tag = i;
        kWeakSelf(self)
        v.senterBlock = ^{
            
            weakself.senterBlockInt(v.tag);

        };
        [_backview addSubview:v];
        [arr addObject:v];
    }
    
    if (dataArr.count > 1) {
        [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_backview);
        }];
    }else if(dataArr.count == 1){
        XLInformationV *v = (XLInformationV *)[arr firstObject];
        [v mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(self);
        }];
    }
}
@end





#pragma mark - 分校详情基本资料表单
@implementation FXAdmissionsFormsV

- (instancetype)init
{
    self = [super init];
    if (self) {
        kWeakSelf(self)
        self.name = [[XLInformationV alloc] informationWithTitle:@"负责人姓名" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.name.userInteractionEnabled = NO;
        self.name.subfield.textColor = kColor_N(210, 210, 210);
        self.school = [[XLInformationV alloc] informationWithTitle:@"所属驾校" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.school.userInteractionEnabled = NO;
        self.school.subfield.textColor = kColor_N(210, 210, 210);
        
        
        
        self.phone = [[XLInformationV alloc] informationWithTitle:@"招生电话" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.phone.userInteractionEnabled = NO;
        self.phone.subfield.textColor = kColor_N(210, 210, 210);
        self.names = [[XLInformationV alloc] informationWithTitle:@"分校名称" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.names.userInteractionEnabled = NO;
        self.names.subfield.textColor = kColor_N(210, 210, 210);
        self.address = [[XLInformationV alloc] informationWithTitle:@"详细地址" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        
        self.addressarea = [[XLInformationV alloc] informationWithTitle:@"分校区域" SubTitle:@"" TSSubTitle:@"" Must:NO Click:YES];
//        self.address.userInteractionEnabled = NO;
//        self.address.subfield.textColor = kColor_N(210, 210, 210);
        
        [self addSubview:self.name];
        [self addSubview:self.school];
        [self addSubview:self.phone];
        [self addSubview:self.names];
        [self addSubview:self.address];
        [self addSubview:self.addressarea];
        
        NSArray *arr = @[self.school,self.names,self.addressarea,self.address,self.name,self.phone];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
        }];
        
    }
    return self;
}


@end


