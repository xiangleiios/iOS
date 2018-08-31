//
//  XLImageView.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/31.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLImageView.h"

@implementation XLImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - 点击高亮处理
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.highlighted = YES;
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.highlighted = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    self.highlighted = NO;
}

#pragma mark - 高亮后产生的效果

- (void)setHighlighted:(BOOL)highlighted {
    
    [super setHighlighted:highlighted];
    if (highlighted) {
        
        self.alpha = 0.6;
    }
    else {
        
        self.alpha = 1.f;
    }
}
@end
