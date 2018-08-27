//
//  XLxqbut.m
//  FSZX
//
//  Created by zsgy on 16/12/28.
//  Copyright © 2016年 ZSGY. All rights reserved.
//

#import "XLxqbut.h"

@implementation XLxqbut
- (instancetype)init
{
    if (self = [super init]) {
        //设置文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        //设置图片内容模式居中
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        
        //设置图片内容模式居中
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}


//sdsadadadadasdasdasd


//返回图片的位置
//系统绘制按钮时调用,需要返回给系统绘制按钮的图片位置与标题位置
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0,0,contentRect.size.width,contentRect.size.height * ImageHeightRadio);
}
//返回标题的位置
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0,contentRect.size.height * ImageHeightRadio, contentRect.size.width,contentRect.size.height * (1 - ImageHeightRadio));
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
