//
//  InputV.h
//  XLProject
//
//  Created by zsgy on 17/6/8.
//  Copyright © 2017年 zsgy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLInputvc;
/*
 *键盘类型
 */
typedef NS_ENUM(NSInteger, TLChatBoxStatus) {
    TLChatBoxStatusNothing,      //空
    TLChatBoxStatusShowVoice,    //语音输入
    TLChatBoxStatusShowFace,    //表情
    TLChatBoxStatusShowMore,    //更多功能
    TLChatBoxStatusShowKeyboard,  //键盘
};
@class InputV;
@protocol InputVDelegate <NSObject>
/*
 *输入框状态切换时的代理
 */
- (void)chatBox:(InputV *)chatBox changeStatusForm:(TLChatBoxStatus)fromStatus to:(TLChatBoxStatus)toStatus;
/*
 *textview 高度改变的代理方法
 */
- (void)chatBox:(InputV *)chatBox changeChatBoxHeight:(CGFloat)height;

- (void)chatBox:(InputV *)chatBox sendTextMessage:(NSString *)textMessage;

- (void)chatBox:(InputV *)chatBox isSendCommentContentComplete:(BOOL)isComplete;
@end

@interface InputV : UIView

/*
 *输入框
 */
@property (nonatomic, strong) UITextView *textView;
/*
 *表情
 */
@property (nonatomic, strong) UIButton *faceButton;
/*
 *更多
 */
@property (nonatomic, strong) UIButton *moreButton;
/*
 *发送
 */
@property (nonatomic, strong) UIButton *sendButton;

@property (nonatomic, strong) XLInputvc * vc;

@property (nonatomic, assign) TLChatBoxStatus status;//键盘当前状态
@property (nonatomic, assign) id<InputVDelegate>delegate;
@property (nonatomic, assign) CGFloat curHeight;
@end
