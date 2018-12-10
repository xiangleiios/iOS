//
//  ExamStudentsDetailsVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/18.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "ExamStudentsDetailsVC.h"
#import "StudentsLabelV.h"
#import "XLInformationV.h"
#import "CGXPickerView.h"
#import "StudentDetailsVC.h"
#define MAX_LIMIT_NUMS   100
@interface ExamStudentsDetailsVC ()<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)UIButton *state;
@property (nonatomic , strong)StudentsLabelV *studentlb;
@property (nonatomic , strong)UILabel *num;
@property (nonatomic , strong)UITextView *note;
@property (nonatomic , strong)UITextField *bukao;
@property (nonatomic , strong)NSMutableArray *dataArr;
@property (nonatomic , strong)NSMutableArray *selectDataArr;
@end

@implementation ExamStudentsDetailsVC
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
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"学员详情"];
    [self laodTages];
    [self laodScroll];
    
    [self loadSubview];
    [self loadBut];
    // Do any additional setup after loading the view.
}
- (void)laodScroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
        make.bottom.mas_equalTo(self.view).mas_offset(-KFit_H6S(150));
    }];

    self.backview = [[XLView alloc] init];
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
//    self.backview.backgroundColor = kColor_N(240, 240, 240);
    [self.scroll addSubview:self.backview];
}

- (void)viewDidLayoutSubviews{
    KKLog(@"视图刷新");
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:20]);
    self.scroll.contentSize = CGSizeMake(0, [self.backview getLayoutCellHeightWithFlex:20]);
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
    [next setTitle:@"保存" forState:UIControlStateNormal];
    [next addTarget:self action:@selector(teamStuStateEdit) forControlEvents:UIControlEventTouchUpInside];
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
- (void)loadSubview{
    UIImageView *img = [[UIImageView alloc] init];
    [self.backview addSubview:img];
    [img setImage:[UIImage imageNamed:@"head_nor"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
        make.width.height.mas_equalTo(KFit_W6S(80));
    }];
    
    UILabel *name = [[UILabel alloc] init];
    [self.backview addSubview:name];
    name.text = _model.student[@"studentName"];
    name.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img);
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [but setImage:[UIImage imageNamed:@"phone_bule"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(dianhua) forControlEvents:UIControlEventTouchUpInside];
    [self.backview addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(name);
        make.left.mas_equalTo(name.mas_right);
        make.width.height.mas_equalTo(KFit_W6S(70));
    }];
    
    UILabel *jiaxiao = [[UILabel alloc] init];
    [self.backview addSubview:jiaxiao];
    jiaxiao.text = [NSString stringWithFormat:@"报考驾校:%@",_model.schoolName];
    jiaxiao.textColor = kColor_N(109, 118, 141);
    jiaxiao.font = [UIFont systemFontOfSize:kFit_Font6(13)];
    [jiaxiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(img);
        make.left.mas_equalTo(img.mas_right).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.state = [[UIButton alloc] init];
    [self.backview addSubview:self.state];
//    [self.state setTitle:@"科一 ▾" forState:UIControlStateNormal];
    [self.state setTitle:[self ButTitleWith:_model.progress] forState:UIControlStateNormal];
    self.state.tag = _model.progress;
    [self.state setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.state addTarget:self action:@selector(chooseKM) forControlEvents:UIControlEventTouchUpInside];
    self.state.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(name);
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(110), KFit_H6S(40)));
    }];
    
    UILabel *lineone = [[UILabel alloc] init];
    [self.backview addSubview:lineone];
    lineone.backgroundColor = kColor_N(240, 240, 240);
    [lineone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(25));
    }];
    
    self.studentlb = [[StudentsLabelV alloc] init];
    [self.backview addSubview:self.studentlb];
    self.studentlb.frame = CGRectMake(0, KFit_H6S(160), SCREEN_WIDTH, [self.studentlb getLayoutCellHeight]);
    if (_model.stuTags.length > 0) {
        NSArray  *array = [_model.stuTags componentsSeparatedByString:@","];
        [self.studentlb.selectDataArr addObjectsFromArray:array];
    }
    
