//
//  StudentsLabelV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "StudentsLabelV.h"
#import "XLInformationV.h"
@implementation StudentsLabelV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self laodsubview];
    }
    return self;
}
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSMutableArray *)selectDataArr{
    if (_selectDataArr == nil) {
        _selectDataArr = [NSMutableArray array];
    }
    return _selectDataArr;
}
- (NSMutableArray *)selectDataArrNew{
    if (_selectDataArrNew == nil) {
        _selectDataArrNew = [NSMutableArray array];
    }
    return _selectDataArrNew;
}
- (void)laodsubview{
    XLInformationV *lb = [[XLInformationV alloc] informationStudentsWithTitle:@"学员状态"];
    [self addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(KFit_H6S(85));
    }];
    
    

}


- (void)relodData{
    [self.backview removeFromSuperview];
    self.backview = [[XLView alloc] init];
    [self addSubview:self.backview];
    float w = (SCREEN_WIDTH - KFit_W6S(100))/3;
    float h = KFit_H6S(40);
    int j = 0;
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < self.dataArr.count; i++) {
        TageModel *model = self.dataArr[i];
        [arr addObject:model.tagTitle];
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(KFit_W6S(30) + (i % 3)*(w + KFit_W6S(20)),KFit_W6S(30) + (i / 3)*(h + KFit_H6S(20)), w, h)];
        [self.backview addSubview:but];
        but.layer.borderWidth = 0.3;
        but.layer.borderColor = kColor_N(0, 110, 230).CGColor;
        but.layer.cornerRadius = 3;
        but.layer.masksToBounds = YES;
        but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(11)];
        
        [but setTitle:model.tagTitle forState:UIControlStateNormal];
        but.tag = i;
        [but setTitleColor:kColor_N(0, 110, 230) forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [but setBackgroundImage:[UIImage imageWithColor:kColor_N(0, 110, 230)] forState:UIControlStateSelected];
        [but addTarget:self action:@selector(butSelect:) forControlEvents:UIControlEventTouchUpInside];
        if ([self.selectDataArr containsObject:model.tagTitle]) {
            but.selected = YES;
            [self.selectDataArrNew addObject:model.tagTitle];
        }
        if (i >= 3) {
            UIButton *delectbut = [[UIButton alloc] initWithFrame:CGRectMake(w - KFit_W6S(10) + (i % 3)*(w + KFit_W6S(20)),(i / 3)*(h + KFit_H6S(20)) - KFit_H6S(10), KFit_W6S(80), KFit_W6S(80))];
            [self.backview addSubview:delectbut];
            delectbut.tag = i;
            [delectbut setImage:[UIImage imageNamed:@"delete_red_icon copy"] forState:UIControlStateNormal];
            [delectbut addTarget:self action:@selector(deleteBut:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        j++;
    }
    
    self.addBut = [[UIButton alloc] init];
    self.addBut.layer.borderWidth = 0.3;
    self.addBut.layer.borderColor = kColor_N(0, 110, 230).CGColor;
    self.addBut.layer.cornerRadius = 3;
    self.addBut.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(11)];
    [self.addBut setTitle:@"添加" forState:UIControlStateNormal];
    [self.addBut addTarget:self action:@selector(addLable) forControlEvents:UIControlEventTouchUpInside];
    [self.addBut setTitleColor:kColor_N(0, 110, 230) forState:UIControlStateNormal];
    [self.backview addSubview:self.addBut];
    self.addBut.frame = CGRectMake(KFit_W6S(30) + (j % 3)*(w + KFit_W6S(20)),KFit_W6S(30) + (j / 3)*(h + KFit_H6S(20)), w, h);
    [self.backview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(KFit_H6S(87));
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo([self.backview getLayoutCellHeightWithFlex:KFit_W6S(30)]);
    }];
    self.frame = CGRectMake(0, KFit_H6S(160), SCREEN_WIDTH, [self getLayoutCellHeight]);
    
}

- (void)butSelect:(UIButton *)senter{
    senter.selected = !senter.selected;
    TageModel *model = self.dataArr[senter.tag];
    if (senter.selected) {
        [self.selectDataArr addObject:model.tagTitle];
        [self.selectDataArrNew addObject:model.tagTitle];
    }else{
        [self.selectDataArr removeObject:model.tagTitle];
        [self.selectDataArrNew removeObject:model.tagTitle];
    }
}
- (void)deleteBut:(UIButton *)senter{
    TageModel *model = self.dataArr[senter.tag];
    [self removeTageWith:model];
}
- (void)addLable{
    XLAlertView *alert = [[XLAlertView alloc] initWithInputboxTitle:@"添加学员状态"];
    [alert showXLAlertView];
    alert.input.placeholder = @"每个标签限5个字";
    alert.inputText = ^(NSString *text) {
        if (text.length >5) {
            [MBProgressHUD showMsgHUD:@"每个标签限5个字"];
            return ;
        }
        [self addtageWith:text];
    };
}


- (void)addtageWith:(NSString *)tage{
//    NSString *url =[NSString stringWithFormat:POSTTagAdd,tage];
    NSString *url =POSTTagAdd;
    NSDictionary *dic = @{@"tagTitle":tage,@"type":@"2"};
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            TageModel *model = [TageModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.dataArr addObject:model];
            [self.selectDataArr addObject:model.tagTitle];
            [self relodData];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}


- (void)removeTageWith:(TageModel * )model{
    NSString *url =[NSString stringWithFormat:POSTTagRemove,model.tagId];
    NSDictionary *dic = @{@"ids":[NSString stringWithFormat:@"%ld",(long)model.tagId]};
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [self.dataArr removeObject:model];
            [self.selectDataArr removeObject:model.tagTitle];
            [self relodData];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
@end
