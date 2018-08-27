//
//  CommentController.m
//  MobileProject
//
//  Created by zsgy on 17/2/28.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import "CommentController.h"
#import "CommentBtn.h"
#import "CommentsModel.h"
#import "XLCommentCell.h"
static int pag=1;
@interface CommentController ()<CommentBtnDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UIImageView * img;
}
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray *datarr;
@property (nonatomic , strong)CommentTextView * commentTextView;
@property (nonatomic , strong)MBProgressHUD *waitHud;
@end

@implementation CommentController

- (NSMutableArray *)datarr{
    if (_datarr==nil) {
        _datarr=[NSMutableArray array];
    }
    return _datarr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论列表";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * button = [UIButton CreateCoustemBtn:@"返回" Image:@"back"];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
    [self addTabelView];
    [self addCommentBtn];
    [self lodata];
    // Do any additional setup after loading the view.
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addTabelView{
    

    self.table=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    switch (self.comefrom) {
        case ComeFromH5:
        {
            self.table.y = 64;
            self.table.height = kScreenH -64;
        }
            break;
            
        default:
            break;
    }
    
    self.table.delegate=self;
    self.table.dataSource=self;
    self.table.backgroundColor=[UIColor clearColor];//[UIColor colorWithRed:237/255.0 green:238/255.0 blue:239/255.0 alpha:0];
    self.table.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.table];
    self.table.mj_header=[XLHeader headerWithRefreshingBlock:^{
        pag=1;
        [self lodata];
    }];
    self.table.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        pag++;
        [self lodata];
    }];
}

#pragma mark-加载数据
- (void)lodata{
//    AFNRequest *httpRequest = [AFNRequest sharedInstance];
//    [httpRequest GET:url dict:nil succeed:^(id responseObject) {
//        if (pag==1) {
//            [self.datarr removeAllObjects];
//        }
//        NSArray *arr=responseObject[@"data"];
//        for (NSDictionary *dic in arr) {
//            CommentsModel *model=[[CommentsModel alloc]init];
//            [model setValuesForKeysWithDictionary:dic];
//            model.ID=dic[@"id"];
//            [self.datarr addObject:model];
//        }
//        if (self.datarr.count>0) {
//            img.hidden = YES;
//        }
//        [self.table.mj_header endRefreshing];
//        [self.table.mj_footer endRefreshing];
//        [self.table reloadData];
//    } failure:^(NSError *error) {
//        KKLog(@"%@", error);
//        [self.table.mj_header endRefreshing];
//        [self.table.mj_footer endRefreshing];
//    }];
}

- (void)addCommentBtn
{
    CommentBtn * btn = [[CommentBtn alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50, [UIScreen mainScreen].bounds.size.width,50)];
    btn.delegate = self;
    [self.view addSubview:btn];
    _commentBtn = btn;
    /*
     *输入框要改掉。
     */
    [_commentBtn.butcollection removeFromSuperview];
    [_commentBtn.butshare removeFromSuperview];
    [_commentBtn.btn removeFromSuperview];
    [_commentBtn.comment removeFromSuperview];
    _commentBtn.textbut.frame=CGRectMake(15, 5, [UIScreen mainScreen].bounds.size.width-30, 50-10);
    [_commentBtn.textbut addTarget:self action:@selector(qinglunpushCommentViewController) forControlEvents:UIControlEventTouchUpInside];
    _commentBtn.textbut.titleLabel.text=@"";
    [_commentBtn.textbut setTitle:@"说点什么" forState:UIControlStateNormal];
    _commentBtn.textbut.titleEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
    
}

