//
//  GDMapVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/14.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "GDMapVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "ThirdPartKeys.h"
#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5
@interface GDMapVC ()<MAMapViewDelegate,CLLocationManagerDelegate,AMapLocationManagerDelegate,AMapSearchDelegate>
@property (nonatomic ,strong)MAPointAnnotation *pointAnnotation;
@property (nonatomic ,strong)MAMapView *mapView;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@property (nonatomic, strong)AMapLocationManager *locationManager;
@property (nonatomic, strong)AMapSearchAPI *search;
@end
@implementation GDMapVC
- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyKilometer];
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    //设置允许在后台定位
//    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    //开启带逆地理连续定位
    [self.locationManager setLocatingWithReGeocode:YES];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"地图"];
    [AMapServices sharedServices].apiKey = GDAppkey;
    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    ///把地图添加至view
    [self.view addSubview:_mapView];
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    _mapView.delegate = self;
    [_mapView setZoomLevel:14 animated:YES];
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    [self configLocationManager];
    [self initCompleteBlock];
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
    
}

/* 单次定位. */
- (void)initCompleteBlock
{
    kWeakSelf(self)
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            
            return;
        }
        
        //得到定位信息
        if (location)
        {
            KKLog(@"%f--------------%f",location.coordinate.longitude,location.coordinate.latitude);
            MAPointAnnotation *a = [[MAPointAnnotation alloc] init];
//            a.coordinate = location.coordinate;
            [a setLockedScreenPoint:CGPointMake((SCREEN_WIDTH/2.0), (SCREEN_HEIGHT/2.0))];
            [a setLockedToScreen:YES];
            [weakself.mapView addAnnotation:a];
            NSString *regeoString = [NSString stringWithFormat:@"国 家:%@\n省:%@\n市:%@\n城市编码:%@\n区:%@\n区 域:%@\n地 址:%@\n兴趣点:%@\n", regeocode.country, regeocode.province, regeocode.city, regeocode.citycode, regeocode.district, regeocode.adcode, regeocode.formattedAddress, regeocode.POIName];
            KKLog(@"%@",regeoString);
        }
    };
}


#pragma mark - MAMapviewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIdentifier = @"pointReuseIdentifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIdentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIdentifier];
            
            annotationView.canShowCallout            = YES;
            annotationView.animatesDrop              = YES;
            annotationView.draggable                 = YES;
        }
        annotationView.pinColor = MAPinAnnotationColorRed;
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    KKLog(@"%f ----%f",self.mapView.centerCoordinate.latitude,
          self.mapView.centerCoordinate.longitude);
    /// 逆地理编码
    [self searchReGeocodeWithCoordinate:self.mapView.centerCoordinate];
}




- (void)searchReGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate
{
    AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
    
    regeo.location                    = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    regeo.requireExtension            = YES;
    
    [self.search AMapReGoecodeSearch:regeo];
}

/* 逆地理编码回调. */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    
    KKLog(@"%@",response.regeocode.formattedAddress);
//    response.regeocode.addressComponent

}
@end
