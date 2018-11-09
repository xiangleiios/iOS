//
//  ReplyV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/6.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReplyV : XLView
@property (nonatomic , strong)NSString *idid;
@property (nonatomic , strong)UITextView *textview;
@property (nonatomic , strong)UIView *backview;
@property (nonatomic , strong)FMBaseViewController *vc;
- (void)show;
@end

NS_ASSUME_NONNULL_END
