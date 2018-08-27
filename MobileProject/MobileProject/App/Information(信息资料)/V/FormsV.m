//
//  FormsV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "FormsV.h"
#import "CGXPickerView.h"
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
        self.gender.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"性别" DataSource:@[@"男",@"女"] DefaultSelValue:@"男" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.gender.subfield.text = selectValue;
            }];
        };
        self.ethnic = [[XLInformationV alloc] informationWithTitle:@"民族" SubTitle:@"" TSSubTitle:@"请选择民族" Must:YES Click:YES];
        self.ethnic.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"民族" DataSource:[CGXPickerView showStringPickerDataSourceStyle:CGXStringPickerViewStylNation] DefaultSelValue:@"汉" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.ethnic.subfield.text = selectValue;
            }];
        };
        self.birthday = [[XLInformationV alloc] informationWithTitle:@"出生年月日" SubTitle:@"" TSSubTitle:@"请选择出生年月日" Must:YES Click:YES];
        self.birthday.senterBlock = ^{
            [CGXPickerView showDatePickerWithTitle:@"出生年月日" DateType:UIDatePickerModeDate DefaultSelValue:nil MinDateStr:nil MaxDateStr:nil IsAutoSelect:NO Manager:nil ResultBlock:^(NSString *selectValue) {
                NSLog(@"%@",selectValue);
                weakself.birthday.subfield.text = selectValue;
            }];
        };
        self.address = [[XLInformationV alloc] informationWithTitle:@"住址" SubTitle:@"" TSSubTitle:@"请填写地址" Must:YES Click:NO];
        self.IdNumber = [[XLInformationV alloc] informationWithTitle:@"身份证号码" SubTitle:@"" TSSubTitle:@"请填写身份证号" Must:YES Click:NO];
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


#pragma mark - 其他报名信息
@implementation SignUpFormsV
- (instancetype)init
{
    self = [super init];
    if (self) {
        kWeakSelf(self)
        self.phone = [[XLInformationV alloc] informationWithTitle:@"手机号" SubTitle:@"" TSSubTitle:@"请输入手机号" Must:YES Click:NO];
        self.carType = [[XLInformationV alloc] informationWithTitle:@"车型" SubTitle:@"" TSSubTitle:@"" Must:NO Click:YES];
        self.carType.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"车型" DataSource:@[@"C1",@"C2"] DefaultSelValue:@"C1" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.carType.subfield.text = selectValue;
            }];
        };
        
        self.price = [[XLInformationV alloc] informationWithTitle:@"报考价格" SubTitle:@"" TSSubTitle:@"请输入报名金额" Must:NO Click:NO];
        self.school = [[XLInformationV alloc] informationWithTitle:@"报考驾校" SubTitle:@"" TSSubTitle:@"请选择报考驾校" Must:YES Click:YES];
        self.school.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"报考驾校" DataSource:@[@"报考驾校1",@"报考驾校2"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.school.subfield.text = selectValue;
            }];
        };
        
        self.jiaKao = [[XLInformationV alloc] informationWithTitle:@"是否报名驾考中心" SubTitle:@"" TSSubTitle:@"" Must:NO Click:YES];
        self.jiaKao.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"是否报名驾考中心" DataSource:@[@"是",@"否"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.jiaKao.subfield.text = selectValue;
            }];
        };
        self.type = [[XLInformationV alloc] informationWithTitle:@"申请类型" SubTitle:@"" TSSubTitle:@"请选择申请类型" Must:NO Click:YES];
        self.type.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"申请类型" DataSource:@[@"初次申请",@"再次申请"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.type.subfield.text = selectValue;
            }];
        };
        [self addSubview:self.phone];
        [self addSubview:self.carType];
        [self addSubview:self.price];
        [self addSubview:self.school];
        [self addSubview:self.jiaKao];
        [self addSubview:self.type];
        
        
        NSArray *arr = @[self.phone,self.carType,self.price,self.school,self.jiaKao,self.type];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
        }];
        
    }
    return self;
}


@end


#pragma mark - 其他报名信息 本外地户口
@implementation SignUpTwoFormsV
- (instancetype)init
{
    self = [super init];
    if (self) {
        kWeakSelf(self)
        self.phone = [[XLInformationV alloc] informationWithTitle:@"手机号" SubTitle:@"" TSSubTitle:@"请输入手机号" Must:YES Click:NO];
        
        self.hukou = [[XLInformationV alloc] informationWithTitle:@"本外地" SubTitle:@"" TSSubTitle:@"" Must:YES Click:YES];
        self.hukou.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"本外地" DataSource:@[@"本地",@"外地"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.carType.subfield.text = selectValue;
            }];
        };
        
        self.carType = [[XLInformationV alloc] informationWithTitle:@"车型" SubTitle:@"" TSSubTitle:@"" Must:YES Click:YES];
        self.carType.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"车型" DataSource:@[@"C1",@"C2"] DefaultSelValue:@"C1" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.carType.subfield.text = selectValue;
            }];
        };
        
        
        self.price = [[XLInformationV alloc] informationWithTitle:@"报考价格" SubTitle:@"" TSSubTitle:@"请输入报名金额" Must:YES Click:NO];
        
        self.school = [[XLInformationV alloc] informationWithTitle:@"报考驾校" SubTitle:@"" TSSubTitle:@"请选择报考驾校" Must:YES Click:YES];
        self.school.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"报考驾校" DataSource:@[@"报考驾校1",@"报考驾校2"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.school.subfield.text = selectValue;
            }];
        };
        
