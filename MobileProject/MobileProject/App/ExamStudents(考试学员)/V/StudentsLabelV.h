//
//  StudentsLabelV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLView.h"

NS_ASSUME_NONNULL_BEGIN

@interface StudentsLabelV : XLView
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)NSMutableArray *selectDataArr;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)UIButton *addBut;
@property (nonatomic , strong)NSMutableArray *selectDataArrNew;
- (void)relodData;
@end

NS_ASSUME_NONNULL_END
