//
//  FMFillOrdeCell.h
//  MobileProject
//
//  Created by Mingo on 2017/11/2.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMFillOrdeCell : UITableViewCell
@property (nonatomic, strong) FMSubmodel *model;
/** <#name#> */
@property (nonatomic, strong) UIView *back;
/** <#name#> */
@property (nonatomic, strong) UILabel *yfTitle;
/** <#name#> */
@property (nonatomic, strong) UILabel *yfMoney;
@end