//        self.jiaKao = [[XLInformationV alloc] informationWithTitle:@"是否报名驾考中心" SubTitle:@"" TSSubTitle:@"" Must:YES Click:YES];
//        self.jiaKao.senterBlock = ^{
//            [CGXPickerView showStringPickerWithTitle:@"是否报名驾考中心" DataSource:@[@"是",@"否"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
//                NSLog(@"%@",selectValue);
//                weakself.jiaKao.subfield.text = selectValue;
//            }];
//        };
        
        self.type = [[XLInformationV alloc] informationWithTitle:@"申请类型" SubTitle:@"" TSSubTitle:@"请选择申请类型" Must:YES Click:YES];
        self.type.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"申请类型" DataSource:@[@"初次申请",@"再次申请"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.type.subfield.text = selectValue;
            }];
        };
        [self addSubview:self.phone];
        [self addSubview:self.hukou];
        [self addSubview:self.carType];
        [self addSubview:self.price];
        [self addSubview:self.school];
//        [self addSubview:self.jiaKao];
        [self addSubview:self.type];
        
        NSArray *arr = @[self.phone,self.hukou,self.carType,self.price,self.school,self.type];
//        NSArray *arr = @[self.phone,self.hukou,self.carType,self.price,self.school,self.jiaKao,self.type];
        [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:0.1 leadSpacing:0.1 tailSpacing:0.1];
        [arr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
        }];
        
    }
    return self;
}

@end


@implementation OtherFormsV


- (instancetype)init
{
    self = [super init];
    if (self) {
        kWeakSelf(self)
        self.referees = [[XLInformationV alloc] informationWithTitle:@"推荐人" SubTitle:@"" TSSubTitle:@"请输入推荐人" Must:NO Click:NO];
        self.note = [[XLInformationV alloc] informationWithTitle:@"备注" SubTitle:@"" TSSubTitle:@"请输入备注" Must:NO Click:NO];
        self.state = [[XLInformationV alloc] informationWithTitle:@"报考状态" SubTitle:@"" TSSubTitle:@"请选择报考状态" Must:YES Click:YES];
        self.state.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"报考状态" DataSource:@[@"已收费",@"未收费"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.state.subfield.text = selectValue;
            }];
        };
        [self addSubview:self.referees];
        [self addSubview:self.note];
        [self addSubview:self.state];
        
        NSArray *arr = @[self.referees,self.note,self.state];
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
        self.gender = [[XLInformationV alloc] informationWithTitle:@"性别" SubTitle:@"" TSSubTitle:@"" Must:NO Click:YES];
        self.gender.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"性别" DataSource:@[@"男",@"女"] DefaultSelValue:@"男" IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.gender.subfield.text = selectValue;
            }];
        };
        self.school = [[XLInformationV alloc] informationWithTitle:@"驾校" SubTitle:@"" TSSubTitle:@"" Must:NO Click:YES];
        self.school.senterBlock = ^{
            [CGXPickerView showStringPickerWithTitle:@"报考驾校" DataSource:@[@"报考驾校1",@"报考驾校2"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
                NSLog(@"%@",selectValue);
                weakself.school.subfield.text = selectValue;
            }];
        };
        XLInformationV *peixun = [[XLInformationV alloc] informationWithTitle:@"招生培训资料"];
        
        self.seniority = [[XLInformationV alloc] informationWithTitle:@"教龄" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.phone = [[XLInformationV alloc] informationWithTitle:@"招生电话" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.names = [[XLInformationV alloc] informationWithTitle:@"分校名称" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        self.address = [[XLInformationV alloc] informationWithTitle:@"分校地址" SubTitle:@"" TSSubTitle:@"" Must:NO Click:NO];
        
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

- (instancetype)initWithDataArr:(NSMutableArray *)data{
    self = [super init];
    if (self) {
        self.dataArr = data;
    }
    return self;
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    _dataArr = dataArr;
    [_backview removeFromSuperview];
    _backview = [[XLView alloc] init];
    [self addSubview:_backview];
    [_backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self);
    }];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < dataArr.count; i++) {
        XLInformationV *v = [[XLInformationV alloc] informationWithTitle:@"普通课程" CarType:@"C1" SubTitle:@"随到随学" Price:@"2880"];
        v.tag = i;
        kWeakSelf(v)
        v.senterBlock = ^{
            KKLog(@"%ld",(long)weakv.tag);
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









