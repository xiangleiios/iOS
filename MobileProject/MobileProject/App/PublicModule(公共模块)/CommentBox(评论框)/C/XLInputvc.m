//
//  XLInputvc.m
//  XLProject
//
//  Created by zsgy on 17/6/8.
//  Copyright © 2017年 zsgy. All rights reserved.
//

#import "XLInputvc.h"

#import "MoreView.h"
#import "FaceView.h"
#import "UIView+TL.h"

@interface XLInputvc ()<InputVDelegate>
@property (nonatomic, assign) CGRect keyboardFrame;
@property (nonatomic, strong) MoreView *chatBoxMoreView;
@property (nonatomic, strong) FaceView *chatBoxFaceView;
@end

@implementation XLInputvc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    //加载输入视图
    [self Loadtheinputview];
     /*  键盘通知 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark-加载输入视图
- (void)Loadtheinputview{
    self.input=[[InputV alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT_INPUT)];
    [self.view addSubview:self.input];
    self.input.delegate=self;
    self.input.vc=self;
//    self.input.model = self.model;
}

#pragma mark-键盘通知方法
- (void)keyboardWillHide:(NSNotification *)notification{
    self.keyboardFrame = CGRectZero;
    if (_input.status == TLChatBoxStatusShowFace || _input.status == TLChatBoxStatusShowMore) {
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
        [_delegate chatBoxViewController:self didChangeChatBoxHeight:self.input.curHeight];
    }
}

- (void)keyboardFrameWillChange:(NSNotification *)notification{
    self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (_input.status == TLChatBoxStatusShowKeyboard && self.keyboardFrame.size.height <= HEIGHT_CHATBOXVIEW) {
        return;
    }
    else if ((_input.status == TLChatBoxStatusShowFace || _input.status == TLChatBoxStatusShowMore) && self.keyboardFrame.size.height <= HEIGHT_CHATBOXVIEW) {
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
        [_delegate chatBoxViewController:self didChangeChatBoxHeight: self.keyboardFrame.size.height + self.input.curHeight];
    }
}


#pragma mark-input代理方法
- (void)chatBox:(InputV *)chatBox isSendCommentContentComplete:(BOOL)isComplete {

    if (isComplete) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(chatBoxViewController:isSendCommentContentComplete:)]) {
            [self.delegate chatBoxViewController:self isSendCommentContentComplete:isComplete];
        }
    }
}

- (void)chatBox:(InputV *)chatBox changeChatBoxHeight:(CGFloat)height {
    self.chatBoxFaceView.originY = height;
    self.chatBoxMoreView.originY = height;
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
        float h = (self.input.status == TLChatBoxStatusShowFace ? HEIGHT_CHATBOXVIEW : self.keyboardFrame.size.height ) + height;
        [_delegate chatBoxViewController:self didChangeChatBoxHeight: h];
    }
}

- (void) chatBox:(InputV *)chatBox changeStatusForm:(TLChatBoxStatus)fromStatus to:(TLChatBoxStatus)toStatus {
    if (toStatus == TLChatBoxStatusShowKeyboard) {      // 显示键盘
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.chatBoxFaceView removeFromSuperview];
            [self.chatBoxMoreView removeFromSuperview];
        });
        return;
    } else if (toStatus == TLChatBoxStatusShowFace) {     // 显示表情面板
        if (fromStatus == TLChatBoxStatusShowVoice || fromStatus == TLChatBoxStatusNothing) {
            [self.chatBoxFaceView setOriginY:self.input.curHeight];
            [self.view addSubview:self.chatBoxFaceView];
            [UIView animateWithDuration:0.3 animations:^{
                if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
                    [_delegate chatBoxViewController:self didChangeChatBoxHeight:self.input.curHeight + HEIGHT_CHATBOXVIEW];
                }
            }];
        } else {
            // 表情高度变化
            self.chatBoxFaceView.originY = self.input.curHeight + HEIGHT_CHATBOXVIEW;
            [self.view addSubview:self.chatBoxFaceView];
            [UIView animateWithDuration:0.3 animations:^{
                self.chatBoxFaceView.originY = self.input.curHeight;
            } completion:^(BOOL finished) {
                [self.chatBoxMoreView removeFromSuperview];
            }];
            // 整个界面高度变化
            if (fromStatus != TLChatBoxStatusShowMore) {
                [UIView animateWithDuration:0.2 animations:^{
                    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
                        [_delegate chatBoxViewController:self didChangeChatBoxHeight:self.input.curHeight + HEIGHT_CHATBOXVIEW];
                    }
                }];
            }
        }
    } else if (toStatus == TLChatBoxStatusShowMore) {     // 显示更多面板
        if (fromStatus == TLChatBoxStatusShowVoice || fromStatus == TLChatBoxStatusNothing) {
            [self.chatBoxMoreView setOriginY:self.input.curHeight];
            [self.view addSubview:self.chatBoxMoreView];
            [UIView animateWithDuration:0.3 animations:^{
                if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
                    [_delegate chatBoxViewController:self didChangeChatBoxHeight:self.input.curHeight + HEIGHT_CHATBOXVIEW];
                }
            }];
        } else {
            self.chatBoxMoreView.originY = self.input.curHeight + HEIGHT_CHATBOXVIEW;
            [self.view addSubview:self.chatBoxMoreView];
            [UIView animateWithDuration:0.3 animations:^{
                self.chatBoxMoreView.originY = self.input.curHeight;
            } completion:^(BOOL finished) {
                [self.chatBoxFaceView removeFromSuperview];
            }];
            
            if (fromStatus != TLChatBoxStatusShowFace) {
                [UIView animateWithDuration:0.2 animations:^{
                    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
                        [_delegate chatBoxViewController:self didChangeChatBoxHeight:self.input.curHeight + HEIGHT_CHATBOXVIEW];
                    }
                }];
            }
        }
    } else if (toStatus == TLChatBoxStatusNothing){
        [UIView animateWithDuration:0.3 animations:^{
            if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
                [_delegate chatBoxViewController:self didChangeChatBoxHeight:self.input.curHeight];
            }
        }];
    }
}

- (FaceView *)chatBoxFaceView {
    if (_chatBoxFaceView == nil) {
        _chatBoxFaceView = [[FaceView alloc] initWithFrame:CGRectMake(0, HEIGHT_INPUT, SCREEN_WIDTH, HEIGHT_CHATBOXVIEW)];
        
    }
    return _chatBoxFaceView;
}

- (MoreView *)chatBoxMoreView {
    if (_chatBoxMoreView == nil) {
        _chatBoxMoreView = [[MoreView alloc] initWithFrame:CGRectMake(0, HEIGHT_INPUT, SCREEN_WIDTH, HEIGHT_CHATBOXVIEW)];
    }
    return _chatBoxMoreView;
}

@end
