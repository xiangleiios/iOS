//
//  FMPlaceholdTextView.m
//  MobileProject
//
//  Created by Mingo on 2017/9/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMPlaceholdTextView.h"

@interface FMPlaceholdTextView()
/** 占位文字label */
@property (nonatomic, weak) UILabel *placeholderLabel;
@end

@implementation FMPlaceholdTextView



- (UILabel *)placeholderLabel
{
    if (!_placeholderLabel) {
        // 添加一个用来显示占位文字的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.x = 10;
        placeholderLabel.y = 10;
        [self addSubview:placeholderLabel];
        _placeholderLabel = placeholderLabel;
    }
    return _placeholderLabel;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 垂直方向上永远有弹簧效果
        self.alwaysBounceVertical = YES;
        
        // 默认字体
        self.font = [UIFont systemFontOfSize:15];
        
        // 默认的占位文字颜色
        self.placeholderColor = [UIColor grayColor];
        
        // 监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 * 监听文字改变
 */
- (void)textDidChange
{
    // 只要有文字, 就隐藏占位文字label
    self.placeholderLabel.hidden = self.hasText;
}

/**
 * 更新占位文字的尺寸
 */
- (void)updatePlaceholderLabelSize
{
    CGSize maxSize = CGSizeMake(kScreenW - 2 * self.placeholderLabel.x, MAXFLOAT);
    self.placeholderLabel.size = [self.placeholderText boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.font} context:nil].size;
}

#pragma mark - 重写setter
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
}

-(void)setPlaceholderText:(NSString *)placeholderText {

    _placeholderText = [placeholderText copy];
    
    self.placeholderLabel.text = placeholderText;
    
    [self updatePlaceholderLabelSize];
}


- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self updatePlaceholderLabelSize];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textDidChange];
}

- (void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    
    [self textDidChange];
}

@end
