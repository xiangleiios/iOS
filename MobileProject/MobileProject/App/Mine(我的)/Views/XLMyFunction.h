//
//  XLMyFunction.h
//  MobileProject
//
//  Created by zsgy on 17/7/31.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XLMyFunction;
@protocol XLMyFunctionDelegate <NSObject>//协议
//协议方法
- (void)xlMyFunctionView:(XLMyFunction *)xLMyFunction clickOnTheIndex:(NSInteger)index;

@end
@interface XLMyFunction : UIView
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *subtitle;
@property (nonatomic , strong)UIImageView *img;
@property (nonatomic , assign)NSInteger num;
@property (nonatomic , strong)id<XLMyFunctionDelegate> delegate;
@property (nonatomic , strong)UIImageView *imgT;
@end
