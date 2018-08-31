//
//  XLButton.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/21.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SenterBlcok) ();
@interface XLButton : UIView
@property (nonatomic , copy)SenterBlcok senterBlock;
//@property (nonatomic , strong)UIImageView *butimg;
/// 背景图 和 子父标题按钮
- (instancetype)initWithTitle:(NSString *)title SubTitle:(NSString *)subtitle BackgroundImg:(NSString *)img highlightedImg:(NSString *)hightImg;
@end
