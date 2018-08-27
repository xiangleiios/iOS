//
//  AddStudentVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/8/20.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddStudentVC.h"
#import "XLInformationV.h"
#import "AddInformationOneVC.h"
@interface AddStudentVC ()

@end

@implementation AddStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self laodNavigation];
    [self laodSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setTitle:@"添加学员"];
    //添加一个带图片的按钮，如果这个按钮只有点击事件，可以这样写，更加简洁。
//    [self.navigationView addRightButtonWithImage:kImage(@"gift") hightImage:kImage(@"wo-guayuwomen") clickCallBack:^(UIView *view) {
//
//    }];
}

- (void)laodSubview{
    
    UIView *backview = [[UIView alloc] init];
    [self.view addSubview:backview];
    [backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.height.mas_equalTo(KFit_H6S(420));
    }];
    
    XLInformationV *manual = [[XLInformationV alloc] informationWithTitle:@"手动添加学员" SubTitle:@"手动录入学员报名信息" ImageName:@"add_student_icon"];
    [backview addSubview:manual];
    manual.senterBlock = ^{
        KKLog(@"dianji");
        AddInformationOneVC *vc = [[AddInformationOneVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    XLInformationV *automatic = [[XLInformationV alloc] informationWithTitle:@"面对面扫码" SubTitle:@"学员扫描二维码自行填写报名信息" ImageName:@"facetoface_icon"];
    [backview addSubview:automatic];
    automatic.senterBlock = ^{
        KKLog(@"dianji111");
    };
    NSArray *arr = @[manual,automatic];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:1 leadSpacing:1 tailSpacing:1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
    }];
    
    
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
