//
//  CodeShareV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/28.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagingButtonView.h"
@interface CodeShareV : UIView
@property (nonatomic , strong)XLshare *share;
@property (nonatomic, strong) PagingButtonView *pagingScr;
@property (nonatomic , assign)ShareType type;
- (void)show;
@end
