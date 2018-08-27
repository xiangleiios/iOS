//
//  SheetView.m
//  AllTest
//
//  Created by 菜鸟 on 15/5/22.
//  Copyright (c) 2015年 菜鸟. All rights reserved.
//

#import "SheetView.h"
//#define kRatio 120/320.0
#define kRatio 120/320.0
#define Scr_W [[UIScreen mainScreen] bounds].size.width
#define Scr_H [[UIScreen mainScreen] bounds].size.height
#define kSpace 8
#define Btn_W 30
#define Btn_H 30
#define titleLabel_H 30
#define Height Scr_W*kRatio

@implementation SheetView
{
    CGRect _curFrame;
    BOOL _isDrop;
}
+(SheetView *)showSheet
{
    CGRect frame = CGRectMake(0, Scr_H-Height-52, Scr_W, Height);
    SheetView * sheetView = [[SheetView alloc]initWithFrame:frame];
    sheetView.backgroundColor = [UIColor blackColor];
    sheetView.backColor = [UIColor colorWithWhite:0 alpha:0.7];
    return sheetView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpace, 2*kSpace, Scr_W-70-kSpace, titleLabel_H)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textColor = [UIColor whiteColor];
        [self addSubview:_titleLabel];

        _pageLabel = [[UILabel alloc]initWithFrame:CGRectMake(Scr_W-70-kSpace, 2*kSpace, 70, titleLabel_H)];
        _pageLabel.textAlignment = NSTextAlignmentRight;
        _pageLabel.textColor = [UIColor whiteColor];
        [self addSubview:_pageLabel];
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 2*kSpace+titleLabel_H, Scr_W, Height-2*kSpace-titleLabel_H)];
        _scrollView.contentSize = CGSizeMake(Scr_W, _scrollView.frame.size.height);
        [self addSubview:_scrollView];
        
        _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSpace, 0, _scrollView.frame.size.width-kSpace, _scrollView.frame.size.height)];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
        _contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [_scrollView addSubview:_contentLabel];
        
//        _dropBtn = [[UIButton alloc]initWithFrame:CGRectMake((Scr_W-Btn_W)/2.0, 0, Btn_W, Btn_H)];
//        [_dropBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
//        _dropBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 5, 5);
//        _dropBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
//        [_dropBtn addTarget:self action:@selector(dropBtn_click) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_dropBtn];
        
        [self addObserver:self forKeyPath:@"self.contentLabel.text" options:NSKeyValueObservingOptionNew context:nil];
        [self addObserver:self forKeyPath:@"self.pageLabel.text" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"self.contentLabel.text"]) {
        
        [self calculateContentHeightWithContent:self.contentLabel.text];
    }
    
    if ([keyPath isEqualToString:@"self.pageLabel.text"]) {
        
        [self capCurPageNum];
    }
}

-(void)calculateContentHeightWithContent:(NSString *)content
{
    
    CGSize size = [content sizeWithFont:_contentLabel.font constrainedToSize:CGSizeMake(_contentLabel.frame.size.width, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    
    _contentLabel.frame = CGRectMake(kSpace, 0, Scr_W-kSpace, size.height);
    _scrollView.contentSize = CGSizeMake(Scr_W, size.height);
}

-(void)capCurPageNum
{
    NSRange range = [_pageLabel.text rangeOfString:@"/"];
    NSMutableAttributedString*attribute = [[NSMutableAttributedString alloc] initWithString:_pageLabel.text];
    [attribute addAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:23]}range:NSMakeRange(0, range.location)];
    [_pageLabel setAttributedText: attribute];
}

#pragma mark - 显示或隐藏sheetView
-(void)dropBtn_click
{
//    if (_isDrop) {
//        [UIView animateWithDuration:0.5 animations:^{
//            self.frame = CGRectMake(0, Scr_H-Height-64, Scr_W, Height);
//            _dropBtn.imageView.transform = CGAffineTransformMakeRotation(0);
//        }];
//        _isDrop = NO;
//    }
//    else
//    {
//        [UIView animateWithDuration:0.5 animations:^{
//            self.frame = CGRectMake(0, Scr_H-2*kSpace-Btn_H-64, self.frame.size.width, self.frame.size.height);
//            _dropBtn.imageView.transform = CGAffineTransformMakeRotation(-M_PI);
//        }];
//        _isDrop = YES;
//    }
}

#pragma mark - 画背景

//-(void)setBackColor:(UIColor *)backColor
//{
//    _backColor = backColor;
//    [self setNeedsDisplay];
//}

-(void)drawRect:(CGRect)rect
{
//    //画背景
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetRGBStrokeColor(context, 0, 0, 0, 0);//线条颜色
//    CGContextMoveToPoint(context, 0, kSpace);
//    CGContextAddLineToPoint(context, (Scr_W-Btn_W)/2.0-kSpace, kSpace);
//    CGContextAddLineToPoint(context, (Scr_W-Btn_W)/2.0, 0);
//    CGContextAddLineToPoint(context, (Scr_W+Btn_W)/2.0, 0);
//    CGContextAddLineToPoint(context, (Scr_W+Btn_W)/2.0+kSpace, kSpace);
//    CGContextAddLineToPoint(context, Scr_W, kSpace);
//    CGContextAddLineToPoint(context, Scr_W, Height);
//    CGContextAddLineToPoint(context, 0, Height);
//    
//    CGContextSetFillColorWithColor(context, _backColor.CGColor);
//    CGContextDrawPath(context, kCGPathFillStroke);
}

-(void)dealloc
{
    [self removeObserver:self forKeyPath:@"self.contentLabel.text"];
    [self removeObserver:self forKeyPath:@"self.pageLabel.text"];
}
@end
