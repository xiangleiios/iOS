//
//  FMSchoolModel.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//address = "\U6b66\U73de\U8def";
//area = "\U6b66\U660c\U533a";
//city = "\U6b66\U6c49\U5e02";
//code = "<null>";
//createBy = admin;
//createTime = "2018-09-19 18:58:55";
//deptId = 67;
//leader = "\U6d4b\U8bd53";
//name = "\U6d4b\U8bd5\U9a7e\U68213";
//params =             {
//};
//phone = 13101234567;
//province = "\U6e56\U5317\U7701";
//remark = "<null>";
//schoolId = 8;
//searchValue = "<null>";
//status = 0;
//updateBy = "";
//updateTime = "<null>";
//userId = 22;
@interface FMSchoolModel : NSObject
@property (nonatomic , strong)NSString *name;
@property (nonatomic , strong)NSString *code;
@property (nonatomic , strong)NSString *leader;
@property (nonatomic , strong)NSString *phone;
@property (nonatomic , strong)NSString *province;
@property (nonatomic , strong)NSString *schoolId;
@property (nonatomic , strong)NSString *userId;
@property (nonatomic , strong)NSString *deptId;
@property (nonatomic , strong)NSString *teanSchoolId;


@end

NS_ASSUME_NONNULL_END
