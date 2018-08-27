//
//  XLInputvc.h
//  XLProject
//
//  Created by zsgy on 17/6/8.
//  Copyright © 2017年 zsgy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputV.h"
/*
 *键盘类型
 */
//typedef NS_ENUM(NSInteger, TLChatBoxStatus) {
//    TLChatBoxStatusNothing,      //空
//    TLChatBoxStatusShowVoice,    //语音输入
//    TLChatBoxStatusShowFace,    //表情
//    TLChatBoxStatusShowMore,
//    TLChatBoxStatusShowKeyboard,  //键盘
//};
@class XLInputvc;
@protocol XLInputvcDelegate <NSObject>
@optional
- (void)chatBoxViewController:(XLInputvc *)Inputvc didChangeChatBoxHeight:(CGFloat)height;
- (void)chatBoxViewController:(XLInputvc *)Inputvc isSendCommentContentComplete:(BOOL)isComplete;

@end

@interface XLInputvc : UIViewController
@property (nonatomic , strong)InputV *input;//输入视图
@property (nonatomic , strong)id<XLInputvcDelegate>delegate;
@property (nonatomic , strong)UIViewController *pushvc;
@property (nonatomic, strong) FMMainModel *model;
@property (nonatomic , strong)FMMainModel *followsModel;
@end
