//
//  InstructionsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/16.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddCoachInstructionsVC.h"

@interface AddCoachInstructionsVC ()

@end

@implementation AddCoachInstructionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"添加教练步骤"];
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    [img setImage:[UIImage imageNamed:@"method"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(788));
    }];
    // Do any additional setup after loading the view.
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
