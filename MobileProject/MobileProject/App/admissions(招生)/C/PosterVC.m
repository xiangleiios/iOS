//
//  PosterVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/10/8.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "PosterVC.h"
#import "CGXPickerView.h"
#import "XLCache.h"
#import "MyPosterVC.h"
#import "UIImage+LXQRCode.h"
#define BUT_W KFit_W6S(150)
@interface PosterVC ()<UIImagePickerControllerDelegate>
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)XLView *backview;
@property (nonatomic , strong)UITextView *content;
@property (nonatomic , strong)XLView *imgBackView;
@property (nonatomic , strong)UIButton *UpAttachment;

@property (nonatomic , strong)NSMutableArray *imageviewArr;
@property (nonatomic ,strong)NSMutableArray *butarr;
@property (nonatomic ,strong)NSMutableArray *imgarr;

@property (nonatomic , strong)UILabel *jiaxiao;

@property (nonatomic , strong)NSMutableArray *titleArr;
@property (nonatomic , strong)NSMutableArray *idArr;
@property (nonatomic , strong)NSMutableArray *teamNameArr; //分队名数组
@property (nonatomic , strong)NSMutableArray *nameArr;
@property (nonatomic , strong)NSMutableArray *deptIdArr;
@property (nonatomic , strong)NSString *headurl;//头像

@property (nonatomic , strong)UIButton *save;//保存
@end

@implementation PosterVC
- (NSMutableArray *)butarr{
    if (_butarr==nil) {
        _butarr=[NSMutableArray array];
    }
    return _butarr;
}
- (NSMutableArray *)deptIdArr{
    if (_deptIdArr == nil) {
        _deptIdArr = [NSMutableArray array];
    }
    return _deptIdArr;
}

- (NSMutableArray *)teamNameArr{
    if (_teamNameArr == nil) {
        _teamNameArr = [NSMutableArray array];
    }
    return _teamNameArr;
}

- (NSMutableArray *)nameArr{
    if (_nameArr == nil) {
        _nameArr = [NSMutableArray array];
    }
    return _nameArr;
}
- (NSMutableArray *)titleArr{
    if (_titleArr == nil) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}
- (NSMutableArray *)idArr{
    if (_idArr == nil) {
        _idArr = [NSMutableArray array];
    }
    return _idArr;
}
- (NSMutableArray *)imgarr{
    if (_imgarr==nil) {
        _imgarr=[NSMutableArray array];
    }
    return _imgarr;
}
- (NSMutableArray *)imageviewArr{
    if (_imageviewArr==nil) {
        _imageviewArr=[NSMutableArray array];
    }
    return _imageviewArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationView setTitle:@"编辑招生海报"];
    [self loadScroll];
    [self loadSub];
    [self loadBut];
    // Do any additional setup after loading the view.
}
#pragma mark - 生成海报按钮
- (void)loadBut{
    self.save = [[UIButton alloc] init];
    [self.view addSubview:self.save];
    self.save.layer.cornerRadius = kFit_Font6(5);
    self.save.layer.masksToBounds = YES;
    [self.save setTitle:@"保存" forState:UIControlStateNormal];
    [self.save setBackgroundImage:[UIImage createImageWithColor:kColor_N(0, 112, 234)] forState:UIControlStateNormal];
    [self.save setBackgroundImage:[UIImage createImageWithColor:kRGBAColor(0, 112, 234, 0.6)] forState:UIControlStateHighlighted];
    [self.save addTarget:self action:@selector(erweima  ) forControlEvents:UIControlEventTouchUpInside];
    [self.save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(30));
        make.right.bottom.mas_equalTo(self.view).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(90));
    }];
}


