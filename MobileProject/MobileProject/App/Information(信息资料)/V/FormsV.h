//
//  FormsV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLView.h"
#import "XLInformationV.h"

#pragma mark - 身份证正面表单
@interface FormsV : XLView
/// 姓名
@property (nonatomic , strong)XLInformationV *name;
/// 性别
@property (nonatomic , strong)XLInformationV *gender;
/// 名族
@property (nonatomic , strong)XLInformationV *ethnic;
/// 生日
@property (nonatomic , strong)XLInformationV *birthday;
/// 地址
@property (nonatomic , strong)XLInformationV *address;
/// 身份证号
@property (nonatomic , strong)XLInformationV *IdNumber;

@end

#pragma mark - 报考信息表单
@interface SignUpFormsV : XLView
/// 手机号
@property (nonatomic , strong)XLInformationV *phone;
/// 车型
@property (nonatomic , strong)XLInformationV *carType;
/// 报考价格
@property (nonatomic , strong)XLInformationV *price;
/// 报考驾校
@property (nonatomic , strong)XLInformationV *school;
/// 是否报名驾考中心
//@property (nonatomic , strong)XLInformationV *jiaKao;
/// 申请类型
@property (nonatomic , strong)XLInformationV *type;

@end


#pragma mark - 报考信息表单2
@interface SignUpTwoFormsV : XLView
/// 手机号
@property (nonatomic , strong)XLInformationV *phone;
/// 户口
@property (nonatomic , strong)XLInformationV *hukou;
/// 车型
@property (nonatomic , strong)XLInformationV *carType;
/// 报考价格
@property (nonatomic , strong)XLInformationV *price;
/// 报考驾校
@property (nonatomic , strong)XLInformationV *school;
/// 是否报名驾考中心
@property (nonatomic , strong)XLInformationV *jiaKao;
/// 申请类型
@property (nonatomic , strong)XLInformationV *type;

@end






#pragma mark - 其他报考信息表单
@interface OtherFormsV : XLView
/// 推荐人
@property (nonatomic , strong)XLInformationV *referees;
/// 备注
@property (nonatomic , strong)XLInformationV *note;
/// 报名状态
@property (nonatomic , strong)XLInformationV *state;


@end

#pragma mark - 招生名片基本资料表单
@interface AdmissionsFormsV : XLView
/// 姓名
@property (nonatomic , strong)XLInformationV *name;
/// 性别
@property (nonatomic , strong)XLInformationV *gender;
/// 驾校
@property (nonatomic , strong)XLInformationV *school;
/// 工龄
@property (nonatomic , strong)XLInformationV *seniority;
/// 招生电话
@property (nonatomic , strong)XLInformationV *phone;
/// 分校名称
@property (nonatomic , strong)XLInformationV *names;
/// 分校地址
@property (nonatomic , strong)XLInformationV *address;


@end


#pragma mark - 课程表单
@interface CourseFormsV : XLView
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)XLView *backview;
- (instancetype)initWithDataArr:(NSMutableArray *)data;
@end




