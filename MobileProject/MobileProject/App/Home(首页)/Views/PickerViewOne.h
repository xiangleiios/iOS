//
//  PickerView.h
//  Hu8huWorker
//
//  Created by xiaopeng on 2017/4/24.
//  Copyright © 2017年 王小朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerViewOneDelegate <NSObject>

- (void)PickerViewOneDelegateOncleck:(NSInteger)index Text:(NSString *)text;

@end

@interface PickerViewOne : UIView

- (instancetype)initWithFrame:(CGRect)frame midArry:(NSMutableArray *)midArry;

@property (nonatomic, assign) id<PickerViewOneDelegate>delegate;

@end
