//
//  FMMainModel.h
//  MobileProject
//
//  Created by Mingo on 2017/10/25.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FMSubmodel.h"
#import "FMEnums.h"

@interface MineModel : NSObject
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@end

//"province": "string,省市",
//"this_electric_sum": "string,今年总电量",
//"next_electric_sum": "string,明年总电量",
//"history_sum": "string,累计成交电量",
//"buyer_later": "string,30天新增需求",
//"seller_later": "string,30天新增供电",
//"protocol_url": "string,淘电宝用户服务委托协议url连接",
//"time": "string,统计时间",
//"info_notice": "string,新消息小红点提醒  0 没有 1 有"
@interface HomeModel : NSObject
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *year;
@property (nonatomic, copy) NSString *this_electric_sum;
@property (nonatomic, copy) NSString *next_electric_sum;
@property (nonatomic, copy) NSString *history_sum;
@property (nonatomic, copy) NSString *buyer_later;
@property (nonatomic, copy) NSString *seller_later;
@property (nonatomic, copy) NSString *protocol_url;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign)int info_notice;
@end
//"money_sum": "string,账户总金额",
//"money_free": "string,可用金额",
//"money_freeze": "string,冻结金额",
//"freeze_orders": [
//                  {
//                      "order_num": "string,订单号",
//                      "money": "string,冻结金额"
//                  }
//                  ],
//"money_offline": "string,线下充值待确认金额"
//"action": "string,0 线上充值成功 1 线下充值待审核 2 线下充值成功 3线下充值失败    6服务费首付款支付  7服务费余款支付 8服务费扣减  9订单签订失败服务费首付款退回  ",
//"action_name": "string,0 线上充值成功 1 线下充值待审核 2 线下充值成功 3线下充值失败    6服务费首付款支付  7服务费余款支付 8服务费扣减  9订单签订失败服务费首付款退回  ",
//"money": "string,变动金额",
//"desc": "string,流水描述",
//"datetime": "string,时间",
//"order_num": "string,支付交易号 或 订单号",
//"image": "string,action状态为1，2，3时凭证",
//"option": "string,action状态为1，2，3时审核意见",
//"upload_time": "string,凭证上传时间",
//"pay_type": "string,支付类型 1支付宝  2微信 3银联 4 线下支付"
@interface AccountModel : NSObject
@property (nonatomic, assign) NSInteger money_sum;
@property (nonatomic, assign) NSInteger money_free;
@property (nonatomic, assign) NSInteger money_freeze;
@property (nonatomic, copy) NSArray *freeze_orders;
@property (nonatomic, assign) NSInteger money_offline;
@property (nonatomic , strong)NSString *action;
@property (nonatomic , strong)NSString *action_name;
@property (nonatomic , assign)float money;
@property (nonatomic , strong)NSString *desc;
@property (nonatomic , strong)NSString *datetime;
@property (nonatomic , strong)NSString *order_num;
@property (nonatomic , strong)NSString *image;
@property (nonatomic , strong)NSString *option;
@property (nonatomic , strong)NSString *upload_time;
@property (nonatomic , assign)NSInteger pay_type;
@property (nonatomic , strong)NSString *pay_time;
@end
@interface FMSubmodel : NSObject

@property (nonatomic, assign) NSInteger idid;
@property (nonatomic, copy) NSString * description_field;
@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * url;
@property (nonatomic, assign) NSInteger amount;
@property (nonatomic, copy) NSString * image_url;
@property (nonatomic, assign) NSInteger percent;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, assign) NSInteger branch;
@property (nonatomic, assign) NSInteger area;
@property (nonatomic, copy) NSString * file_url;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * content_title;
@property (nonatomic, copy) NSString * created_at;
@property (nonatomic, copy) NSString * ip;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, copy) NSString * updated_at;
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * avatar_url;
@property (nonatomic, assign) NSInteger content_type;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, copy) NSString * member_name;
@property (nonatomic, copy) NSString * nick_name;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, assign) NSInteger member_id;
@property (nonatomic, assign) NSInteger top;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, assign) NSInteger sort;
@property (nonatomic, assign) NSInteger stock;
@property (nonatomic, copy) NSString *images;
@property (nonatomic, copy) NSString *published_at;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *deleted_at;
@property (nonatomic, assign) NSInteger site_id;
@property (nonatomic, copy) NSString *refer_type;
@property (nonatomic, assign) NSInteger original_price;
@property (nonatomic, assign) NSInteger refer_id;
@property (nonatomic, copy) NSString *unit;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger category_id;
@property (nonatomic, copy) NSString *cover_url;
@property (nonatomic , strong)NSString *subtitle;
@property (nonatomic, assign) NSInteger order_state;
@property (nonatomic , strong)NSString *payed_at;//付款时间

