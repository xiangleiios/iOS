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


@interface HomeModel : NSObject

@end

@interface TageModel : NSObject
@property (nonatomic , assign)NSInteger tagId;
@property (nonatomic , strong)NSString *tagTitle;
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
/// 是否展示（1：默认展示 2：不展示）
@property (nonatomic , strong)NSString *isShow;
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
@property (nonatomic , assign)int useNum;
@property (nonatomic , strong)NSString *tittle;//标题
@property (nonatomic , strong)NSString *imgUrl;
@property (nonatomic , strong)NSArray *imgArrary;//
@property (nonatomic , strong)NSString *moduleCode;//模板编号
@property (nonatomic , strong)NSString *memo;//
@property (nonatomic , strong)NSString *resource;
@property (nonatomic , strong)NSString *tags;//标签
@property (nonatomic , strong)NSString *stuTags;
@property (nonatomic , assign)int progress; ///科一  科二
@property (nonatomic , assign)int failNum;
@property (nonatomic , strong)NSDictionary *student;
@property (nonatomic , strong)NSString *teamTrainingName;///训练场名
@property (nonatomic , strong)NSString *province;
@property (nonatomic , strong)NSString *provinceStr;
@property (nonatomic , strong)NSString *city;
@property (nonatomic , strong)NSString *cityStr;
@property (nonatomic , strong)NSString *area;
@property (nonatomic , strong)NSString *areaStr;
@property (nonatomic , strong)NSString *teamSchoolName;
@property (nonatomic , strong)NSString *teamSchoolId;
@property (nonatomic , strong)NSString *teamTrainingId;
@property (nonatomic , strong)NSDictionary *teamTrainning;
@property (nonatomic , strong)NSString *todayNum;
@property (nonatomic , strong)NSString *startTime;
@property (nonatomic , strong)NSString *endTime;
@property (nonatomic , strong)NSString *keMu;
@property (nonatomic , strong)NSString *licenseType;
@property (nonatomic , strong)NSString *trainingName;
@property (nonatomic , strong)NSString *sysStudentCode;
@property (nonatomic , strong)NSString *endDay;
@property (nonatomic , strong)NSString *startDay;
@property (nonatomic , strong)NSArray *trainingRecords;
@property (nonatomic , strong)NSString *trainingTime;
@property (nonatomic , strong)NSString *type;
@property (nonatomic , strong)NSString *trainingAddress;
@property (nonatomic , strong)NSString *isCancel;
@property (nonatomic , assign)BOOL falg;
@property (nonatomic , assign)NSInteger cueForCoach;
@property (nonatomic , strong)NSString *wxHead;
@property (nonatomic , assign)BOOL perfectStatus; //完善状态
@property (nonatomic , strong)NSString *teamSchoolTags; /// 展示标签 多个用逗号分隔
@property (nonatomic , strong)NSString *schoolAptitude; /// 驾校资质
@property (nonatomic , strong)NSString *brandAuthentication; /// 驾校认证
@property (nonatomic , strong)NSString *schoolHonor; /// 驾校荣誉

@property (nonatomic , strong)NSString *coachHonor;///教练荣誉
@property (nonatomic , strong)NSString *teachHarvest; ///教学成果
@property (nonatomic , strong)NSString *enrollCode;
@property (nonatomic , strong)NSString *stuHead;
@property (nonatomic , strong)NSArray *replyList;
@property (nonatomic , strong)NSString *praiseNum;
@property (nonatomic , assign)float appraiseScore;
@property (nonatomic , assign)float averageScore;
@property (nonatomic , assign)int hasStart; /// 《null》 未点赞
@property (nonatomic , strong)NSString *appraiseId;
@property (nonatomic , strong)NSString *headPic;
@property (nonatomic , assign)int enrollStudentCount;
@property (nonatomic , assign)BOOL isDimission;
@property (nonatomic , strong)NSString *licenses;
@property (nonatomic , strong)NSString *coachId;
@property (nonatomic , assign)BOOL isCheck;
@property (nonatomic , assign)CGFloat latitude;///纬度
@property (nonatomic , assign)CGFloat longitude;///经度
@property (nonatomic , strong)NSString *detailAddress;

@property (nonatomic , strong)NSString *county;
@property (nonatomic , strong)NSString *provice;
@property (nonatomic , strong)NSString *schoolrankingCount;
@property (nonatomic , strong)NSString *teamSchoolrankingCount;
@property (nonatomic , strong)NSString *compScore;
@property (nonatomic , strong)NSString *coachPhone;
@property (nonatomic , strong)NSString *coachName;
@property (nonatomic , strong)NSString *originalDeptName;
@property (nonatomic , strong)NSDictionary *rankingMap;
@property (nonatomic , strong)NSArray *coachIds;
@property (nonatomic , assign)BOOL coachStatus;
@property (nonatomic , strong)NSString *demo;
@end



