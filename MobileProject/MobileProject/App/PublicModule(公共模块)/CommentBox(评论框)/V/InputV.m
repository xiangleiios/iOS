//
//  InputV.m
//  XLProject
//
//  Created by zsgy on 17/6/8.
//  Copyright © 2017年 zsgy. All rights reserved.
//

#import "InputV.h"
#import "XLInputvc.h"
#import "UIView+TL.h"
#import "NSString+FMObjMethods.h"
@interface InputV () <UITextViewDelegate>
@property (nonatomic , strong)UIImageView *img;

@end

@implementation InputV

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kNavBarColor;
        _curHeight = frame.size.height;
        self.status = TLChatBoxStatusNothing;//键盘初始状态
        [self Addcontrols];
    }
    return self;
}

#pragma mark-添加控件
- (void)Addcontrols{
     /* 顶部和底部要划线 */
    UILabel *lbo=[[UILabel alloc]init];
    lbo.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:lbo];
    [lbo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(kFit_Font6(0.7));
    }];
    UILabel *lbt=[[UILabel alloc]init];
    lbt.backgroundColor=[UIColor lightGrayColor];
    [self addSubview:lbt];
    [lbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(kFit_Font6(0.7));
    }];
    
    
//    self.moreButton=[[UIButton alloc]init];
//    [self addSubview:self.moreButton];
//    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self).mas_offset(KFit_W6S(20));
//        make.bottom.mas_equalTo(self).mas_offset(-kFit_Font6(10));
//        make.width.height.mas_equalTo(kFit_Font6(30));
//    }];
//    [self.moreButton setImage:[UIImage imageNamed:@"gongyongh-tianjia"] forState:UIControlStateNormal];
//    [self.moreButton addTarget:self action:@selector(moreButtondown:) forControlEvents:UIControlEventTouchUpInside];
    
//    self.faceButton=[[UIButton alloc]init];
//    [self addSubview:self.faceButton];
//    [self.faceButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.moreButton.mas_right).mas_offset(KFit_W6S(5));
//        make.bottom.mas_equalTo(self).mas_offset(-kFit_Font6(10));
//        make.width.height.mas_equalTo(kFit_Font6(30));
//    }];
//    [self.faceButton setImage:[UIImage imageNamed:@"gongyong-weixiao"] forState:UIControlStateNormal];
//    [self.faceButton addTarget:self action:@selector(faceButtondown:) forControlEvents:UIControlEventTouchUpInside];
    
    self.sendButton=[[UIButton alloc]init];
    [self addSubview:self.sendButton];
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(20));
        make.bottom.mas_equalTo(self).mas_offset(-kFit_Font6(10));
        make.height.mas_equalTo(kFit_Font6(30));
        make.width.mas_equalTo(KFit_W6S(90));
    }];
    self.sendButton.layer.cornerRadius=5;
    [self.sendButton setTitle:@"发送" forState:UIControlStateNormal];
    self.sendButton.backgroundColor=kRGBColor(251, 189, 44);
    [self.sendButton addTarget:self action:@selector(sendButtondown:) forControlEvents:UIControlEventTouchUpInside];
    
    self.textView=[[UITextView alloc]init];
    [self addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(40));
        make.right.mas_equalTo(self.sendButton.mas_left).mas_offset(-KFit_W6S(50));
        make.top.mas_equalTo(self).mas_offset(kFit_Font6(8));
        make.bottom.mas_equalTo(self).mas_offset(-kFit_Font6(8));
    }];
    [_textView setFont:[UIFont systemFontOfSize:kFit_Font6(16)]];
    [_textView.layer setMasksToBounds:YES];
    [_textView.layer setCornerRadius:17.0f];
    [_textView.layer setBorderWidth:0.5f];
    [_textView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [_textView setScrollsToTop:NO];
    [_textView setReturnKeyType:UIReturnKeySend];
    [_textView setDelegate:self];
    
    
    self.img=[[UIImageView alloc]init];
    [_textView addSubview:self.img];
    [self.img setImage:[UIImage imageNamed:@"input_zi"]];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.textView).mas_offset(KFit_W6S(20));
        make.height.mas_equalTo(KFit_W6S(30));
        make.width.mas_equalTo(KFit_W6S(180));
    }];
    
    
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self.img setHidden:YES];
    TLChatBoxStatus lastStatus = self.status;
    self.status = TLChatBoxStatusShowKeyboard;
    //执行代理方法，从一种状态跳到另一种状态
    if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeStatusForm:to:)]) {
        [_delegate chatBox:self changeStatusForm:lastStatus to:self.status];
    }
}


