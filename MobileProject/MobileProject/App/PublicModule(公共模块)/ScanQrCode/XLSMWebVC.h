//
//  XLSMWebVC.h
//  FSZX
//
//  Created by zsgy on 16/11/8.
//  Copyright © 2016年 王文辉. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XLSMWebVC : UIViewController

/** 接收扫描的二维码信息 */
@property (nonatomic, copy) NSString *jump_URL;
/** 接收扫描的条形码信息 */
@property (nonatomic, copy) NSString *jump_bar_code;



@end