@end


/**
 "teanSchoolId": ,
 "teamCode": ,
 "deptId": null,
 "deptFatherName": 所属驾校,
 "name": 分校名称,
 "leader":负责人 ,
 "leaderIdCard":负责人身份证号码 ,
 "phone": 联系电话,
 "businessStatus": ,
 "teamType": ,
 "payType": 0,
 "residencePermitCost": 0,
 "manageCost": 0,
 "physicalCost": 0,
 "subjectOneCost": 0,
 "subjectTwoCost": 0,
 "subjectThreeCost": 0,
 "ensureCost": 保证金,
 "signUpCost": 0,
 "contractTimeStart":合同起始时间,
 "contractTimeEnd": 合同结束时间,
 "upperLimitNumber": 报名上限,
 "address": 地址,
 "remark": 备注,
 "del": null,
 "idCardFrontUrl": 身份证正面,
 "idCardBackUrl": 身份证反面,
 "contractUrl": 合同图片,
 "createBy": null,
 "createTime": null,
 "updateBy": null,
 "updateTime": null,
 "deptIds": null,
 "contractTimeStartS": null,
 "contractTimeStartE": null,
 "contractTimeEndS": null,
 "contractTimeEndE": null,
 "unpaidPrice": 0,
 "signUpPrice": 0,
 "teamSchoolCarCount": 车辆数量,
 "teamSchoolStudentCount": 已报名学员数量,
 "typeName": 分队类型,
 "payName": 缴费类型
 */

#pragma mark - FMMainModel
@interface FMMainModel : NSObject
@property (nonatomic , strong)NSArray *images;

@property (nonatomic , strong)NSString *teanSchoolId;
@property (nonatomic , strong)NSString *teamCode;
@property (nonatomic , strong)NSString *deptId;
@property (nonatomic , strong)NSString *deptFatherName;// 所属驾校,
@property (nonatomic , strong)NSString *name;// 分校名称,
@property (nonatomic , strong)NSString *leader;//负责人 ,
@property (nonatomic , strong)NSString *leaderIdCard;//负责人身份证号码 ,
@property (nonatomic , strong)NSString *phone;// 联系电话,
@property (nonatomic , strong)NSString *businessStatus;//
@property (nonatomic , strong)NSString *teamType;//
@property (nonatomic , strong)NSString *payType;//
@property (nonatomic , strong)NSString *residencePermitCost;//
@property (nonatomic , strong)NSString *manageCost;//
@property (nonatomic , strong)NSString *physicalCost;//
@property (nonatomic , strong)NSString *subjectOneCost;//
@property (nonatomic , strong)NSString *subjectTwoCost;//
@property (nonatomic , strong)NSString *subjectThreeCost;//
@property (nonatomic , strong)NSString *ensureCost;// 保证金,
@property (nonatomic , strong)NSString *signUpCost;// 0,
@property (nonatomic , strong)NSString *contractTimeStart;//合同起始时间,
@property (nonatomic , strong)NSString *contractTimeEnd;// 合同结束时间,
@property (nonatomic , strong)NSString *upperLimitNumber;// 报名上限,
@property (nonatomic , strong)NSString *address;// 地址,
@property (nonatomic , strong)NSString *remark;// 备注,
@property (nonatomic , strong)NSString *del;//
@property (nonatomic , strong)NSString *idCardFrontUrl;//身份证正面,
@property (nonatomic , strong)NSString *idCardBackUrl;// 身份证反面,
@property (nonatomic , strong)NSString *contractUrl;// 合同图片,
//@property (nonatomic , strong)NSString *createBy;//
//@property (nonatomic , strong)NSString *createTime;//
//@property (nonatomic , strong)NSString *updateBy;//
//@property (nonatomic , strong)NSString *updateTime;//
@property (nonatomic , strong)NSString *deptIds;//
@property (nonatomic , strong)NSString *contractTimeStartS;//
@property (nonatomic , strong)NSString *contractTimeStartE;//
@property (nonatomic , strong)NSString *contractTimeEndS;//
@property (nonatomic , strong)NSString *contractTimeEndE;//
@property (nonatomic , strong)NSString *unpaidPrice;//
@property (nonatomic , strong)NSString *signUpPrice;//
@property (nonatomic , strong)NSString *teamSchoolCarCount;// 车辆数量,
@property (nonatomic , strong)NSString *teamSchoolStudentCount;// 已报名学员数量,
@property (nonatomic , strong)NSString *typeName;// 分队类型,
@property (nonatomic , strong)NSString *payName;// 缴费类型

