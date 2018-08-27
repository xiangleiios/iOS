//
//  MapVC.m
//  MobileProject
//
//  Created by zsgy on 2017/11/7.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "MapVC.h"
#import "BaiduMapHeader.h"
#import "RouteAnnotation.h"
#import <MapKit/MapKit.h>

@interface MapVC ()<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKRouteSearchDelegate>
{
    BMKLocationService *_locService;
    CLLocationCoordinate2D _coord;
}
@property (nonatomic ,strong)BMKMapView* mapView;
@property (nonatomic ,strong)BMKRouteSearch *routeSearch;
@end

@implementation MapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        KKLog(@"没有开启地图权限");
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您没有开启定位权限,请到设置->隐私->定位服务中开启!" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"地图";
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
    self.mapView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_mapView];;
    _mapView.showsUserLocation = YES;//显示定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态为普通定位模式
    self.mapView.zoomLevel =18;
    
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
    
    [self loadSubView];
}

- (void)loadSubView{
    UIView *back=[[UIView alloc] init];
    [self.view addSubview:back];
    back.backgroundColor=[UIColor whiteColor];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(240));
    }];
    
    UILabel *title=[[UILabel alloc] init];
    [back addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(back).mas_offset(KFit_W6S(25));
        make.right.mas_equalTo(back).mas_offset(-KFit_W6S(25));
        make.height.mas_equalTo(KFit_H6S(35));
    }];
    title.textColor=kRGBColor(51, 51, 51);
    title.text=self.model.title;
    title.font=[UIFont systemFontOfSize:kFit_Font6(17)];
    
    UILabel *address=[[UILabel alloc] initWithFrame:CGRectMake(KFit_W6S(25), KFit_H6S(65), SCREEN_WIDTH-KFit_W6S(50), KFit_H6S(70))];
    [back addSubview:address];
    address.numberOfLines=0;
    address.text=self.model.address;
    address.textColor=kRGBColor(102, 102, 102);
    address.font=[UIFont systemFontOfSize:kFit_Font6(14)];
    [address sizeToFit];
    
    
    UIButton *butone=[[UIButton alloc] init];
    [back addSubview:butone];