- (void)erweima{
    NSString *str = [NSString stringWithFormat:XIAOCHENGXUEWM,[NSString stringWithFormat:@"%ld",(long)self.jiaxiao.tag]];
    UIImage *logImage =[UIImage LX_ImageOfQRFromURL:str codeSize:KFit_W6S(400) logoName:@"erwim_ewm" radius:KFit_W6S(40) borderWidth:3 borderColor:[UIColor whiteColor]];
//    UIImage *logImage = [UIImage LX_ImageOfQRFromURL:str codeSize:KFit_W6S(400)];
    [self uploadEWMPictures:logImage];
}
#pragma mark -调用保存接口
- (void)laodSave{
    if (![self.idArr containsObject:[NSNumber numberWithInteger:self.jiaxiao.tag]]) {
        [MBProgressHUD showMsgHUD:@"请选择驾校"];
        return;
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"2" forKey:@"type"];
    NSInteger i = [self.idArr indexOfObject:[NSNumber numberWithInteger:self.jiaxiao.tag]];
    KKLog(@"-----------------------%d",i);
    [dic setValue:self.content.text forKey:@"content"];//类容
    [dic setValue:self.model.moduleCode forKey:@"resource"];//模板编号
    [dic setValue:@"" forKey:@"userImg"];
    [dic setValue:self.deptIdArr[i] forKey:@"userSign"];
    [dic setValue:self.nameArr[i] forKey:@"userName"];
    [dic setValue:@"1" forKey:@"userType"];
    [dic setValue:[self.imgarr componentsJoinedByString:@","] forKey:@"imgUrl"];
//    [MBProgressHUD showLoadingHUD:@"正在保存"];
    [FMNetworkHelper fm_request_postWithUrlString:POSTPostAdd isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showMsgHUD:@"保存成功"];
            MyPosterVC *vc = [[MyPosterVC alloc] init];
            vc.idid = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
            vc.shareTitle = self.model.tittle;
            vc.shareContent = self.content.text;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingHUD];
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
    
}





- (void)loadScroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(kNavBarH);
    }];
    
    self.backview = [[XLView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scroll addSubview:self.backview];
}

- (void)loadSub{
    self.content = [[UITextView alloc] init];
    [self.backview addSubview:self.content];
    self.content.text = self.model.content;
    self.content.font = [UIFont systemFontOfSize:kFit_Font6(17)];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.backview).mas_offset(KFit_H6S(30));
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(280));
    }];
    
    self.imgBackView = [[XLView alloc] init];
    self.imgBackView.backgroundColor = [UIColor whiteColor];
    [self.backview addSubview:self.imgBackView];
    
    self.UpAttachment=[[UIButton alloc]initWithFrame:CGRectMake(KFit_W6S(30), KFit_W6S(30), BUT_W, BUT_W)];
    [self.UpAttachment setImage:[UIImage imageNamed:@"add_photo"] forState:UIControlStateNormal];
    [self.UpAttachment addTarget:self action:@selector(changeUp) forControlEvents:UIControlEventTouchUpInside];
    [self.imgBackView addSubview:self.UpAttachment];

    
    [self.imgBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(self.content.mas_bottom).mas_offset(KFit_H6S(50));
        make.height.mas_equalTo([self.imgBackView getLayoutCellHeightWithFlex:KFit_H6S(30)]);
    }];
    NSArray  *array = [_model.imgUrl componentsSeparatedByString:@","];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:array];
    if (self.type) {
        [arr removeLastObject];
    }

    for (int i = 0; i< arr.count; i ++) {
        [self.imgarr addObject:array[i]];
        UIImageView *img = [[UIImageView alloc] init];
        [img sd_setImageWithURL:[NSURL URLWithString:KURLIma(array[i])]];
        [self.imageviewArr addObject:img];
    }
    [self loadimgview];
    
    UILabel *lb = [[UILabel alloc] init];
    [self.backview addSubview:lb];
    lb.text = @"请上传大小在2M以内的图片，最多可添加9张图片";
    lb.textColor = kColor_N(200, 200, 200);
    lb.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imgBackView.mas_bottom);
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
        make.right.mas_equalTo(self.backview).mas_offset(-KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    self.jiaxiao = [[UILabel alloc] init];
    [self.backview addSubview:self.jiaxiao];
    
    self.jiaxiao.textColor = kColor_N(120, 127, 148);
    self.jiaxiao.font = [UIFont systemFontOfSize:kFit_Font6(16)];
    self.jiaxiao.layer.borderWidth = 0.5;
    self.jiaxiao.layer.borderColor = kColor_N(223, 226,236).CGColor;
    

    [self.jiaxiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lb.mas_bottom).mas_offset(KFit_H6S(40));
        make.left.mas_equalTo(self.backview).mas_offset(KFit_W6S(30));
        make.width.mas_equalTo(KFit_W6S(380));
        make.height.mas_equalTo(KFit_H6S(50));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [but setImage:[UIImage imageNamed:@"down_click"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(chooseJX) forControlEvents:UIControlEventTouchUpInside];
    [self.backview addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.jiaxiao);
        make.right.mas_equalTo(self.jiaxiao).mas_offset(-KFit_W6S(5));
        make.height.width.mas_equalTo(KFit_W6S(40));
    }];
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
}


