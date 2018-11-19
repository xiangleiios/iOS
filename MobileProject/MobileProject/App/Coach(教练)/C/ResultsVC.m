//
//  ResultsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/19.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ResultsVC.h"
#import "CoachListVc.h"
@interface ResultsVC ()

@end

@implementation ResultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"提交结果"];
    [self loadSubview];
    [self loadBut];
    // Do any additional setup after loading the view.
}

- (void)loadSubview{
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH + KFit_H6S(110));
        make.width.height.mas_equalTo(KFit_W6S(200));
    }];
    
    UILabel *titlelb = [[UILabel alloc] init];
    [self.view addSubview:titlelb];
    [titlelb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(40));
        make.width.mas_equalTo(KFit_W6S(300));
    }];
    titlelb.textAlignment = NSTextAlignmentCenter;
    titlelb.font = [UIFont systemFontOfSize:20 weight:0.5];
    
    
    UILabel *tsone = [[UILabel alloc] init];
    [self.view addSubview:tsone];
    tsone.numberOfLines = 0;
    tsone.textColor = ZTColor;
    tsone.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [tsone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(50));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(50));
        make.top.mas_equalTo(titlelb.mas_bottom).mas_offset(KFit_H6S(25));
    }];
    if (self.seccessCount == 0) {
        [img setImage:[UIImage imageNamed:@"wrong"]];
        titlelb.text = @"提交失败";
        tsone.text = self.message;
    }else{
        [img setImage:[UIImage imageNamed:@"prompt_good"]];
        titlelb.text = @"提交成功";
        tsone.text = [NSString stringWithFormat:@"成功为分校添加%ld名教练，教练的登录账号为手机号，初始密码为手机号后6位",(long)self.seccessCount];
        if (self.errorCount != 0) {
            UILabel *line = [[UILabel alloc] init];
            [self.view addSubview:line];
            line.backgroundColor = kColor_N(240, 240, 240);
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(tsone);
                make.top.mas_equalTo(tsone.mas_bottom).mas_offset(KFit_H6S(60));
                make.height.mas_equalTo(1);
            }];
            
            UILabel *tstwo = [[UILabel alloc] init];
            [self.view addSubview:tstwo];
            tstwo.numberOfLines = 0;
            tstwo.textColor = ZTColor;
            tstwo.text = [NSString stringWithFormat:@"提交失败\n%@",self.message];
            [tstwo mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(tsone);
                make.top.mas_equalTo(line.mas_bottom).mas_offset(KFit_H6S(60));
            }];
        }
        
    }
    
    
}


- (void)loadBut{
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"完成" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [next setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [next setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [next setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    next.layer.cornerRadius = 5;
    next.layer.masksToBounds = YES;
    [next mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(70));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(70));
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(40));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
}

- (void)complete{
    UINavigationController *navVC =self.navigationController;
    
    NSMutableArray *viewControllers = [[NSMutableArray alloc]init];
    
    for (UIViewController *vc in [navVC viewControllers]) {
        
        [viewControllers addObject:vc];
        
        if ([vc isKindOfClass:[CoachListVc class]]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
            
        }
        
    }
    
    

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
