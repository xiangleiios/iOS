//
//  PromptSuccessV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/10/29.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PromptSuccessV : UIView
@property (nonatomic , strong)UIView *backview;
@property (nonatomic , strong)UITextView *centent;
@property (nonatomic , strong)NSMutableArray *tiemArr;
@property (nonatomic , strong)NSMutableArray *studentPhoneArr;
@property (nonatomic , strong)NSString *groundAddress;
@property (nonatomic , strong)NSString *groundName;
@property (nonatomic , strong)NSString *teamSchoolName;
@property (nonatomic , strong)UIViewController *vc;
- (void)show;
@end

NS_ASSUME_NONNULL_END
