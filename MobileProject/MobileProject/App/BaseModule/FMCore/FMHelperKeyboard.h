//
//  FMHelperKeyboard.h
//  MobileProject
//
//  Created by Mingo on 2017/9/6.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMHelperKeyboard : NSObject

/// 添加键盘通知
+ (void)addKeyboardNotification:(id)object showSel:(SEL)showSel hiddenSel:(SEL)hiddenSel;

/// 移除键盘通知
+ (void)removeKeyboardNotification:(id)object;

/// 根据键盘弹出的通知，获取键盘的高度
+ (CGFloat)getKeyboardFromNotification:(NSNotification *)nofification;

/// 当弹出键盘时，判断view位置和scrollView滑动的坐标
+ (void)changeScrollViewContentOffsetForViewNowPoint:(UIScrollView *)scrollView view:(UIView *)view;

@end
