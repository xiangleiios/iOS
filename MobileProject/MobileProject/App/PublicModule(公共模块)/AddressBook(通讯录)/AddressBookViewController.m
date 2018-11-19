//
//  AddressBookViewController.m
//  AoMountain
//
//  Created by 贺乾龙 on 2017/5/8.
//  Copyright © 2017年 QL. All rights reserved.
//

#import "AddressBookViewController.h"
#import "PPGetAddressBook.h"
//#import "PersonDetailViewController.h"
#import "ChineseToPinyin.h"
#import "AddressBookCell.h"
#import "CGXPickerView.h"
#import "ResultsVC.h"
//#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface AddressBookViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{

    NSArray *_titleArr;

}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSDictionary *contactPeopleDict;
@property (nonatomic, copy) NSArray *keys;

/** 所有人的信息*/
@property (nonatomic, strong) NSMutableArray *allPeopleArr;

/** 搜索*/
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UIView  *headView;

/** 搜索结果的数组*/
@property (nonatomic, strong) NSMutableArray *searchArr;

/** 判断是搜索状态还是编辑状态*/
@property (nonatomic, assign) BOOL isSearch;

/** 记录搜索的关键字*/
@property (nonatomic, strong) NSString  *searchKeyText;

@property (nonatomic , strong)NSMutableArray *dataArr;

@property (nonatomic , strong)UIButton *navbut;

@property (nonatomic , assign)NSInteger schoolId;
@property (nonatomic , assign)NSInteger originalDeptId;
@end

@implementation AddressBookViewController
- (NSMutableArray *)dataArr{
    if (_dataArr == nil) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self laodNavigation];
    [self createTableView];
    [self loadBut];
    self.allPeopleArr = [NSMutableArray array];
}
- (void)laodNavigation{
    [self.navigationView setTitle:@"通讯录"];
    self.navbut = [self.navigationView addRightButtonWithTitle:@" 0/5" clickCallBack:^(UIView *view) {
        
    }];
    
}

-(UIView *)CreateHeadView{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(KFit_W6S(15), 0, SCREEN_WIDTH, 54)];
        _headView.backgroundColor = [UIColor whiteColor];
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"搜索联系人";
        _searchBar.delegate = self;
        _searchBar.frame = CGRectMake(KFit_W6S(15),7,SCREEN_WIDTH - KFit_W6S(30),40);
//        _searchBar.backgroundColor = [UIColor lightGrayColor];
        UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
        searchField.backgroundColor = kColor_N(240, 240, 240);
        _searchBar.barTintColor = kColor_N(37, 190, 124);
        UIButton *cancleBtn = [_searchBar valueForKey:@"cancelButton"];
        [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancleBtn setTitleColor:kColor_N(37, 190, 124) forState:UIControlStateNormal];
        
        
        _searchBar.backgroundImage = [UIImage new];
        _searchBar.layer.cornerRadius = 3;
        _searchBar.layer.masksToBounds = YES;
        _searchBar.showsCancelButton = YES;
        [_searchBar.layer setBorderColor:kColor_N(240, 240, 240).CGColor];
        [_headView addSubview:self.searchBar];
        
    }
    return _headView;
}
- (void)loadBut{
    UIImageView *img = [[UIImageView alloc] init];
    [self.view addSubview:img];
    [img setImage:[UIImage imageNamed:@"white_bg_"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(KFit_H6S(164));
    }];
    
    UIButton *next = [[UIButton alloc] init];
    [self.view addSubview:next];
    [next setTitle:@"确定" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
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


-(void)createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarH, SCREEN_WIDTH, SCREEN_HEIGHT-kNavBarH - KFit_H6S(150)) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    _tableView.tableHeaderView = [self CreateHeadView];
    [self.view addSubview:_tableView];
    //获取按联系人姓名首字拼音A~Z排序(已经对姓名的第二个字做了处理)
    [PPGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *nameKeys) {
        
        
        //装着所有联系人的字典
        self.contactPeopleDict = addressBookDict;
        //联系人分组按拼音分组的Key值
        self.keys = nameKeys;
        [self.tableView reloadData];
        
        
        self.isSearch = NO;

        for (int i= 0; i<nameKeys.count; i++) {
            NSArray *arr = [addressBookDict objectForKey:nameKeys[i]];
            for (int j = 0; j< arr.count; j++) {
                PPPersonModel *model = [arr objectAtIndex:j];
                [self.allPeopleArr addObject:model];
            }
        }
        
        
        
    } authorizationFailure:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请在iPhone的“设置-隐私-通讯录”选项中，允许中天驾考访问您的通讯录"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil];
        [alert show];
    }];
    


}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isSearch) {
        return 1;
    }else{
        return _keys.count;

    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.isSearch) {
        
        
            return self.searchArr.count;
        
        
    }else{
       
        NSString *key = _keys[section];
        return [_contactPeopleDict[key] count];
        
    }
    
}
//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    return _keys[section];
//}

