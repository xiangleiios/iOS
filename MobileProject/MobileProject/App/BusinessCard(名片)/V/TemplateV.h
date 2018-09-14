//
//  TemplateV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/24.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLInformationV.h"
#import "ChangeCardVC.h"
@interface TemplateV : UIView
@property (nonatomic , strong)UITextView *textView;
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)XLInformationV * biaoTi;
@property (nonatomic , assign)int index;
@property (nonatomic , strong)ChangeCardVC *vc;
- (void)show;
@end
