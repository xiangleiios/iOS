//
//  FMCountDownButton.h
//  FMCountDownButton
//
//  Created by Jakey on 15/3/8.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//  https://github.com/shaojiankui/FMCountDownButton

#import <UIKit/UIKit.h>
@class FMCountDownButton;
typedef NSString* (^CountDownChanging)(FMCountDownButton *countDownButton,NSUInteger second);
typedef NSString* (^CountDownFinished)(FMCountDownButton *countDownButton,NSUInteger second);
typedef void (^TouchedCountDownButtonHandler)(FMCountDownButton *countDownButton,NSInteger tag);

@interface FMCountDownButton : UIButton
@property(nonatomic,strong) id userInfo;
///倒计时按钮点击回调
- (void)countDownButtonHandler:(TouchedCountDownButtonHandler)touchedCountDownButtonHandler;
//倒计时时间改变回调
- (void)countDownChanging:(CountDownChanging)countDownChanging;
//倒计时结束回调
- (void)countDownFinished:(CountDownFinished)countDownFinished;
///开始倒计时
- (void)startCountDownWithSecond:(NSUInteger)second;
///停止倒计时
- (void)stopCountDown;
@end
