//
//  FaceView.m
//  XLProject
//
//  Created by zsgy on 17/6/9.
//  Copyright © 2017年 zsgy. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView

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
        self.backgroundColor=[UIColor redColor];
    }
    return self;
}

@end
