//
//  XLColumnsV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/17.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLColumnsV : UIView
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UIImageView *img;
/// #颜色 文字
- (instancetype)initWithTitle:(NSString *)title Color:(UIColor *)color;
/// #图片 文字
- (instancetype)initWithTitle:(NSString *)title IMG:(NSString *)img;
@end
