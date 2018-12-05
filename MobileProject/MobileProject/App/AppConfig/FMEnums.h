//
//  FMEnums.h
//  MobileProject
//
//  Created by Mingo on 2017/8/9.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#ifndef FMEnums_h
#define FMEnums_h




typedef NS_ENUM(NSInteger, CellType) {
    CellTypeSuoShuJiaXiao = 0,  // 所属驾校cell
    CellTypeCheLiangGuanLi = 1,  //  车辆管理cell
    CellTypeBaoMinXueYuan = 2   //   报名学员Cell
};


typedef NS_ENUM(NSInteger, ShareType) {
    ShareTypeText = 1, // 分享图文
    ShareTypeImage = 2 // 分享图片
};

typedef NS_ENUM(NSInteger, PostersListType) {
    PostersListTypeAll = 1, // 公共海报列表
    PostersListTypeMy = 2 // 我的海报列表
};



typedef NS_ENUM(NSInteger, accountType) {
    accountTypePhone = 1,
    accountTypeQQ = 2,
    accountTypeWX = 3,
    accountTypeWB = 4,
 
};
//account


typedef NS_ENUM(NSInteger, SearchType) {
    SearchTypeCoach = 1, // 搜索教练
    SearchTypeStudent = 2, // 搜索咨询学员
    SearchTypeExamStudent = 3 // 搜索考试学员
};



#endif /* FMEnums_h */