//    [butone setTitle:@"查看线路" forState:UIControlStateNormal];
//    [butone setTitleColor:kRGBColor(244, 171, 64) forState:UIControlStateNormal];
    [butone setImage:[UIImage imageNamed:@"icon_lookthisway"] forState:UIControlStateNormal];
    [butone addTarget:self action:@selector(RouteSearch) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *buttwo=[[UIButton alloc] init];
    [back addSubview:buttwo];
    [buttwo setImage:[UIImage imageNamed:@"icon_thismachineisamap"] forState:UIControlStateNormal];
    [buttwo addTarget:self action:@selector(openTheMapOfThisMachine) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *arr=@[butone,buttwo];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(302) leadSpacing:KFit_W6S(60) tailSpacing:KFit_W6S(60)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(back).mas_offset(-KFit_W6S(35));
        make.height.mas_equalTo(KFit_H6S(61));
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation {
    NSLog(@"heading is %@",userLocation.heading);
    _coord=userLocation.location.coordinate;
    
    [_locService stopUserLocationService];//关闭定位
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    //展示定位
    self.mapView.showsUserLocation = YES;
    //更新位置数据
    [self.mapView updateLocationData:userLocation];
    //获取用户的坐标
    self.mapView.centerCoordinate = userLocation.location.coordinate;
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

- (void)RouteSearch {
#pragma mark- 路线检索
    //初始化检索对象
    _routeSearch = [[BMKRouteSearch alloc] init];
    //设置delegate，用于接收检索结果
    _routeSearch.delegate = self;
    //构造步行查询基础信息类
    BMKPlanNode* start = [[BMKPlanNode alloc] init];
    start.pt = _coord;
    
    BMKPlanNode* end = [[BMKPlanNode alloc] init];
    NSArray *array = [self.model.coordinate componentsSeparatedByString:@","];
    if(array.count<2){
        return;
    }
    CLLocationCoordinate2D coor;
    coor.latitude = [array[1] floatValue];
    coor.longitude = [array[0] floatValue];
    end.pt=coor;
    
    BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc] init];
    walkingRouteSearchOption.from = start;
    walkingRouteSearchOption.to = end;
    
    BOOL flag = [self.routeSearch walkingSearch:walkingRouteSearchOption];
    if (flag) {
        NSLog(@"walk检索发送成功");
        [MBProgressHUD showMessage:@"规划路线中..." ToView:self.view];
    } else{
        NSLog(@"walk检索发送失败");
        [MBProgressHUD showError:@"规划路线失败,请重试！..." ToView:self.view];
    }
    
    
}

/**
 *返回步行搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKWalkingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
-(void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error {
    NSLog(@"onGetWalkingRouteResult error:%d", (int)error);
    
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    
    if (error == BMK_SEARCH_NO_ERROR) {
         KKLog(@"检索成功  ====%@",result);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [_mapView addAnnotation:item]; // 添加起点标注
                
            }
            if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [_mapView addAnnotation:item]; // 添加起点标注
            }
            //添加annotation节点
            RouteAnnotation* item = [[RouteAnnotation alloc]init];
            item.coordinate = transitStep.entrace.location;
            item.title = transitStep.entraceInstruction;
            item.degree = transitStep.direction * 30;
            item.type = 4;
            [_mapView addAnnotation:item];
            
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        BMKPolyline* polyLine = [BMKPolyline polylineWithPoints:temppoints count:planPointCounts];
        [_mapView addOverlay:polyLine]; // 添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
        
      
    } else {
        //检索失败
        [MBProgressHUD showError:@"检索失败" ToView:self.view];
    }
}
#pragma  mark - 添加覆盖物
#pragma mark - BMKMapViewDelegate

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [(RouteAnnotation*)annotation getRouteAnnotationView:view];
    }
    return nil;
}
#pragma mark 根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    if ([overlay isKindOfClass:[BMKPolyline class]]){
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = [UIColor redColor];
        polylineView.lineWidth = 2.0;
        
        return polylineView;
    }
    return nil;
}
//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(BMKPolyline *) polyLine {
    CGFloat leftTopX, leftTopY, rightBottomX, rightBottomY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    // 左上角顶点
    leftTopX = pt.x;
    leftTopY = pt.y;
    // 右下角顶点
    rightBottomX = pt.x;
    rightBottomY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        leftTopX = pt.x < leftTopX ? pt.x : leftTopX;
        leftTopY = pt.y < leftTopY ? pt.y : leftTopY;
        rightBottomX = pt.x > rightBottomX ? pt.x : rightBottomX;
        rightBottomY = pt.y > rightBottomY ? pt.y : rightBottomY;
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(leftTopX, leftTopY);
    rect.size = BMKMapSizeMake(rightBottomX - leftTopX, rightBottomY - leftTopY);
    UIEdgeInsets padding = UIEdgeInsetsMake(30, 0, 100, 0);
    BMKMapRect fitRect = [_mapView mapRectThatFits:rect edgePadding:padding];
    [_mapView setVisibleMapRect:fitRect];
}

#pragma mark-调起本机地图
- (void)openTheMapOfThisMachine{
    NSArray *array = [self.model.coordinate componentsSeparatedByString:@","];
    if(array.count<2){
        return;
    }
    CLLocationCoordinate2D coor;
    coor.latitude = [array[1] floatValue];
    coor.longitude = [array[0] floatValue];
    //起点
    MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc]                         initWithCoordinate:CLLocationCoordinate2DMake(_coord.latitude,_coord.longitude) addressDictionary:nil]];
    currentLocation.name =@"我的位置";
    //目的地的位置
    CLLocationCoordinate2D coords =CLLocationCoordinate2DMake(coor.latitude,coor.longitude);
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords addressDictionary:nil]];
    toLocation.name =self.model.address;
    NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
    
    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber                                 numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
    //打开苹果自身地图应用，并呈现特定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
