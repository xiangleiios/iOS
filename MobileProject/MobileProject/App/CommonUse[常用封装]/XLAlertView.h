//
//  XLAlertView.h
//  MobileProject
//
//  Created by zsgy on 2017/12/13.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AlertResult)(NSInteger index);
typedef void(^AlertInput)(NSString * text);
@interface XLAlertView : UIView
@property (nonatomic,copy) AlertResult resultIndex;
@property (nonatomic,copy) AlertInput inputText;
//输入框
@property (nonatomic,retain) UITextField *input;
///文字提示框
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

///两个图文按钮
- (instancetype)initWithButTitle:(NSString *)titleOne ButImg:(NSString *)imgOne titleTwo:(NSString *)titleTwo ButimgTwo:(NSString *)imgTwo;
///网络 成功失败 提示
- (instancetype)initWithMessage:(NSString *)message SuccessOrFailure:(BOOL)bol;
/// 文字提示
- (instancetype)initWithMessage:(NSString *)message;
/// 弹出输入框
- (instancetype)initWithInputboxTitle:(NSString *)title;

- (void)showXLAlertView;

- (void)showPrompt; //一秒自动消失
@end
