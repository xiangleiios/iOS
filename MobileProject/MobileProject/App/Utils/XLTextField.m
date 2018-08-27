//
//  XLTextField.m
//  MobileProject
//
//  Created by zsgy on 17/8/2.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "XLTextField.h"

@implementation XLTextField
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kFit_Font6(10), kFit_Font6(10))];
        self.leftView = view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
