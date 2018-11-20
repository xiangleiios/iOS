//
//  GDSearchMapVC.h
//  MobileProject
//
//  Created by 向蕾 on 2018/11/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <MAMapKit/MAMapView.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "PlaceAroundTableView.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol GDSearchMapVCDelegate <NSObject>

- (void)GDSearchMapVCDelegateWith:(AMapPOI *)amapPOI And:(AMapReGeocodeSearchResponse *)response;
- (void)GDSearchMapVCDelegateWithAddressComponent:(AMapReGeocodeSearchResponse *)response And:(AMapPOI *)amapPOI; 
@end
@interface GDSearchMapVC : UIViewController
@property (nonatomic , weak)id<GDSearchMapVCDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
