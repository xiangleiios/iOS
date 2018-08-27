//
//  XLBaiduMapTools.h
//  MobileProject
//
//  Created by zsgy on 2017/12/26.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaiduMapHeader.h"

@interface XLBaiduMapTools : NSObject
/**单例*/
+(XLBaiduMapTools  *)instance;

/**定位,能得到省市街道*/
- (void)startlocation:(BOOL)needaddress
      locationSuccess:(void(^)(double longitude,double latitude)) locationSuccess
       addressSuccess:(void(^)(double longitude,double latitude,BMKAddressComponent *address))addressSuccess;

/**停止定位*/
- (void)stoplocation;
@end
