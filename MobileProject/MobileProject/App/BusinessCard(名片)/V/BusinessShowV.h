//
//  BusinessShowV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/9/12.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusinessCardListVC.h"
@interface BusinessShowV : UIView
@property (nonatomic , strong)NSArray *dataArr;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)NSMutableArray *butArr;
@property (nonatomic , strong)BusinessCardListVC *vc;
- (void)show;
@end
