//
//  AddInformationVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/10.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddInformationVC.h"
#import "XLInformationV.h"
@interface AddInformationVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@end

@implementation AddInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"填写个人信息"];
    
    
    // Do any additional setup after loading the view.
}
- (void)laodScroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];
    
    self.backview = [[XLView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scroll addSubview:self.backview];
    

}

- (void)loadsub{
    XLInformationV *jiben = [[XLInformationV alloc] informationWithTitle:@"基本信息"];
    [self.backview addSubview:jiben];
    [jiben mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(90));
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
