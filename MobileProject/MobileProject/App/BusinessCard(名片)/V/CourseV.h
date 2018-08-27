//
//  CourseV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLInformationV.h"
@interface CourseV : UIView
@property (nonatomic , strong)XLInformationV *name;
@property (nonatomic , strong)XLInformationV *price;
@property (nonatomic , strong)NSDictionary *dic;
@property (nonatomic , strong)UITextView *textView;
- (instancetype)initWithDictionary:(NSDictionary *)dic;
- (void)show;
@end
