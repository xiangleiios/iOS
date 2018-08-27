//
//  FMCheckVersion.m
//  MobileProject
//
//  Created by Mingo on 2017/9/19.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMCheckVersion.h"
//#import "APPInfoModel.h"


@implementation APPInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"idid":@"id",
             @"description_field":@"description",
             };
}

@end


@implementation FMCheckVersion

#pragma mark - 获取APP信息后检测跟新
+ (void)fm_getAppsInfoAndCheckUpdata {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/xml",@"text/plain", @"application/json", nil];
    NSString *url = APIappInfo;
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        switch ([responseObject[@"status_code"] integerValue]) {
            case 200:{
                APPInfoModel *appModel = [APPInfoModel mj_objectWithKeyValues:responseObject[@"data"]];
                [self versionUpdata:appModel];
                
                break;
            }
            default:
                break;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

+ (void)versionUpdata:(APPInfoModel *)model{
    
    if (model.ios_url.length >1 ) {
        
        NSString *identityVersion =  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"]; //获取Identity Version
        NSInteger versionType = [model.ios_version compare:identityVersion options:NSCaseInsensitiveSearch];
        
        if (versionType == 1) { //大于1有新版本
            UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"检测到新版本如下" message:[NSString stringWithFormat:@"版本号：%@",model.ios_version] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelBtt;
            
            if (model.ios_force < 1) { //ios_force==1就是强制更新
                cancelBtt = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                }];
                [ac addAction:cancelBtt];
            }
            
            UIAlertAction *okBtt = [UIAlertAction actionWithTitle:@"升级" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:model.ios_url];
                //点击升级按钮就会Safari打开App Store的应用详情， 【同时APP会再次弹出提示更新框，如安装新版就不会弹框。做到强制升级时去App Store不安装返回任然有升级提示框的效果。】
                [[UIApplication sharedApplication] openURL:url];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
                //@"https://itunes.apple.com/us/app/yi-qi-yun-gou-ni-li-meng-xiang/id1147640197?l=zh&ls=1&mt=8"
            }];
            
            [ac addAction:okBtt];
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:ac animated:YES completion:nil];
        }
    }
}


@end
