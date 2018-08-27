//
//  FMPayCell.h
//  MobileProject
//
//  Created by Mingo on 2017/11/3.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMPayCell : UITableViewCell
@property (nonatomic, strong) FMMainModel *model;
/** <#name#> */
@property (nonatomic, strong) UIView *back;
/** <#name#> */
@property (nonatomic, strong) UIButton *yfCoverIma;
/** <#name#> */
@property (nonatomic, strong) UILabel *yfTitle;
/** <#name#> */
@property (nonatomic, strong) UIImageView *yfSeletImg;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated ;
@end
