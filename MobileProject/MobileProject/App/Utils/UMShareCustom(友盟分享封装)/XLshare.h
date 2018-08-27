//
//  XLshare.h
//  MobileProject
//
//  Created by zsgy on 17/3/2.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLshare : NSObject
@property (nonatomic , strong)NSString *title;
@property (nonatomic , strong)NSString *image_url;
@property (nonatomic , strong)NSString *url;
@property (nonatomic , strong)NSString *subTitle;

- (void)umengShare:(UIView*)view;

@end
