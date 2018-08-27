//
//  XLMyNewsFunction.h
//  MobileProject
//
//  Created by zsgy on 2017/10/30.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol XLMyNewsFunctionDelegate <NSObject>//协议

- (void)XLMyNewsFunctionclickOnTheIndex:(NSInteger)index;//协议方法

@end
@interface XLMyNewsFunction : UIView
@property (nonatomic , strong)UILabel *title;
@property (nonatomic , strong)UILabel *subtitle;
@property (nonatomic , strong)UIImageView *img;
//@property (nonatomic , assign)NSInteger num;
@property (nonatomic , assign)MyNewsType type;
@property (nonatomic , strong)id<XLMyNewsFunctionDelegate> delegate;
@property (nonatomic , strong)UILabel *describe;
@end
