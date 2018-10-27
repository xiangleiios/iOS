//
//  ReservationRecordListVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReservationRecordListVC : UIViewController
@property (nonatomic ,assign)int pageNum;
@property (nonatomic , strong)NSDictionary *dic;
@property (nonatomic , strong)NSString *url;
@end

NS_ASSUME_NONNULL_END
