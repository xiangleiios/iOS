//
//  DataBut.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class DataBut;
@protocol DataButDelegate <NSObject>

- (void)DataButTouchUpInset:(DataBut *)but;

@end
@interface DataBut : UIView
@property (nonatomic , strong)UIButton *but;
@property (nonatomic , strong)UILabel *num;
@property (nonatomic , strong)UILabel *data;
@property (nonatomic , strong)UILabel *week;
@property (nonatomic , strong)UIColor *textColor;
@property (nonatomic , strong)UIColor *BKColor;
@property (nonatomic , weak)id deleget;
- (void)Click:(UIButton *)senter;
- (void)change:(UIButton *)senter;
@end

NS_ASSUME_NONNULL_END
