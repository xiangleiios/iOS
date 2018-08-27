//
//  UIColor+FMExtension.h
//  demo
//
//  Created by Mingo on 16/9/26.
//  Copyright © 2016年 袁凤鸣. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FMExtension)
/** 将十六进制颜色转换为 UIColor 对象 &&param color 将十六进制颜色
 *  @param color 将十六进制颜色
 *  @return UIColor
 */
+ (UIColor *)fm_colorWithHexString:(NSString *)color;

//渐变颜色(开始颜色，结束颜色，渐变高度)
+ (UIColor *)getJYGradientColorFromColor:(UIColor*)c1 toColor:(UIColor*)c2 withHeight:(int)height;

@end