//    [self.studentlb.dataArr addObjectsFromArray:@[@"123",@"12313",@"3453453",@"1231231"]];
    [self.studentlb relodData];
    
//    [self.studentlb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(self.backview);
//        make.top.mas_equalTo(lineone.mas_bottom);
//        make.height.mas_equalTo([self.studentlb getLayoutCellHeight]);
//    }];
    
    UILabel *linetwo = [[UILabel alloc] init];
    [self.backview addSubview:linetwo];
    linetwo.backgroundColor = kColor_N(240, 240, 240);
    [linetwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.studentlb.mas_bottom);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(25));
    }];
    
    XLInformationV *lbone = [[XLInformationV alloc] informationStudentsWithTitle:@"备注"];
    [self.backview addSubview:lbone];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(linetwo.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(85));
    }];
    
    self.num = [[UILabel alloc] init];
    [self.backview addSubview:self.num];
    self.num.textColor = kColor_N(109, 118, 141);
    self.num.text = @"0/100";
    self.num.textAlignment = NSTextAlignmentRight;
    self.num.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    [self.num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.centerY.mas_equalTo(lbone);
        make.width.mas_equalTo(KFit_W6S(150));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    
    UIImageView *imgback = [[UIImageView alloc] init];
    [imgback setImage:[UIImage imageNamed:@"box"]];
    [self.backview addSubview: imgback];
    [imgback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(lbone.mas_bottom).mas_offset(KFit_H6S(30));
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(185));
    }];
    
    self.note = [[UITextView alloc] init];
    [self.backview addSubview:self.note];
    self.note.placeholder = @"请输入备注内容";
    self.note.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    self.note.delegate = self;
    self.note.text = _model.memo;
    [self.note mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgback).mas_offset(KFit_H6S(30));
        make.left.mas_equalTo(imgback).mas_offset(KFit_W6S(25));
        make.bottom.mas_equalTo(imgback).mas_offset(-KFit_H6S(30));
        make.right.mas_equalTo(imgback).mas_offset(-KFit_W6S(25));
    }];
    
    UILabel *linefour = [[UILabel alloc] init];
    [self.backview addSubview:linefour];
    linefour.backgroundColor = kColor_N(240, 240, 240);
    [linefour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgback.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(25));
    }];
    
    XLInformationV *lbtwo = [[XLInformationV alloc] informationStudentsWithTitle:@"补考次数"];
    [self.backview addSubview:lbtwo];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(linefour.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(85));
    }];
    
    self.bukao = [[UITextField alloc] init];
    [self.backview addSubview:self.bukao];
    self.bukao.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    self.bukao.textAlignment = NSTextAlignmentRight;
    self.bukao.placeholder = @"请输入补考次数";
    self.bukao.keyboardType=UIKeyboardTypeNumberPad;
    self.bukao.delegate = self;
    if (_model.failNum) {
        self.bukao.text =[NSString stringWithFormat:@"%d",_model.failNum];
    }
    [self.bukao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lbtwo);
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(250), KFit_H6S(40)));
    }];
    
    UILabel *linefive = [[UILabel alloc] init];
    [self.backview addSubview:linefive];
    linefive.backgroundColor = kColor_N(240, 240, 240);
    [linefive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lbtwo.mas_bottom);
        make.left.right.mas_equalTo(self.backview);
        make.height.mas_equalTo(KFit_H6S(25));
    }];
    
    XLInformationV *lbthree = [[XLInformationV alloc] informationStudentsWithTitle:@"报名信息"];
    [self.backview addSubview:lbthree];
    [lbthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(linefive.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(85));
    }];
    
    
    UIButton *chakan = [[UIButton alloc] init];
    [self.backview addSubview:chakan];
    [chakan setTitle:@"查看 >" forState:UIControlStateNormal];
    [chakan addTarget:self action:@selector(toStudentDetailsVC) forControlEvents:UIControlEventTouchUpInside];
    chakan.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [chakan setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [chakan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.top.mas_equalTo(linefive.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(85));
        make.width.mas_equalTo(KFit_W6S(110));
    }];
}
- (void)toStudentDetailsVC{
    StudentDetailsVC *vc = [[StudentDetailsVC alloc] init];
    NSDictionary *dic = _model.student;
    FMMainModel *model = [FMMainModel mj_objectWithKeyValues:dic];
    vc.model = model;
    vc.model.coachName = _model.coachName;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)chooseKM{
    [CGXPickerView showStringPickerWithTitle:@"请选择科目" DataSource:@[@"科目一",@"科目二",@"科目三",@"科目四",@"拿证",@"作废（补考五次挂科）"] DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@  %@",selectValue,selectRow);
        int i= [selectRow intValue];
        [self.state setTitle:[self ButTitleWith:(++i)] forState:UIControlStateNormal];
        self.state.tag = i;
    }];
}