#pragma mark-弹出评论框
- (void)qinglunpushCommentViewController
{
    if (![[User UserOb] UserLogin]) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请先登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alertView show];
        return;
    }
    _commentTextView = [[CommentTextView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _commentTextView.delegate = _commentBtn;
    NSLog(@"====================%@",_commentBtn.textbut.titleLabel.text);
    
    
    _commentTextView.text = _commentBtn.textbut.titleLabel.text;
    _commentTextView.text=@"";
    [_commentTextView.mainTextView.button addTarget:self action:@selector(comBtn_cilck) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_commentTextView];
    _commentTextView.mainTextView.textView.delegate = self;
    [_commentTextView.mainTextView.textView becomeFirstResponder];
}

#pragma mark-发布评论
- (void)comBtn_cilck
{
    if (![[User UserOb] UserLogin]) {
        UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"请先登录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
        [alertView show];
        return;
    }
    User* bean = [User UserOb];
    if ([_commentBtn.textbut.titleLabel.text isEqualToString:@"说点什么"]||[_commentBtn.textbut.titleLabel.text isEqualToString:@""]) {
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"请写评论！";
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:1];
        return;
    }
    
    _waitHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _waitHud.labelText = @"正在评论";
    NSString *url=[NSString stringWithFormat:GETcommentsCreate,@"2",self.ID,_commentBtn.textbut.titleLabel.text,bean.token];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        _waitHud.hidden = YES;
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD  showAutoMessage:@"评论成功"];
            pag=1;
            [self lodata];
        }else{
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"检测账您号其他设备登陆，您被迫下线" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"登录", nil];
            [[User UserOb] UserQuit];
            [alertView show];
        }
        [_commentBtn.textbut setTitle:@"说点什么" forState:UIControlStateNormal];
        _commentBtn.textbut.titleLabel.text=@"说点什么";
    } failureBlock:^(NSError *error) {
        _waitHud.hidden = YES;
        [MBProgressHUD  showAutoMessage:@"评论失败"];
    } progress:nil];
}

#pragma mark - UITextFiledDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self registerForKeyboardNotifications];
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    //释放
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)registerForKeyboardNotifications
{
    //使用NSNotificationCenter 鍵盤出現時
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
}

//实现当键盘出现的时候计算键盘的高度大小。用于输入框显示位置
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;//得到鍵盤的高度
    NSLog(@"hight_hitht:%f",kbSize.height);
    CGFloat keyboardH = kbSize.height;
    
    CGFloat x = self.view.frame.size.height-CGRectGetHeight(_commentTextView.mainTextView.frame)-keyboardH;
    
    [UIView animateWithDuration:0.5 animations:^{
        _commentTextView.mainTextView.frame = CGRectMake(0, x, _commentTextView.mainTextView.frame.size.width, _commentTextView.mainTextView.frame.size.height);
    }];
}

#pragma mark-tableview代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datarr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XLCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[XLCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    CommentsModel * model = [self.datarr objectAtIndex:indexPath.row];
    cell.nameLabel.text = model.nick_name;
    if (model.nick_name==nil) {
        cell.nameLabel.text=model.member_name;
    }
    cell.contentLabel.text = model.content;
    /*
     *这个地方还是要计算文本高度
     */
    CGSize maxSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width-20, MAXFLOAT);
    
    CGFloat textH = [model.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil].size.height;
    cell.contentLabel.frame=CGRectMake(60, 55, [[UIScreen mainScreen] bounds].size.width-70, textH);
    
    cell.blab.frame=CGRectMake(0, textH+65, [[UIScreen mainScreen] bounds].size.width, 1);
    
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* date = [formatter dateFromString:model.time];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    cell.timeLabel.text =[formatter stringFromDate:date];;
    [cell.imgview sd_setImageWithURL:[NSURL URLWithString:model.avatar_url]];
    if ([FMRegExpTool fm_checkingMobile:cell.nameLabel.text]) {
        NSMutableString * str = [NSMutableString stringWithString:cell.nameLabel.text];
        if (str.length>6) {
            NSMutableString * starStr = [[NSMutableString alloc]init];
            NSRange range = NSMakeRange(3, str.length-6);
            for (NSInteger num =0; num<4; num++) {
                [starStr appendString:@"*"];
            }
            [str replaceCharactersInRange:range withString:starStr];
        }
        cell.nameLabel.text = str;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsModel * model = [self.datarr objectAtIndex:indexPath.row];
    CGSize maxSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width-70, MAXFLOAT);
    
    CGFloat textH = [model.content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18]} context:nil].size.height;
    
    return textH+65+1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 30)];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 7, 25)];
    lab.backgroundColor=[UIColor colorWithRed:236/255.0 green:81/255.0 blue:81/255.0 alpha:1];
    [view addSubview:lab];
    
    UILabel *nam=[[UILabel alloc]initWithFrame:CGRectMake(25, 5, 50, 25)];
    nam.text=@"评论";
    nam.font=[UIFont systemFontOfSize:kFit_Font6(15) weight:1];
    [view addSubview:nam];
    
    UILabel *labt=[[UILabel alloc]initWithFrame:CGRectMake(80, 15, kScreenW-90, 1)];
    labt.backgroundColor=[UIColor colorWithWhite:220/255.0 alpha:1];
    [view addSubview:labt];
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        
    }
}

@end
