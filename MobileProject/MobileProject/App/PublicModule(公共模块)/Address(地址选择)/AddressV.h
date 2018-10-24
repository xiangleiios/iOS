//
//  AddressV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrainingVC.h"
NS_ASSUME_NONNULL_BEGIN

@interface AddressV : UIView
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)NSString *url;
@property (nonatomic , strong)NSDictionary *dic;
@property (nonatomic , assign)int num;
@property (nonatomic , weak)TrainingVC *vc;
- (void)show;
@end

NS_ASSUME_NONNULL_END
