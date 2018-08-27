//
//  MoreView.m
//  XLProject
//
//  Created by zsgy on 17/6/9.
//  Copyright © 2017年 zsgy. All rights reserved.
//

#import "MoreView.h"

@implementation MoreView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor yellowColor];
    }
    return self;
}
@end
