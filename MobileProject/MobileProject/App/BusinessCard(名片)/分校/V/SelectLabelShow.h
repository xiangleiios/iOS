//
//  SelectLabelShow.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/2.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolLable.h"
NS_ASSUME_NONNULL_BEGIN

@interface SelectLabelShow : UIView
@property (nonatomic , strong)NSArray *dataArr;
@property (nonatomic , strong)NSArray *titleArr;
@property (nonatomic , strong)NSMutableArray *butArr;
@property (nonatomic , strong)NSMutableArray *SelectButArr;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)SchoolLable *schoollb;
- (void)show;
@end

NS_ASSUME_NONNULL_END
