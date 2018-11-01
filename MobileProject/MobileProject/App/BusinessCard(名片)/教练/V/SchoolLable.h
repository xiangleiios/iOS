//
//  SchoolLable.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/31.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLView.h"
#import "XLInformationV.h"
NS_ASSUME_NONNULL_BEGIN

@interface SchoolLable : XLView
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)UIView *backview;
@property (nonatomic , strong)UILabel *tslb;
@end

NS_ASSUME_NONNULL_END
