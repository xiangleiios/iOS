//
//  FMHelperKeyboard.m
//  MobileProject
//
//  Created by Mingo on 2017/9/6.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMHelperKeyboard.h"

@implementation FMHelperKeyboard

#pragma mark - 添加键盘通知
+ (void)addKeyboardNotification:(id)object showSel:(SEL)showSel hiddenSel:(SEL)hiddenSel{
    
    [[NSNotificationCenter defaultCenter] addObserver:object selector:showSel name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:object selector:hiddenSel name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 移除键盘通知
+ (void)removeKeyboardNotification:(id)object{
    
    [[NSNotificationCenter defaultCenter] removeObserver:object name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:object name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - 根据键盘弹出的通知，获取键盘的高度
+ (CGFloat)getKeyboardFromNotification:(NSNotification *)nofification{
    
    NSDictionary *info = [nofification userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    return keyboardSize.height;
}

#pragma mark - 当弹出键盘时，判断view位置和scrollView滑动的坐标
+ (void)changeScrollViewContentOffsetForViewNowPoint:(UIScrollView *)scrollView view:(UIView *)view{
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGPoint point = [view convertPoint:CGPointMake(0, 0) toView:keyWindow];
    //屏幕高度
    CGFloat windowHeight = CGRectGetHeight(keyWindow.frame);
    //键盘高度（假定）
    CGFloat keyBoardHeight = 270;
    //view距离window最上方距离
    CGFloat viewY = point.y;
    //view距离键盘的距离
    CGFloat viewKeyBoardSpaceHeight = windowHeight - keyBoardHeight - viewY;
    
    //如果view在键盘之外,则移动scrollView
    if (viewKeyBoardSpaceHeight < CGRectGetHeight(view.frame)) {
        
        CGFloat nowScrollViewOffetY = scrollView.contentOffset.y;
        CGFloat newScrollViewOffetY = nowScrollViewOffetY - viewKeyBoardSpaceHeight + CGRectGetHeight(view.frame) + 15;
        // [scrollView setContentOffset:CGPointMake(0, newScrollViewOffetY) animated:YES];
        
        [UIView animateWithDuration:0.25 delay:0.05 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            scrollView.contentOffset = CGPointMake(0, newScrollViewOffetY);
            
        } completion:nil];
    }
}


@end
