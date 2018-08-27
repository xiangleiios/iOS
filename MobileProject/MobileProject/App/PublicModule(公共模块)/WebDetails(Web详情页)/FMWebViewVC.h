//
//  FMWebViewVC.h
//  MobileProject
//
//  Created by Mingo on 2017/8/4.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMBaseViewController.h"
#import "FMMainModel.h"
typedef NS_ENUM(NSInteger, detailType) {
    detailTypePano = 1,  //全景
    detailTypeMall = 2      //商城
    
};
@interface FMWebViewVC : FMBaseViewController
@property(nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) FMMainModel *model;
@property(nonatomic, assign) detailType detailType;
@end