@property (nonatomic , strong)NSString *searchValue;//
@property (nonatomic , strong)NSString *createBy;//测试人",
@property (nonatomic , strong)NSString *createTime;//2018-08-31T14:36:46.000+0800",
@property (nonatomic , strong)NSString *updateBy;//
@property (nonatomic , strong)NSString *updateTime;//
//@property (nonatomic , strong)NSString *remark;// 备注,
@property (nonatomic , strong)NSString *params;//
@property (nonatomic , strong)NSString *idid;//
@property (nonatomic , strong)NSString *schoolId;// 229,
@property (nonatomic , strong)NSString *trainingId;// null,
@property (nonatomic , strong)NSString *carNumber;// 车辆编号,
@property (nonatomic , strong)NSString *user;// 负责人,
@property (nonatomic , strong)NSString *userPhoneNumber;// 联系电话,
@property (nonatomic , strong)NSString *carType;//车辆类型,
@property (nonatomic , strong)NSString *carName;// 车辆名称,
@property (nonatomic , strong)NSString *vin;// 车架号,
@property (nonatomic , strong)NSString *plateNumber;// 车牌号,
@property (nonatomic , strong)NSString *plateTrumpet;// null,
@property (nonatomic , strong)NSString *engineNumber;// 发动机,
@property (nonatomic , strong)NSString *reducibleNumber;// 200,
@property (nonatomic , strong)NSString *buyTime;//购买日期,
@property (nonatomic , strong)NSString *annualVerificationTime;//"2018-08-31T00:00:00.000+0800",
@property (nonatomic , strong)NSString *registerTime;// 注册日期,
@property (nonatomic , strong)NSString *isRegistration;// "0",
@property (nonatomic , strong)NSString *registrationCertificatePic;// null,
@property (nonatomic , strong)NSString *registrationCertificateValidityPeriod;//"2018-08-31T00:00:00.000+0800",
@property (nonatomic , strong)NSString *scrapTime;//"2019-12-31T00:00:00.000+0800",
@property (nonatomic , strong)NSString *isTransportationLicense;//
@property (nonatomic , strong)NSString *transportationLicenseIssueTime;//
@property (nonatomic , strong)NSString *transportationLicenseNumber;//null,
@property (nonatomic , strong)NSString *transportationLicenseExpireTime;// null,
@property (nonatomic , strong)NSString *transportationLicenseNextCheckTime;// null,
@property (nonatomic , strong)NSString *transportationLicensePic;// null,
@property (nonatomic , strong)NSString *isRating;// 等级评定 1 是， 0 无,
@property (nonatomic , strong)NSString *ratingLevel;// 等级评定级别 1 一级 2二级 3三级,
@property (nonatomic , strong)NSString *ratingTime;// 等级评定日期,
@property (nonatomic , strong)NSString *ratingExpireTime;// 等级评定有效期,
@property (nonatomic , strong)NSString *ratingNextCheckTime;// 下次等级评定日期,
@property (nonatomic , strong)NSString *ratingLevelPic;// 等级评定扫描照片,
@property (nonatomic , strong)NSString *trafficInsuranceCompanyName;// 交保险公司,
@property (nonatomic , strong)NSString *trafficInsuranceBuyTime;// 强险购买日期,
@property (nonatomic , strong)NSString *trafficInsuranceExpireTime;// 强险到期日期,
@property (nonatomic , strong)NSString *trafficInsurancePic;// 等级评定扫描照片,
@property (nonatomic , strong)NSString *businessInsuranceCompanyName;// 商险公司,
@property (nonatomic , strong)NSString *businessInsuranceBuyTime;// 商险购买日期,
@property (nonatomic , strong)NSString *businessInsuranceExpireTime;// 商险到期日期,
@property (nonatomic , strong)NSString *businessInsurancePic;// 交强险扫描件照片,
@property (nonatomic , strong)NSString *carPic;// "group1/M00/00/04/rBA3PluI4fuAMkaYAARzrxW7y6o871.jpg",
@property (nonatomic , strong)NSString *purchaseTaxPic;// "group1/M00/00/04/rBA3PluI4fOAZ1HyAARzrxW7y6o680.jpg",
@property (nonatomic , strong)NSString *invoicePic;//"group1/M00/00/04/rBA3PluI4fWAToQAAARzrxW7y6o438.jpg",
@property (nonatomic , strong)NSString *otherPic;// "group1/M00/00/04/rBA3PluI4feATgarAARzrxW7y6o534.jpg",
@property (nonatomic , strong)NSString *isDel;// 0,
@property (nonatomic , strong)NSString *schoolName;// 所属队别,
@property (nonatomic , strong)NSString *queryRegisterTimeStart;// null,
@property (nonatomic , strong)NSString *queryRegisterTimeEnd;// null

