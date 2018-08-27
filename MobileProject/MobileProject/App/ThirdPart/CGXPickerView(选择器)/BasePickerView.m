//
//  BasePickerView.m
//  MobileProject
//
//  Created by zsgy on 2018/6/25.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "BasePickerView.h"

@implementation BasePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
{
    UIView *_selectBackView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    if(self.subviews.count){
        [self updateSelectView];
    }
}

-(void)updateSelectView
{
    //修改线条颜色
    UIView *line1 = self.subviews[1];
    line1.backgroundColor = [UIColor clearColor];
    UIView *line2 = self.subviews[2];
    line2.backgroundColor = [UIColor clearColor];
    
    //修改选中行的背景色
    for (UIView *subView in self.subviews) {
        if(subView.subviews.count){
            UIView *contentView = subView.subviews[0];
            for (UIView *contentSubView in contentView.subviews) {
                if(contentSubView.center.y == contentView.center.y){
                    if(_selectBackView != contentSubView){
                        _selectBackView.backgroundColor = [UIColor clearColor];
                        _selectBackView = contentSubView;
                        _selectBackView.backgroundColor = kColor_N(232, 252, 225);
                    }
                    break;
                }
            }
            break;
        }
    }
}
@end
