//
//  StudentsListTwoVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/28.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

//#import "FMBaseViewController.h"
#import <UIKit/UIKit.h>
@interface StudentsListTwoVC : UIViewController
@property (nonatomic , strong)NSString *url;
/** 列表page编号 */
@property(nonatomic, assign) NSInteger pageNum;
/** 列表page大小 */
@property(nonatomic, assign) NSInteger pageSize;

@property (nonatomic , strong)NSMutableDictionary *dic;
@property (nonatomic , assign)BOOL PayCost;
@end
