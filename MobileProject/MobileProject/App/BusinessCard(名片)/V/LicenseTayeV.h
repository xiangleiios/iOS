//
//  LicenseTayeV.h
//  MobileProject
//
//  Created by 向蕾 on 2018/8/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SenterBlcokText) (NSString *text);
@interface LicenseTayeV : UIView
@property (nonatomic , strong)UIButton *selectebut;
@property (nonatomic , copy)SenterBlcokText textBlock;
@property (nonatomic , strong)NSDictionary *dic;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