- (void)chooseJX{
    [CGXPickerView showStringPickerWithTitle:@"报考驾校" DataSource:[XLCache singleton].teamCode_title DefaultSelValue:nil IsAutoSelect:NO ResultBlock:^(id selectValue, id selectRow) {
        NSLog(@"%@",selectValue);
        self.jiaxiao.text = [NSString stringWithFormat:@"%@ (%@)",self.titleArr[[selectRow intValue]],self.teamNameArr[[selectRow intValue]]];
        self.jiaxiao.tag = [[XLCache singleton].schoolDeptId[[selectRow intValue]] intValue];
        NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
        // 头部缩进
        style.headIndent = KFit_W6S(20);
        style.firstLineHeadIndent = KFit_W6S(20);
        NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.jiaxiao.text attributes:@{ NSParagraphStyleAttributeName : style}];
        self.jiaxiao.attributedText = attrText;
        NSLog(@"%@",[XLCache singleton].teamCode_value[[selectRow intValue]]);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [self loaddetail];
}
- (void)loaddetail{
    
    [FMNetworkHelper fm_request_postWithUrlString:[NSString stringWithFormat:@"%@?id=%@",_url,_model.idid] isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSArray *arr = responseObject[@"data"][@"enrollist"];
            for (NSDictionary *dic in arr) {
                [self.idArr addObject:dic[@"id"]];
                [self.titleArr addObject:dic[@"schoolName"]];
                [self.nameArr addObject:dic[@"name"]];
                [self.teamNameArr addObject:dic[@"deptName"]];
                [self.deptIdArr addObject:dic[@"deptId"]];
                self.headurl = [NSString stringWithFormat:@"%@",dic[@"headImg"]];
            }
            self.jiaxiao.text = [NSString stringWithFormat:@"%@ (%@)",[self.titleArr firstObject],[self.teamNameArr firstObject]];
            self.jiaxiao.tag =  [[self.idArr firstObject] intValue];
            NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            // 头部缩进
            style.headIndent = KFit_W6S(20);
            style.firstLineHeadIndent = KFit_W6S(20);
            NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:self.jiaxiao.text attributes:@{ NSParagraphStyleAttributeName : style}];
            self.jiaxiao.attributedText = attrText;
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}








#pragma mark - 要上传的图片显示；
- (void)loadimgview{
    
    int j=0;
    for (int i=0; i<self.imageviewArr.count; i++) {
        UIImageView *imgv= self.imageviewArr[i];
        imgv.frame=CGRectMake(i%3*(KFit_W6S(20)+BUT_W)+ KFit_W6S(30),i/3*(KFit_W6S(20)+BUT_W)+ KFit_W6S(30), BUT_W, BUT_W);;
        [self.imgBackView addSubview:imgv];
        /*删除按钮 */
        UIButton *but=[[UIButton alloc]init];
        [self.backview addSubview:but];
        [but mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(imgv).mas_offset(-KFit_H6S(35));
            make.left.mas_equalTo(imgv.mas_right).mas_offset(-KFit_H6S(35));
            make.width.height.mas_equalTo(KFit_H6S(80));
        }];
        [but setImage:[UIImage imageNamed:@"delete_red_icon"] forState:UIControlStateNormal];
        //        but.backgroundColor = [UIColor redColor];
        but.tag=i;
        [but addTarget:self action:@selector(deleteimgdata:) forControlEvents:UIControlEventTouchUpInside];
        [self.butarr addObject:but];
        j++;
    }
    
    if (j >= 8) {
        self.UpAttachment.hidden = YES;
    }else{
        self.UpAttachment.hidden = NO;
        self.UpAttachment.frame=CGRectMake(j%3*(KFit_W6S(20)+BUT_W) + KFit_W6S(30),j/3*(KFit_W6S(20)+BUT_W)+ KFit_W6S(30), BUT_W, BUT_W);
    }
    
    [self.imgBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backview);
        make.top.mas_equalTo(self.content.mas_bottom).mas_offset(KFit_H6S(50));
        make.height.mas_equalTo([self.imgBackView getLayoutCellHeightWithFlex:KFit_H6S(30)]);
    }];
    
    self.backview.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backview getLayoutCellHeightWithFlex:KFit_H6S(60)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backview.frame));
}
#pragma mark -删除图片和数据
- (void)deleteimgdata:(UIButton *)sender{
    for (UIImageView *imgv in self.imageviewArr) {
        [imgv removeFromSuperview];
    }
    for (UIButton *but in self.butarr) {
        [but removeFromSuperview];
    }
    [self.imgarr removeObjectAtIndex:sender.tag];
    [self.imageviewArr removeObjectAtIndex:sender.tag];
    [self loadimgview];
}

