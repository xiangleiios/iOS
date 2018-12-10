//
//  ScreeningV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/11.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScreeningV;
NS_ASSUME_NONNULL_BEGIN
@protocol ScreeningVDelegate <NSObject>

- (void)ScreeningVDelegat:(ScreeningV *)screnningv Index:(NSInteger)index;

@end

@interface ScreeningV : UIView
@property (nonatomic , strong)NSArray *dataArr;
@property (nonatomic , strong)UIView *backview;
@property (nonatomic , strong)UIButton *selectBut;
@property (nonatomic , weak)id <ScreeningVDelegate> delegate;
@property (nonatomic , strong)UIScrollView *scroll;
- (void)show;
- (void)shutDown;
@end

NS_ASSUME_NONNULL_END
