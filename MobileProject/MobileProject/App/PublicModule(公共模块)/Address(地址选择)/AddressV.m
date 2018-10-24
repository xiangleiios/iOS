//
//  AddressV.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/23.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddressV.h"
#import "AddressCell.h"
@interface AddressV ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)NSDictionary *province;
@property (nonatomic , strong)NSDictionary *city;
@property (nonatomic , strong)NSDictionary *areadic;
@end
@implementation AddressV

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSMutableArray *)dataArr{
    if (_dataArr ==nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self laodSub];
    }
    return self;
}
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self laodSub];
//    }
//    return self;
//}
- (void)laodSub{
    self.num = 1;
    self.url = POSTProvinceList;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = kRGBAColor(5, 5, 5, 0.6);
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, KFit_H6S(700), SCREEN_WIDTH, KFit_H6S(90))];
    [self addSubview:lb];
    lb.backgroundColor = kColor_N(240, 240, 240);
    lb.text = @"请选择";
    lb.textAlignment = NSTextAlignmentCenter;
    
    UIButton *but = [[UIButton alloc] init];
    [self addSubview:but];
    [but setImage:[UIImage imageNamed:@"deletez"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(quit) forControlEvents:UIControlEventTouchUpInside];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lb);
        make.right.mas_equalTo(self).mas_offset(-KFit_W6S(30));
        make.width.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lb.mas_bottom);
        make.left.right.bottom.mas_equalTo(self);
//        make.bottom.mas_equalTo(self).mas_offset(KFit_H6S(150));
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    //设置可编辑
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.backgroundColor = kColor_N(240, 240, 240);
    _table.mj_footer.ignoredScrollViewContentInsetBottom = iPhoneX;
    
    [self laodData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"AddressCell"];
    AddressCell *cell = (AddressCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.dic = self.dataArr[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(90);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.dataArr[indexPath.row];
    switch (self.num) {
        case 1:
            self.province = dic;
//            self.dic = @{@"provincecode":dic[@"code"]};
            self.url = [NSString stringWithFormat:POSTCityList,dic[@"code"]];
            self.num++;
            [self laodData];
            break;
        case 2:
            self.city = dic;;
            self.dic = @{@"citycode":dic[@"code"]};
            self.url = [NSString stringWithFormat:POSTAreaList,dic[@"code"]];
            self.num++;
            [self laodData];
            break;
        case 3:
            self.vc.province = self.province;
            self.vc.city = self.city;
            self.vc.areadic = dic;
            [self quit];
            break;
            
        default:
            break;
    }
}
- (void)laodData{
    [self loadRefreshData];
}
- (void)loadRefreshData{
    [MBProgressHUD showLoadingHUD:@"正在加载"];
    [FMNetworkHelper fm_request_postWithUrlString:_url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        [MBProgressHUD hideLoadingHUD];
        KKLog(@"%@",responseObject);
        [self.dataArr removeAllObjects];
        NSArray *tpArray = responseObject[@"data"];
        [self.dataArr addObjectsFromArray:tpArray];
        [self.table reloadData];
        [self.table setContentOffset:CGPointMake(0,0) animated:NO];
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    //    POSTTeamSchoolList
}

-(void)quit{
    [self removeFromSuperview];
}
- (void)show{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
}
@end
