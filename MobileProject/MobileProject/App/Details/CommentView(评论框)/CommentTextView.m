//
//  CommentTextView.m
//  SmallDemo
//
//  Created by 菜鸟 on 15/7/9.
//  Copyright (c) 2015年 菜鸟. All rights reserved.
//

#import "CommentTextView.h"

#define TopSpace 8
#define LeftSpace 8
#define BtnW 80
/*-------------------mainTextView----------------------------*/


@implementation MainTextView
{
    UIImageView * _imgView;
    UIView * _sepLine;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:244/255.0 alpha:1];
        [self addImgView];
        [self addTextView];
        [self addSepLine];
        [self addBtn];
        [self layoutSubviews];
    }
    return self;
}

- (void)addImgView
{
    _imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"upload_03"]];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imgView];
}

- (void)addTextView
{
    _textView = [[UITextView alloc]init];
    _textView.layer.cornerRadius = 3;
    _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textView.layer.borderWidth = 1;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.textColor = [UIColor blackColor];
    _textView.font = [UIFont systemFontOfSize:17];
    [self addSubview:_textView];
}

- (void)addBtn
{
    _button = [[UIButton alloc]init];
    _button.layer.cornerRadius = 4;
    _button.layer.masksToBounds = YES;
    _button.backgroundColor = [UIColor colorWithRed:180/255.0 green:180/255.0 blue:180/255.0 alpha:1];
    [_button setTitle:@"发送" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_button];
}

- (void)addSepLine
{
    _sepLine = [[UIView alloc]init];
    [self addSubview:_sepLine];
    _sepLine.backgroundColor = [UIColor lightGrayColor];
}

- (void)setImgName:(NSString *)imgName
{
    _imgView.image = [UIImage imageNamed:imgName];
}

- (void)layoutSubviews
{
    CGFloat x = LeftSpace;
    CGFloat y = TopSpace;
    CGFloat w = 21;
    CGFloat h = 21;
    
    _imgView.frame = CGRectMake(x, y, w, h);
    
    x = self.frame.size.width-LeftSpace-BtnW;
    y = 2;
    w = BtnW-10;
    h = 27;
    
    _button.frame = CGRectMake(x, y, w, h);
    
    x = 0;
    y = CGRectGetMaxY(_imgView.frame)+TopSpace/2.0;
    w = self.frame.size.width;
    h = 1;
    _sepLine.frame = CGRectMake(x, y, w, h);
    
    x = LeftSpace;
    y = CGRectGetMaxY(_sepLine.frame)+TopSpace/2;
    w = self.frame.size.width-2*LeftSpace;
    h = CGRectGetHeight(self.frame)-y-TopSpace;
    _textView.frame = CGRectMake(x, y, w, h);
}

@end
/*-------------------分割线:以上是MaintextView----------------------------*/


@implementation CommentTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _mainTextView = [[MainTextView alloc]initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, 150)];
        [_mainTextView.button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mainTextView];
    }
    return self;
}

- (void)click
{
    _text = _mainTextView.textView.text;
    _mainTextView.textView.text=@"";
    [self.delegate commentTextViewDidFinishWithText:_text];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [_mainTextView removeFromSuperview];
        [self removeFromSuperview];
    }];
    
}

- (void)setText:(NSString *)text
{
    _mainTextView.textView.text = text;
}

- (void)dealloc
{
    self.delegate = nil;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self click];
}


@end