//右侧的索引
- (NSArray*)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
        static NSString *reuseIdentifier = @"AddressBookCell";
        AddressBookCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
        if (!cell)
        {
            cell = [[AddressBookCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        }
    
    PPPersonModel *model;
        if (self.isSearch) {
            
            model = self.searchArr[indexPath.row];
            cell.model = model;
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;

        }else{
            NSString *key = _keys[indexPath.section];
            model = [_contactPeopleDict[key] objectAtIndex:indexPath.row];
            cell.model = model;
            cell.selectionStyle = UITableViewCellSeparatorStyleNone;

        }
    if ([self.dataArr containsObject:model]) {
        cell.but.selected = YES;
    }else{
        cell.but.selected = NO;
    }
        return cell;

}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return KFit_H6S(130);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PPPersonModel *people;
        if (self.isSearch) {
            people = self.searchArr[indexPath.row];
            NSLog(@"%@=======%@",people.name,people.mobileArray);
            
            
        }else{
            NSString *key = _keys[indexPath.section];
            people = [_contactPeopleDict[key] objectAtIndex:indexPath.row];
            NSLog(@"%@=======%@",people.name,people.mobileArray);

        }
    AddressBookCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if (!cell.but.selected) {
        if (self.dataArr.count > 4) {
            [MBProgressHUD showMsgHUD:@"一次最多添加5个人"];
            return;
        }
        [self addCoachData:people];
    }else{
        [self reductionCoachData:people];
    }
    cell.but.selected = !cell.but.selected;


}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0010;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 20;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
        UILabel *indexLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 120, 20)];
        if (self.isSearch) {
            indexLabel.text = @"搜索结果";

        }else{
            indexLabel.text = _keys[section];

        }
        indexLabel.font = [UIFont systemFontOfSize:15];
        indexLabel.textColor = [UIColor darkGrayColor];
        [view addSubview:indexLabel];
        return view;

    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
//    [searchBar setShowsCancelButton:YES animated:NO];
    /**
     *  将系统自带的cancel修改为“取消”
     */
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            [cancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        }
    }
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    //将要结束编辑模式
//    [searchBar setShowsCancelButton:NO animated:NO];
    return YES;//yes 可以结束
}
//点击cancel 按钮
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";//清空内容
    [searchBar resignFirstResponder];//取消第一响应
    self.isSearch = NO;

    //[self.navigationController popViewControllerAnimated:YES];
}
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    return YES;
}
#pragma mark - 点击键盘搜索按钮事件
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length > 0) {
        self.isSearch = YES;

    }else{
        
        self.isSearch = NO;
        [searchBar resignFirstResponder];
 
    }
    
    
    [self.searchArr removeAllObjects];
    
    for (int i = 0; i<self.allPeopleArr.count; i++) {
        PPPersonModel *model = self.allPeopleArr[i];
        NSString *lowStr = [ChineseToPinyin pinyinFromChineseString:searchText withSpace:NO ];
        NSString *allStr =[ChineseToPinyin pinyinFromChineseString:model.name withSpace:NO ];
        //**********手机号模糊搜索*************//
        if (model.mobileArray.count == 1) {
            
            if ([model.mobileArray[0] rangeOfString:searchText].location != NSNotFound) {
                
                [self.searchArr addObject:model];

            }
            
        }else{
            
            for (int i= 0; i<model.mobileArray.count; i++) {
                if ([model.mobileArray[i] rangeOfString:searchText].location != NSNotFound) {
                    [self.searchArr addObject:model];

                }
  
            }
        
        
        }
        
        //**********姓模糊搜索*************//
        self.searchKeyText = [NSString stringWithFormat:@"%c",[ChineseToPinyin sortSectionTitle:searchText]];
        BOOL isHas = [allStr isEqualToString:lowStr];
        BOOL isPY = false;
        if ( lowStr || lowStr.length != 0) {
            
            isPY = [allStr hasPrefix:lowStr];
 
        }
        if (isHas) {
            //这种情况是精确查找。
            [self.searchArr addObject:model];//讲搜索后的数据添加到数组中
            
        }else{

            if (isPY && !isHas) {
                //迷糊查找
                [self.searchArr addObject:model];

            }
            
        }
        
    }
    [self.tableView reloadData];

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    [self.searchBar resignFirstResponder];
}