- (void)textViewDidEndEditing:(UITextView *)textView {
    
    if (!textView.text.length) [self.img setHidden:NO];
    
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    CGFloat height = [textView sizeThatFits:CGSizeMake(self.textView.frameWidth, MAXFLOAT)].height;
    height = height > HEIGHT_TEXTVIEW ? height : HEIGHT_TEXTVIEW;
    height = height < MAX_TEXTVIEW_HEIGHT ? height : textView.frame.size.height;
    _curHeight = height + HEIGHT_INPUT - HEIGHT_TEXTVIEW;;
    if (_curHeight != self.frame.size.height) {
        [UIView animateWithDuration:0.05 animations:^{
            [self setFrameHeight:_curHeight];
            if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeChatBoxHeight:)]) {
                [_delegate chatBox:self changeChatBoxHeight:_curHeight];
            }
        }];
    }
    if (height != textView.frameHeight) {
        [UIView animateWithDuration:0.05 animations:^{
            [textView setFrameHeight:height];
        }];
    }
    
}

//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"\n"]){
//        [self sendCurrentMessage];
//        return NO;
//    }
//    else if (textView.text.length > 0 && [text isEqualToString:@""]) {       // delete
//        if ([textView.text characterAtIndex:range.location] == ']') {
//            NSUInteger location = range.location;
//            NSUInteger length = range.length;
//            while (location != 0) {
//                location --;
//                length ++ ;
//                char c = [textView.text characterAtIndex:location];
//                if (c == '[') {
//                    textView.text = [textView.text stringByReplacingCharactersInRange:NSMakeRange(location, length) withString:@""];
//                    return NO;
//                }
//                else if (c == ']') {
//                    return YES;
//                }
//            }
//        }
//    }
//    
//    return YES;
//}



#pragma mark-按钮方法
- (void)moreButtondown:(UIButton *)sender{
    TLChatBoxStatus lastStatus = self.status;
    self.status = TLChatBoxStatusShowMore;
    [self stateOfTheKeyboardToSwitch:lastStatus];

}

- (void)faceButtondown:(UIButton *)sender{
    TLChatBoxStatus lastStatus = self.status;
    self.status = TLChatBoxStatusShowFace;
    [self stateOfTheKeyboardToSwitch:lastStatus];
}

- (void)sendButtondown:(UIButton *)sender{
    TLChatBoxStatus lastStatus = self.status;
    self.status = TLChatBoxStatusNothing;
    [self stateOfTheKeyboardToSwitch:lastStatus];
    if (![[User UserOb] UserLogin]) {
        [FMHelper fm_showLoginAlertWithController:self.vc.pushvc tipsStringIfNilShowDefault:nil];
        return;
        
    }
    [self SendComments];
}

- (void)stateOfTheKeyboardToSwitch:(TLChatBoxStatus)lastStatus{
    /* 如果是输入键盘辞去第一响应 */
    if (lastStatus == TLChatBoxStatusShowKeyboard) {
        [self.textView resignFirstResponder];
    }
    if (_delegate && [_delegate respondsToSelector:@selector(chatBox:changeStatusForm:to:)]) {
        [_delegate chatBox:self changeStatusForm:lastStatus to:self.status];
    }
}

#pragma mark-发送评论
- (void)SendComments{
    NSString *content=self.textView.text;
    if (content.length<1) {
        [MBProgressHUD showAutoMessage:@"评论不能为空"];
        return;
    }
    content = [[NSString fm_disableEmoji:content] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}

@end
