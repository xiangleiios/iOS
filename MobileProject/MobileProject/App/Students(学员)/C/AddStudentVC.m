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
#import "QrCodeVC.h"
#import "AddStudentCell.h"
#import "BusinessCardListVC.h"
#import "AddInformationVC.h"
@interface AddStudentVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSArray *imgarr;
@property (nonatomic , strong)NSArray *titlerr;
@property (nonatomic , strong)NSArray *subtitlearr;
@end

@implementation AddStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titlerr = @[@"手动添加学员",@"面对面扫码"];
    self.imgarr = @[@"add_student_icon",@"facetoface_icon"];
    self.subtitlearr = @[@"手动录入学员报名信息",@"学员扫描二维码自行填写报名信息"];
    [self laodNavigation];
//    [self laodSubview];
    [self loadtable];
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
        BusinessCardListVC *vc = [[BusinessCardListVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//        QrCodeVC *vc = [[QrCodeVC alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    };
    NSArray *arr = @[manual,automatic];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:1 leadSpacing:1 tailSpacing:1];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
    }];
    
    
}

- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    self.table.scrollEnabled = NO;
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.table.mj_header beginRefreshing];
}



#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlerr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"AddStudentCell"];
    AddStudentCell *cell = (AddStudentCell *)[tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[AddStudentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.titleLable.text = self.titlerr[indexPath.row];
    cell.SubLable.text = self.subtitlearr[indexPath.row];
    [cell.img setImage:[UIImage imageNamed:self.imgarr[indexPath.row]]];
    

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KFit_H6S(210);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        AddInformationVC *vc = [[AddInformationVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        QrCodeVC *vc = [[QrCodeVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
//      BusinessCardListVC *vc = [[BusinessCardListVC alloc] init];
//      [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        
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
