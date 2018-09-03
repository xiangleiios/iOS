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
@end