@property (nonatomic , strong)NSString *applicationType;
@property (nonatomic , strong)NSString *birthday;
//@property (nonatomic , strong)NSString *carType;
@property (nonatomic , strong)NSString *classType;
@property (nonatomic , strong)NSString *day;
@property (nonatomic , strong)NSString *delTag;
@property (nonatomic , strong)NSString *enterType;
//@property (nonatomic , strong)NSString *id;
@property (nonatomic , strong)NSString *idType;
@property (nonatomic , strong)NSString *idcard;
@property (nonatomic , strong)NSString *idcardAddress;
@property (nonatomic , strong)NSString *idcardBack;
@property (nonatomic , strong)NSString *idcardEndDate;
@property (nonatomic , strong)NSString *idcardFront;
@property (nonatomic , strong)NSString *idcardStartDate;
@property (nonatomic , strong)NSString *isComplete;
@property (nonatomic , strong)NSString *isPay;
@property (nonatomic , strong)NSString *month;
@property (nonatomic , strong)NSString *nation;
@property (nonatomic , strong)NSString *payMethod;
//@property (nonatomic , strong)NSString *payType;
@property (nonatomic , strong)NSString *recommender;
@property (nonatomic , strong)NSString *relation;
//@property (nonatomic , strong)NSString *remark;
@property (nonatomic , strong)NSString *repaymentTime;
//@property (nonatomic , strong)NSString *searchValue;
@property (nonatomic , strong)NSString *sex;
@property (nonatomic , strong)NSString *signupId;
@property (nonatomic , strong)NSString *signupPrice;
@property (nonatomic , strong)NSString *signupTime;
@property (nonatomic , strong)NSString *source;
@property (nonatomic , strong)NSString *studentHead;
@property (nonatomic , strong)NSString *studentName;
@property (nonatomic , strong)NSString *studentPhone;
//@property (nonatomic , strong)NSString *teamCode;
@property (nonatomic , strong)NSString *week;
@property (nonatomic , strong)NSString *whichProduce;
@property (nonatomic , strong)NSString *year;
@property (nonatomic , strong)NSString *signupState;  /// 1 报名到总校，2、未报名到总校
@property (nonatomic , strong)NSString *auditState;  /// 默认1 未审核，2、审核通过、3、拒绝

@property (nonatomic , strong)NSString *deptName; ///分队名称
@property (nonatomic , strong)NSString *enrollPhone;  ///招生电话
@property (nonatomic , strong)NSString *isShow;  //是否展示（1：默认展示 2：不展示）
@property (nonatomic , strong)NSString *headImg; //头像
@property (nonatomic , strong)NSString *schoolDeptId;  //驾校部门id
@property (nonatomic , strong)NSString *coachAge; //教龄

@property (nonatomic , strong)NSString *deptAddress; //分队地址
@property (nonatomic , strong)NSArray *classList; // 班型信息
@property (nonatomic , strong)NSString *introduce; // 自我介绍
@property (nonatomic , strong)NSString *url1; //风景图
@property (nonatomic , strong)NSString *url2;
@property (nonatomic , strong)NSString *url3;
@property (nonatomic , strong)NSString *url4;
@property (nonatomic , strong)NSString *url5;
@property (nonatomic , strong)NSString *url6;
@property (nonatomic , strong)NSString *url7;
@property (nonatomic , strong)NSString *url8;
@property (nonatomic , strong)NSString *url9;
@property (nonatomic , strong)NSString *scanPhotoIp; // 图片链接前缀
@property (nonatomic , strong)NSString *title; //消息标题
@property (nonatomic , strong)NSString *content; //消息类容
@property (nonatomic ,assign)int isRead;//是否已读
@end



