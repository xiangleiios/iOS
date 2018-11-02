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
@property (nonatomic , strong)NSArray *dataArr;
@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)UIScrollView *backview;
@property (nonatomic , strong)UILabel *tslb;
@property (nonatomic , strong)NSArray *titleArr;
@property (nonatomic , strong)NSArray *imgArr;
@end

NS_ASSUME_NONNULL_END
