//
//  AddCoachListVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/13.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "AddCoachListVC.h"
#import "AddStudentCell.h"
#import "AddressBookViewController.h"
#import<AddressBook/AddressBook.h>
#import "PPGetAddressBook.h"
#import "AddCoachInstructionsVC.h"
#import "AddCoachVC.h"
#import "InvitationCoachVC.h"
@interface AddCoachListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;
@property (nonatomic , strong)NSArray *imgarr;
@property (nonatomic , strong)NSArray *titlerr;
@property (nonatomic , strong)NSArray *subtitlearr;
@end
@implementation AddCoachListVC
- (NSMutableArray *)dataArr{
    if (_dataArr ==nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self laodNavigation];
    self.titlerr = @[@"手机通讯录导入",@"手动添加教练",@"邀请教练"];
    self.imgarr = @[@"add_student_icon",@"increase",@"invite"];
    self.subtitlearr = @[@"批量导入分校内教练信息",@"手动录入分校内教练信息",@"分享链接，教练自行填写信息"];
    [self loadtable];
    [PPGetAddressBook requestAddressBookAuthorization];
    // Do any additional setup after loading the view.
}
- (void)laodNavigation{
    kWeakSelf(self)
    [self.navigationView setTitle:@"教练列表"];
    //添加一个带图片的按钮，如果这个按钮只有点击事件，可以这样写，更加简洁。
    [self.navigationView addRightButtonWithImage:kImage(@"more_gt") hightImage:kImage(@"more_gt") clickCallBack:^(UIView *view) {
        AddCoachInstructionsVC *vc = [[AddCoachInstructionsVC alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
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
        
        AddressBookViewController *vc = [[AddressBookViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        AddCoachVC *vc = [[AddCoachVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 2) {
        InvitationCoachVC *vc = [[InvitationCoachVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}




@end
