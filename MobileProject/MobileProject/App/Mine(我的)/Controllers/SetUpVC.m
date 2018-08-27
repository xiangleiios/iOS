//
//  SetUpVC.m
//  MobileProject
//
//  Created by zsgy on 17/8/2.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "SetUpVC.h"
#import "FMClearCacheTool.h"

@interface SetUpVC ()
{
    SDWebImageManager *web;
}
@property (nonatomic , strong)UIButton *push;
@property (nonatomic , strong)UIButton *cleanUp;
@property (nonatomic , strong)UIButton *version;
@property (nonatomic , strong)UISwitch *swit;
@property (nonatomic , strong)UILabel *Cache;
@end

@implementation SetUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"设置";
    self.view.backgroundColor=kRGBColor(239, 239, 246);
    [self loadsubview];
    if ([[User UserOb] UserLogin]) {
        [self loadfunctionbut];
    }
}

- (void)loadsubview{
    UIView *v=[[UIView alloc]init];
    v.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(25));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(25));
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(310));
    }];
    
    self.push=[[UIButton alloc]init];
    [self.push setTitle:@"推送" forState:UIControlStateNormal];
    [self.push setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.push.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    self.push.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    self.cleanUp=[[UIButton alloc]init];
    [self.cleanUp setTitle:@"清理缓存" forState:UIControlStateNormal];
    [self.cleanUp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cleanUp.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    self.cleanUp.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.cleanUp addTarget:self action:@selector(cleanUpcache) forControlEvents:UIControlEventTouchUpInside];
    
    self.version=[[UIButton alloc]init];
    [self.version setTitle:@"版本号" forState:UIControlStateNormal];
    [self.version setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.version.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    self.version.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [v addSubview:self.push];
    [v addSubview:self.cleanUp];
    [v addSubview:self.version];
    NSArray *arr=[NSArray arrayWithObjects:self.push,self.cleanUp,self.version, nil];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:1.0 leadSpacing:0 tailSpacing:0];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.bottom.mas_equalTo(v);
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(v).mas_offset(-KFit_W6S(30));
    }];
    
    UILabel *lb=[[UILabel alloc]init];
    [v addSubview:lb];
    lb.backgroundColor=kRGBColor(239, 239, 246);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.push);
        make.top.mas_equalTo(self.push.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lbt=[[UILabel alloc]init];
    [v addSubview:lbt];
    lbt.backgroundColor=kRGBColor(239, 239, 246);
    [lbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.push);
        make.top.mas_equalTo(self.cleanUp.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    /*推送开关 */
    [self pushsetup];
    /* 缓存大小*/
    [self loadCache];
    [self loadversion];
}
- (void)pushsetup{
    self.swit=[[UISwitch alloc]init];
    [self.push addSubview:self.swit];
    self.swit.tintColor=kRGBColor(251, 189, 44);
    self.swit.onTintColor=kRGBColor(251, 189, 44);
    [self.swit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.push).mas_offset(-KFit_W6S(20));
        make.top.mas_equalTo(self.push).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(80));
    }];
    [self.swit addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    if ([FMRegExpTool notification]) {
        self.swit.on=YES;
    }else{
        self.swit.on=NO;
    }

}
- (void)loadCache{
    self.Cache=[[UILabel alloc]init];
    [self.cleanUp addSubview:self.Cache];
    self.Cache.textColor=[UIColor lightGrayColor];
    self.Cache.textAlignment=NSTextAlignmentRight;
    self.Cache.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [self.Cache mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.cleanUp).mas_offset(-KFit_W6S(20));
        make.top.mas_equalTo(self.cleanUp).mas_offset(KFit_H6S(20));
        make.bottom.mas_equalTo(self.cleanUp).mas_offset(-KFit_H6S(20));
        make.width.mas_equalTo(KFit_W6S(160));
    }];
    NSString *cacheSize = [FMClearCacheTool fm_getCacheSizeWithFilePath:kCachePath];
    self.Cache.text=[NSString stringWithFormat:@"%@",cacheSize];
}

- (void)loadversion{
    UILabel *lb=[[UILabel alloc]init];
    [self.version addSubview:lb];
    lb.textColor=[UIColor lightGrayColor];
    lb.textAlignment=NSTextAlignmentRight;
    lb.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.version).mas_offset(-KFit_W6S(20));
        make.top.mas_equalTo(self.version).mas_offset(KFit_H6S(20));
        make.bottom.mas_equalTo(self.version).mas_offset(-KFit_H6S(20));
        make.width.mas_equalTo(KFit_W6S(160));
    }];
    NSString *str=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    lb.text=[NSString stringWithFormat:@"V%@",str];
}



- (void)loadfunctionbut{
    UIButton *but=[[UIButton alloc]init];
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.version.mas_bottom).mas_offset(KFit_H6S(110));
        make.width.mas_equalTo(KFit_W6S(530));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    but.layer.cornerRadius=KFit_H6S(40);
    but.backgroundColor=kRGBColor(251, 189, 44);
    [but setTitle:@"退出登录" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(logOut:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)logOut:(UIButton *)sender{
    [[User UserOb] UserQuit];
    sender.hidden=YES;
}
#pragma mark-清理缓存
- (void)cleanUpcache{
    /////////////
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {}]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
         [FMRegExpTool clearFile];
        if ([FMClearCacheTool fm_clearCacheWithFilePath:kCachePath]) {
            [MBProgressHUD showAutoMessage:@"已清除缓存"];
        }
        
        NSString *cacheSize = [FMClearCacheTool fm_getCacheSizeWithFilePath:kCachePath];
        self.Cache.text=[NSString stringWithFormat:@"%@",cacheSize];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)switchAction:(UISwitch *)swit{
    
    if (swit.on) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        NSLog(@"1111111111");
    }else{
        [[UIApplication sharedApplication] unregisterForRemoteNotifications];
        NSLog(@"2222222222");
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
