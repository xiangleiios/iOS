//
//  UILabel+XLlable.h
//  MobileProject
//
//  Created by zsgy on 2018/6/22.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (XLlable)

/// 改变行间距
+ (void)changeLineSpaceForLabel:(UILabel *)label WithSpace:(float)space;
/// 改变字间距
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;
/// 改变行间距和字间距
+ (void)changeSpaceForLabel:(UILabel *)label withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

@end