-(NSMutableArray *)searchArr{
    if (!_searchArr) {
        _searchArr = [NSMutableArray array];
    }
    return _searchArr;
}

#pragma mark - 数据处理
//添加数据
- (void)addCoachData:(PPPersonModel *)model{
    if (![self.dataArr containsObject:model]) {
        [self.dataArr addObject:model];
    }
    [self.navbut setTitle:[NSString stringWithFormat:@"%lu/5",(unsigned long)self.dataArr.count] forState:UIControlStateNormal];
}
//删除数据
- (void)reductionCoachData:(PPPersonModel *)model{
    if ([self.dataArr containsObject:model]) {
        [self.dataArr removeObject:model];
    }
    [self.navbut setTitle:[NSString stringWithFormat:@"%lu/5",(unsigned long)self.dataArr.count] forState:UIControlStateNormal];
}

- (void)queding{
    if (self.dataArr.count < 1) {
        [MBProgressHUD showMsgHUD:@"请选择联系人"];
        return;
    }
    kWeakSelf(self)
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    NSArray *arrname = (NSArray *)[defaults objectForKey:SchoolList];
    [CGXPickerView showStringPickerWithTitle:@"选择驾校" DataSource:[XLCache singleton].teamCode_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@",selectValue);
        int i = [selectRow intValue];
//        weakself.school.subfield.text = selectValue;
        weakself.originalDeptId = [[XLCache singleton].teamCode_value[[selectRow intValue]] intValue];
//        weakself.fenXiao.subfield.text = arrname[i][@"teamName"];
        self.schoolId = [arrname[i][@"teamSchoolDeptId"] intValue];
        XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"是否添加到\n%@(%@)",selectValue,arrname[i][@"teamName"]] sureBtn:@"确定" cancleBtn:@"取消"];
        [alert showXLAlertView];
        alert.resultIndex = ^(NSInteger index) {
            if (index == 2) {
                [weakself toSave];
            }
        };
    }];
}


- (void)toSave{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSMutableArray *arr = [NSMutableArray array];
    for (PPPersonModel *model in self.dataArr) {
        NSDictionary *dic= @{@"coachName":model.name,@"phoneNumber":[model.mobileArray firstObject]};
        [arr addObject:dic];
    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr
                                                       options:kNilOptions
                                                         error:nil];
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                 encoding:NSUTF8StringEncoding];
    [dic setValue:[arr mj_JSONString] forKey:@"data"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.schoolId] forKey:@"schoolId"];
    [dic setValue:[NSString stringWithFormat:@"%ld",(long)self.originalDeptId] forKey:@"originalDeptId"];
    NSString *url = [NSString stringWithFormat:POSTTeamSchoolCoachCoachAddll,jsonString,(long)self.schoolId,self.originalDeptId];
//    [url stringByRemovingPercentEncoding]
    //POSTTeamSchoolCoachCoachAddll
//    NSString* url1 = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* url1 = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [FMNetworkHelper fm_request_postWithUrlString:url1 isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        [MBProgressHUD hideHUD];
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            
            ResultsVC *vc = [[ResultsVC alloc] init];
            vc.message = responseObject[@"message"];
            vc.seccessCount = [responseObject[@"seccessCount"] integerValue];
            vc.errorCount = [responseObject[@"errorCount"] integerValue];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        [MBProgressHUD hideHUD];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

@end