- (NSString *)ButTitleWith:(int)progress{
    NSString *str;
    switch (progress) {
        case 1:
            str = @"科一 ▾";
            break;
        case 2:
            str = @"科二 ▾";
            break;
        case 3:
            str = @"科三 ▾";
            break;
        case 4:
            str = @"科四 ▾";
            break;
        case 5:
            str = @"拿证 ▾";
            break;
        case 6:
            str = @"作废 ▾";
            
            break;
            
        default:
            break;
    }
    return str;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark -内容输入框的代理===================================================
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    NSInteger caninputlen = MAX_LIMIT_NUMS - comcatstr.length;
    
    if (caninputlen >= 0)
    {
        return YES;
    }
    else
    {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        
        if (rg.length > 0)
        {
            NSString *s = [text substringWithRange:rg];
            
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        self.num.text = [NSString stringWithFormat:@"%d/%d",MAX_LIMIT_NUMS,MAX_LIMIT_NUMS];
        return NO;
    }
    
}


- (void)textViewDidChange:(UITextView *)textView
{
    NSString  *nsTextContent = textView.text;
    NSInteger existTextNum = nsTextContent.length;
    
    if (existTextNum >= MAX_LIMIT_NUMS)
    {
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:MAX_LIMIT_NUMS];
        self.num.text = [NSString stringWithFormat:@"%d/%d",MAX_LIMIT_NUMS,MAX_LIMIT_NUMS];
        [textView setText:s];
    }
    
    //不让显示负数
    self.num.text = [NSString stringWithFormat:@"%ld/%d",existTextNum,MAX_LIMIT_NUMS];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)laodTages{
    NSString *url =POSTTagList;
//    NSDictionary *dic = @{@"tagTitle":tage,@"type":@"2"};
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSArray *arr = responseObject[@"data"][@"rows"];
            for (NSDictionary *dic in arr) {
                TageModel *model = [TageModel mj_objectWithKeyValues:dic];
                [self.dataArr addObject:model];
                
            }
            [self.studentlb.dataArr addObjectsFromArray:self.dataArr];
            [self.studentlb relodData];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}


- (void)teamStuStateEdit{
    [MBProgressHUD showLoadingHUD:@"正在保存"];
    NSString *url =POSTTeamStuStateEdit;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)self.state.tag] forKey:@"progress"];
    [dic setObject:[self.studentlb.selectDataArrNew componentsJoinedByString:@","] forKey:@"stuTags"];
    [dic setObject:self.bukao.text forKey:@"failNum"];
    [dic setObject:self.note.text forKey:@"memo"];
    [dic setObject:_model.idid forKey:@"id"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        [MBProgressHUD hideHUD];
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showMsgHUD:@"保存成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)dianhua{
    if (_model.student[@"studentPhone"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",_model.student[@"studentPhone"]]]];
    }
}




//设置文本框只能输入数字

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //如果是限制只能输入数字的文本框
    return [self validateNumber:string];
    
}

- (BOOL)validateNumber:(NSString*)number {
    
    BOOL res =YES;
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    
    int i =0;
    
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i,1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length ==0) {
            res =NO;
            break;
        }
        i++;
    }
    return res;
}



@end