- (void)changeUp{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请选择添加途径" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //        NSLog(@"取消");
        [self PhotoLibrary];
    }];
    
    UIAlertAction *cancelBtXJ = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self xiangji];
        NSLog(@"取消");
        
    }];
    //添加确定
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定");
        
    }];
    //设置`确定`按钮的颜色
    //    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    //将action添加到控制器
    [alertVc addAction:cancelBtn];
    [alertVc addAction:cancelBtXJ];
    [alertVc addAction :sureBtn];
    //展示
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
}


///
- (void)xiangji{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView * alerr = [[UIAlertView alloc]initWithTitle:@"警告!" message:@"未找到该硬件设备或设备已损坏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alerr show];
    }else{
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    //利用模态进行调用系统框架
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    
}
//照片库
- (void)PhotoLibrary{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];;
}

#pragma mark -相册代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    KKLog(@"%@    ----- %@",picker,info);
    [self uploadPictures:info[UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)uploadPictures:(UIImage *)image{
    [MBProgressHUD showLoadingHUD:@"正在上传图片"];
    
    
    NSString *url = POSTUpLoadFile;
    
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[User UserOb].token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:@"Mobile" forHTTPHeaderField:@"loginType"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.1) name:@"file" fileName:@"tupian.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功返货=============%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic =responseObject[@"data"][@"data"];
            [self.imgarr addObject:dic[@"url"]];
            UIImageView *img = [[UIImageView alloc] init];
            [img sd_setImageWithURL:[NSURL URLWithString:dic[@"img"]]];
            [self.imageviewArr addObject:img];
            for (UIImageView *imgv in self.imageviewArr) {
                [imgv removeFromSuperview];
            }
            for (UIButton *but in self.butarr) {
                [but removeFromSuperview];
            }
            [self loadimgview];
            
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideLoadingHUD];
    }];
}



#pragma mark - 上传二维码
- (void)uploadEWMPictures:(UIImage *)image{
    [MBProgressHUD showLoadingHUD:@"正在保存"];
    
    
    NSString *url = POSTUpLoadFile;
    
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[User UserOb].token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:@"Mobile" forHTTPHeaderField:@"loginType"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.1) name:@"file" fileName:@"tupian.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功返货=============%@",responseObject);
//        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic =responseObject[@"data"][@"data"];
            [self.imgarr addObject:dic[@"url"]];
            [self laodSave];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideLoadingHUD];
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
