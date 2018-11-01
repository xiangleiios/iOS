//
//  CourseV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLInformationV.h"
#import "ChangeCardVC.h"
@interface CourseV : UIView <UITextViewDelegate>
@property (nonatomic , strong)NSString *idid;
@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)XLInformationV *price;
@property (nonatomic , strong)NSDictionary *dic;
@property (nonatomic , strong)UITextView *textView;
@property (nonatomic , strong)NSString *type; // 驾照类型
@property (nonatomic , strong)ChangeCardVC *vc;
@property (nonatomic , strong)UIView *backview;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (void)show;
@end
