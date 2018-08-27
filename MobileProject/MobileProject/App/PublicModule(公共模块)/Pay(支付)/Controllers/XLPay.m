//
//  XLPay.m
//  MobileProject
//
//  Created by zsgy on 2018/6/12.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "XLPay.h"
#import "FMPayCell.h"
@interface XLPay ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray *data;
/// 确认支付
@property (nonatomic, strong) UIButton *yfSurePay;
@property (nonatomic, strong) UIButton *yfSeletcAlipay;
@property (nonatomic, strong) UIButton *yfSeletcWechatPay;
@end

@implementation XLPay
- (NSMutableArray *)data{
    if (!_data) {
        _data =[[NSMutableArray alloc] init];
        FMMainModel *model = [[FMMainModel alloc] init];
        model.name = @"支付宝支付";
        model.image_url = @"alipay"; //wechatpay  pay_pitchon  pay_unselected
        
        FMMainModel *model2 = [[FMMainModel alloc] init];
        model2.name = @"微信支付";
        model2.image_url = @"wechatpay"; //wechatpay  pay_pitchon  pay_unselected
        [_data addObject:model];
        [_data addObject:model2];
    }
    return _data;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTable];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadTable{
    self.table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.table.tableHeaderView = [self tableHeadView];
//    self.table.tableFooterView = [self tableFootview];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
    }];
}
#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"FMPayCell";
    
    FMPayCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[FMPayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.model = self.data[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
