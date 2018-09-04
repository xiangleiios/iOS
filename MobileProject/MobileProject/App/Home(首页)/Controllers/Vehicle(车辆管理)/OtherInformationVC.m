//
//  OtherInformationVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/9/4.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "OtherInformationVC.h"

@interface OtherInformationVC ()
@property (nonatomic , strong)NSMutableArray *imgArr;
@end

@implementation OtherInformationVC
- (NSMutableArray *)imgArr{
    if (_imgArr ==nil) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kColor_N(240, 240, 240);
    [self loadSubview];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadSubview{
    XLView *v = [[XLView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    UILabel *lb = [[UILabel alloc] init];
    [v addSubview:lb];
    lb.text = @"图片";
    lb.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(v).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(v);
        make.height.mas_equalTo(KFit_H6S(90));
        make.right.mas_equalTo(v).mas_offset(-KFit_W6S(30));
    }];
    if (_model.invoicePic) {
        [self.imgArr addObject:_model.invoicePic];
    }
    if (_model.purchaseTaxPic) {
        [self.imgArr addObject:_model.purchaseTaxPic];
    }
    if (_model.otherPic) {
        [self.imgArr addObject:_model.otherPic];
    }
    if (_model.carPic) {
        [self.imgArr addObject:_model.carPic];
    }
    for (int i = 0; i<self.imgArr.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(KFit_W6S(30)+i * KFit_W6S(180), KFit_H6S(120), KFit_W6S(150), KFit_W6S(150))];
        [v addSubview:img];
        [img sd_setImageWithURL:[NSURL URLWithString:self.imgArr[i]] placeholderImage:[UIImage imageNamed:@"lb-jiazaitu"]];
    }
    
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.view);
        make.height.mas_equalTo([v getLayoutCellHeightWithFlex:KFit_H6S(30)]);
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
