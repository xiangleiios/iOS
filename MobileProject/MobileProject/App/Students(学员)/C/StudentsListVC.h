//
//  StudentsListVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/24.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

//#import "FMBaseViewController.h"
#import <UIKit/UIKit.h>
@interface StudentsListVC : UIViewController
@property (nonatomic , strong)NSString *url;
@property (nonatomic , assign)BOOL PayCost;
/** 列表page编号 */
@property(nonatomic, assign) NSInteger pageNum;
/** 列表page大小 */
@property(nonatomic, assign) NSInteger pageSize;

@property (nonatomic , strong)NSMutableDictionary *dic;
- (void)headerRefresh;
@end
